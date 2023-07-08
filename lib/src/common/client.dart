import 'dart:async';
import 'dart:convert';

import 'package:legendary/legendary.dart';

final class VerifyProgress {
  final int currentPart;
  final int totalParts;
  final double percentage;
  final double speed;
  final String unit;

  const VerifyProgress(
      {required this.currentPart,
      required this.totalParts,
      required this.percentage,
      required this.speed,
      required this.unit});
}

/// Given by `ILegendaryBaseClient` to get `stdout`, `stderr`, `progress`, and `error` combined
final class Result<T> {
  final Stream<List<int>> stdout;
  final Stream<List<int>> stderr;
  final FutureOr<T> data;

  /// Use after progress stream closes to check for errors
  final Future<CommonError?>? error;

  const Result(
      {required this.stdout,
      required this.stderr,
      required this.data,
      this.error});
}

enum CommonError {
  alreadyInstalled,
  notInstalled,
  pathNotExist,
  gameNotExist,

  /// describes cases where a specific error hasn't been found, however no data was found either
  notSuccesful
}

final class InstallProgress {
  final double percentage;
  final int currentPart;
  final int totalParts;
  final Duration runningFor;
  final Duration estimatedTimeOfArrival;

  const InstallProgress(
      {required this.percentage,
      required this.currentPart,
      required this.totalParts,
      required this.runningFor,
      required this.estimatedTimeOfArrival});
}

/// LegendaryProcess is an abstraction of processes
final class LegendaryProcess {
  final Stream<List<int>> stdout;
  final Stream<List<int>> stderr;

  const LegendaryProcess({required this.stdout, required this.stderr});
}

/// The abstract interface for all Legendary clients
/// created so that clients aren't allowed to use `getStream` and separation of concerns
abstract class ILegendaryBaseClient {
  Future<Result<InstalledGame>> info(String appName);
  Future<Result<List<Game>>> list();
  Future<Result<List<InstalledGame>>> listInstalled();
  Future<LegendaryProcess> launch(String appName);
  Future<Result<Stream<InstallProgress>>> install(String appName, String path);
  Future<void> move(String appName, String path);
  Future<Result<Status>> status();
  Future<void> uninstall(String appName);
  Future<void> setLogin(String code, {String? sid, String? token});
  Future<void> deleteLogin();
  Future<void> cleanup();
  Future<void> import(String appName, String location);
  Future<Result<Stream<VerifyProgress>>> verify(String appName);
}

/// The abstract class from which most clients derive from
///
/// All of the methods derive from the [getStream] method, which you must implement.
abstract class LegendaryBaseClient implements ILegendaryBaseClient {
  /// Runs a legendary process and get its result
  ///
  /// Must be implemented by child clients.
  Future<LegendaryProcess> getStream(List<String> arguments);

  @override
  Future<Result<InstalledGame>> info(String appName) async {
    final stream = await getStream(["info", appName]);

    Future<InstalledGame> getGameInfo() async {
      final total =
          (await stream.stdout.transform(utf8.decoder).toList()).join();

      final json = jsonDecode(total);

      return InstalledGame.fromJson(Map<String, dynamic>.from(json));
    }

    return Result(
        stdout: stream.stdout,
        stderr: stream.stderr,
        data: await getGameInfo());
  }

  @override
  Future<Result<List<Game>>> list() async {
    final stream = await getStream(["list"]);

    Future<List<Game>> getList() async {
      final total =
          (await stream.stdout.transform(utf8.decoder).toList()).join();

      final json = jsonDecode(total);

      return GameList.fromList(List<dynamic>.from(json));
    }

    return Result(
        stdout: stream.stdout, stderr: stream.stderr, data: getList());
  }

  @override
  Future<Result<List<InstalledGame>>> listInstalled() async {
    final stream = await getStream(["list-installed"]);

    Future<List<InstalledGame>> getList() async {
      final total =
          (await stream.stdout.transform(utf8.decoder).toList()).join();

      final json = jsonDecode(total);

      return InstalledGameList.fromList(List<dynamic>.from(json));
    }

    return Result(
        stdout: stream.stdout, stderr: stream.stderr, data: getList());
  }

  @override
  Future<Result<Stream<InstallProgress>>> install(
      String appName, String path) async {
    final stream = await getStream(
        ["install", appName, path, "--skip-sdl", "--with-dlcs"]);
    final controller = StreamController<InstallProgress>();

    stream.stdout.transform(utf8.decoder).listen((line) {
      final exp = RegExp(
          r"^\[DLManager\] INFO: = Progress: (\d+\.\d+)% \((\d+)\/(\d+)\), Running for (\d+):(\d+):(\d+), ETA: (\d+):(\d+):(\d+)",
          caseSensitive: false);

      final matches = exp.firstMatch(line);
      final percentage = matches?.group(1);
      final currentPart = matches?.group(2);
      final totalParts = matches?.group(3);
      final runningForHours = matches?.group(4)!;
      final runningForMinutes = matches?.group(5)!;
      final runningForSeconds = matches?.group(6)!;
      final estimatedTimeOfArrivalHours = matches?.group(7)!;
      final estimatedTimeOfArrivalMinutes = matches?.group(8)!;
      final estimatedTimeOfArrivalSeconds = matches?.group(9)!;

      if (percentage == null ||
          currentPart == null ||
          totalParts == null ||
          runningForHours == null ||
          runningForMinutes == null ||
          runningForSeconds == null ||
          estimatedTimeOfArrivalHours == null ||
          estimatedTimeOfArrivalMinutes == null ||
          estimatedTimeOfArrivalSeconds == null) {
        return;
      }

      controller.add(InstallProgress(
        percentage: double.parse(percentage),
        currentPart: int.parse(currentPart),
        totalParts: int.parse(totalParts),
        runningFor: Duration(
            hours: int.parse(runningForHours),
            minutes: int.parse(runningForMinutes),
            seconds: int.parse(runningForSeconds)),
        estimatedTimeOfArrival: Duration(
            hours: int.parse(estimatedTimeOfArrivalHours),
            minutes: int.parse(estimatedTimeOfArrivalMinutes),
            seconds: int.parse(estimatedTimeOfArrivalSeconds)),
      ));
    });

    return Result(
      stdout: stream.stdout,
      stderr: stream.stderr,
      data: controller.stream,
    );
  }

  @override
  Future<void> move(String appName, String path) async {
    final stream = await getStream(["move", appName, path]);

    await for (final line in stream.stderr.transform(utf8.decoder)) {
      if (line == "[cli] INFO: Finished.") return;
    }

    throw CommonError.notSuccesful;
  }

  @override
  Future<Result<Status>> status() async {
    final stream = await getStream(["status"]);

    Future<Status> getData() async {
      final total =
          (await stream.stdout.transform(utf8.decoder).toList()).join();
      final json = jsonDecode(total);

      return Status.fromJson(Map<String, dynamic>.from(json));
    }

    return Result(
        stdout: stream.stdout, stderr: stream.stderr, data: getData());
  }

  @override
  Future<void> uninstall(String appName) async {
    final stream = await getStream(["uninstall", appName]);

    await for (final line in stream.stderr.transform(utf8.decoder)) {
      if (line == "[cli] INFO: Game has been uninstalled.") return;
    }

    throw CommonError.notSuccesful;
  }

  @override
  Future<void> setLogin(String code, {String? sid, String? token}) async {
    final stream = await getStream(["auth", "--code", code]);

    await for (final line in stream.stderr.transform(utf8.decoder)) {
      if (line.startsWith("[cli] INFO: Successfully logged in as ")) return;
    }

    throw CommonError.notSuccesful;
  }

  @override
  Future<void> deleteLogin() async {
    final stream = await getStream(["auth", "--delete"]);

    await for (final line in stream.stderr.transform(utf8.decoder)) {
      if (line == "[cli] INFO: User data deleted.") return;
    }

    throw CommonError.notSuccesful;
  }

  @override
  Future<void> cleanup() async {
    final stream = await getStream(["cleanup"]);

    await for (final line in stream.stderr.transform(utf8.decoder)) {
      if (line == "[cli] INFO: Cleanup complete! Removed") return;
    }

    throw CommonError.notSuccesful;
  }

  @override
  Future<void> import(String appName, String location) async {
    final stream = await getStream(["import", appName, location]);

    await for (final line in stream.stderr.transform(utf8.decoder)) {
      if (line == '[cli] INFO: Game "$appName" has been imported.') return;
      if (line ==
          '[cli] ERROR: Could not find "$appName" in list of available games, did you type the name correctly?') {
        throw CommonError.gameNotExist;
      }
    }

    throw CommonError.notSuccesful;
  }

  @override
  Future<Result<Stream<VerifyProgress>>> verify(String appName) async {
    final stream = await getStream(["verify", appName]);

    // handles edge cases, ex. "game not installed"
    Future<CommonError?> getError() async {
      // Listen to stderr
      await for (final line in stream.stderr.transform(utf8.decoder)) {
        // if there is any error, return it
        if (line == '[cli] ERROR: Game "$appName" is not installed') {
          return CommonError.notInstalled;
        }
        final notExistRegExp = RegExp(
            r'\[cli\] ERROR: Install path "[a-zA-Z/\\]+" does not exist, make sure all necessary mounts are available\. If you previously deleted the game folder without uninstalling, run "legendary uninstall -y [a-zA-Z]+" and reinstall from scratch\.');
        if (notExistRegExp.hasMatch(line)) return CommonError.pathNotExist;
      }
      return null;
    }

    Stream<VerifyProgress> getProgress() {
      final controller = StreamController<VerifyProgress>();
      final exp = RegExp(
          r'^Verification progress: (\d+)\/(\d+)\s+\((\d+\.\d+)%\)\s+\[(\d+\.\d+)\s([a-z/]+)',
          caseSensitive: false);

      stream.stdout.transform(utf8.decoder).listen((line) {
        final matches = exp.firstMatch(line);
        final currentPart = matches?.group(1);
        final totalParts = matches?.group(2);
        final percentage = matches?.group(3);
        final speed = matches?.group(4);
        final unit = matches?.group(5);

        if (currentPart == null ||
            totalParts == null ||
            percentage == null ||
            speed == null ||
            unit == null) throw "some field is null (line: $line)";

        controller.add(VerifyProgress(
            currentPart: int.parse(currentPart),
            totalParts: int.parse(totalParts),
            percentage: double.parse(percentage),
            speed: double.parse(speed),
            unit: unit));
      });

      return controller.stream;
    }

    return Result<Stream<VerifyProgress>>(
        stdout: stream.stdout,
        stderr: stream.stderr,
        data: getProgress(),
        error: getError());
  }
}
