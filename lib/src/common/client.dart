import 'dart:convert';

import 'package:legendary/legendary.dart';
import 'package:legendary/src/common/watch_stream.dart';

class VerifyProgress {
  final int currentPart;
  final int totalParts;
  final double percentage;
  final double speed;
  final String unit;

  VerifyProgress(
      {required this.currentPart,
      required this.totalParts,
      required this.percentage,
      required this.speed,
      required this.unit});
}

/// The abstract interface for all Legendary clients
/// created so that clients aren't allowed to use `getStream` and separation of concerns
abstract class ILegendaryBaseClient {
  Future<InstalledGame> info(String appName);
  Future<List<Game>> list();
  Future<List<InstalledGame>> listInstalled();
  Future<LegendaryProcess> launch(String appName);
  Stream<int> install(String appName, String path);
  Stream<int> move(String appName, String path);
  Future<Status> status();
  Stream<int> uninstall(String appName);
  Future<void> setLogin(String code, {String? sid, String? token});
  Future<void> deleteLogin();
  Future<void> cleanup();
  Stream<int> import(String appName, String location);
  Stream<VerifyProgress> verify(String appName);
}

/// LegendaryProcess is an abstraction of processes
class LegendaryProcess {
  final Stream<String> stdout;
  final Stream<String> stderr;

  LegendaryProcess({required this.stdout, required this.stderr});
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
  Future<InstalledGame> info(String appName) async {
    final stream = await getStream(["info", appName]);
    final processedStream = await watchStreamAndReturnSum(stream.stdout);

    final json = jsonDecode(processedStream);

    return InstalledGame.fromJson(Map<String, dynamic>.from(json));
  }

  @override
  Future<List<Game>> list() async {
    final stream = await getStream(["list"]);
    final processedStream = await watchStreamAndReturnSum(stream.stdout);

    final json = jsonDecode(processedStream);

    return GameList.fromList(List<dynamic>.from(json));
  }

  @override
  Future<List<InstalledGame>> listInstalled() async {
    final stream = await getStream(["list-installed"]);
    final String processedStream = await watchStreamAndReturnSum(stream.stdout);

    final json = jsonDecode(processedStream);

    return InstalledGameList.fromList(List<dynamic>.from(json));
  }

  @override
  Stream<int> install(String appName, String path) async* {
    // TODO: implement install
    throw UnimplementedError();
  }

  @override
  Stream<int> move(String appName, String path) async* {
    // TODO: implement move
    throw UnimplementedError();
  }

  @override
  Future<Status> status() async {
    final stream = await getStream(["status"]);
    final processedStream = await watchStreamAndReturnSum(stream.stdout);

    final json = jsonDecode(processedStream);

    return Status.fromJson(Map<String, dynamic>.from(json));
  }

  @override
  Stream<int> uninstall(String appName) {
    // TODO: implement uninstall
    throw UnimplementedError();
  }

  @override
  Future<void> setLogin(String code, {String? sid, String? token}) async {
    final stream = await getStream(["auth", "--code", code]);
    final String successStatement = "[cli] INFO: Successfully logged in as ";

    return await watchStreamAndWatchForString(stream.stderr,
        string: successStatement);
  }

  @override
  Future<void> deleteLogin() async {
    final stream = await getStream(["auth", "--delete"]);
    const String successStatement = "[cli] INFO: User data deleted.";

    return await watchStreamAndWatchForString(
      stream.stderr,
      string: successStatement,
    );
  }

  @override
  Future<void> cleanup() async {
    final stream = await getStream(["cleanup"]);
    const String successStatement = "[cli] INFO: Cleanup complete! Removed";

    return await watchStreamAndWatchForString(stream.stderr,
        string: successStatement);
  }

  @override
  Stream<int> import(String appName, String location) {
    // TODO: implement import
    throw UnimplementedError();
  }

  @override
  Stream<VerifyProgress> verify(String appName) async* {
    final stream = await getStream(["verify", appName]);
    final exp = RegExp(
        r'^Verification progress: (\d+)\/(\d+)\s+\((\d+\.\d+)%\)\s+\[(\d+\.\d+)\s([a-z/]+)',
        caseSensitive: false);

    await for (final line in stream.stdout) {
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

      yield VerifyProgress(
          currentPart: int.parse(currentPart),
          totalParts: int.parse(totalParts),
          percentage: double.parse(percentage),
          speed: double.parse(speed),
          unit: unit);
    }
  }
}
