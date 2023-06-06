import 'dart:io';
import 'dart:convert';

import 'package:legendary/legendary.dart';

import 'package:legendary/src/io/watch_stream.dart';

class LegendaryClient extends BaseLegendaryClient {
  final String legendaryPath;
  final bool verbose;

  LegendaryClient({ required this.legendaryPath, this.verbose = false });

  Future<Process> _runLegendaryCommand(String command) {
    return Process.start(
      legendaryPath,
      [command, "--json"]
    );
  }

  @override
  Future<InstalledGame> info(String appName) async {
    final process = await _runLegendaryCommand("info $appName");
    final processStdout = process.stdout.transform(utf8.decoder);

    return await watchStream(input: processStdout, transform: (obj) {
        final json = jsonDecode(obj);

        if (json is! Map<String, dynamic>) throw "json is not a Map<String, dynamic>. it is a ${json.runtimeType}";

        return InstalledGame.fromJson(json);
      });
  }

  @override
  Future<List<Game>> list() async {
    final process = await _runLegendaryCommand("list");
    final processStdout = process.stdout.transform(utf8.decoder);

    return await watchStream<List<Game>>(
      input: processStdout,
      transform: (obj) {
        final json = jsonDecode(obj);
        if (json is! List) throw "json is not a List. it is a ${json.runtimeType}";
        return GameList.fromList(json);
      },
      verbose: verbose
    );
  }

  @override
  Future<List<InstalledGame>> listInstalled() async {
    final process = await _runLegendaryCommand("list-installed");
    final processStdout = process.stdout.transform(utf8.decoder);

    return await watchStream<List<InstalledGame>>(
      input: processStdout,
      transform: (obj) {
        if (verbose) stderr.write(obj);
        final json = jsonDecode(obj);
        if (json is! List) throw "json is not a List. it is a ${json.runtimeType}";
        return InstalledGameList.fromList(json);
      },
      verbose: verbose
    );
  }

  @override
  Stream<String> launch(String appName) async* {
    final process = await _runLegendaryCommand("launch $appName");
    final processStdout = process.stdout.transform(utf8.decoder);
    final processStderr = process.stderr.transform(utf8.decoder);

    yield* processStdout;
    yield* processStderr;
  }

  @override
  Stream<int> install(String appName) {
    // TODO: implement install
    throw UnimplementedError();
  }

  @override
  Stream<int> move(String appName, String path) {
    // TODO: implement move
    throw UnimplementedError();
  }

  @override
  Future<Status> status() async {
    final process = await _runLegendaryCommand("status");
    final processStdout = process.stdout.transform(utf8.decoder);

    return await watchStream(input: processStdout, transform: Status.fromJson);
  }

  @override
  Stream<int> uninstall(String appName) {
    // TODO: implement uninstall
    throw UnimplementedError();
  }

  @override
  Future<void> setLogin(String code, { sid, token }) async {
    final process = _runLegendaryCommand("auth --disable-webview --token $code");
    // TODO: implement setLogin
    throw UnimplementedError();
  }

  @override
  Future<void> deleteLogin() async {
    final process = await _runLegendaryCommand("auth --disable-webview --delete");
    final processStdout = process.stdout.transform(utf8.decoder);

    await for (final line in processStdout) {
      if (verbose) stderr.write(line);

      const String successStatement = "[cli] INFO: User data deleted.";
      if (!line.contains(successStatement)) {
        continue;
      }
      break;
    }
  }

  @override
  Future<void> cleanup() {
    // TODO: implement cleanup
    throw UnimplementedError();
  }

  @override
  Stream<int> import(String appName, String location) {
    // TODO: implement import
    throw UnimplementedError();
  }

  @override
  Stream<int> verify(String appName) {
    // TODO: implement verify
    throw UnimplementedError();
  }
}