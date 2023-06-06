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
      [...command.split(" "), "--json"]
    );
  }

  @override
  Future<InstalledGame> info(String appName) async {
    final process = await _runLegendaryCommand("info $appName");
    final processStdout = process.stdout.transform(utf8.decoder);

    final stream = await watchStreamAndReturnSum(processStdout);
    final json = jsonDecode(stream);

    if (json is! Map<String, dynamic>) throw "json is not a Map<String, dynamic>. it is a ${json.runtimeType}";

    return InstalledGame.fromJson(json);
  }

  @override
  Future<List<Game>> list() async {
    final process = await _runLegendaryCommand("list");
    final processStdout = process.stdout.transform(utf8.decoder);

    final stream = await watchStreamAndReturnSum(processStdout);
    final json = jsonDecode(stream);
    if (json is! List) throw "json is not a List. it is a ${json.runtimeType}";
    return GameList.fromList(json);
  }

  @override
  Future<List<InstalledGame>> listInstalled() async {
    final process = await _runLegendaryCommand("list-installed");
    final processStdout = process.stdout.transform(utf8.decoder);

    final String stream = await watchStreamAndReturnSum(processStdout);
    if (verbose) stderr.write(stream);
    final json = jsonDecode(stream);
    if (json is! List) throw "json is not a List. it is a ${json.runtimeType}";
    return InstalledGameList.fromList(json);
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

    return Status.fromJson(
      await watchStreamAndReturnSum(processStdout)
    );
  }

  @override
  Stream<int> uninstall(String appName) {
    // TODO: implement uninstall
    throw UnimplementedError();
  }

  @override
  Future<void> setLogin(String code, { sid, token }) async {
    final process = await _runLegendaryCommand("auth --disable-webview --code $code $sidString $tokenString");
    final processStderr = process.stderr.transform(utf8.decoder);

    final String successStatement = "[cli] INFO: Successfully logged in as ";

    return await watchStreamAndWatchForString(processStderr, string: successStatement);
  }

  @override
  Future<void> deleteLogin() async {
    final process = await _runLegendaryCommand("auth --delete");
    final processStderr = process.stderr.transform(utf8.decoder);
    const String successStatement = "[cli] INFO: User data deleted.";

    return await watchStreamAndWatchForString(
      processStderr,
      string: successStatement,
    );
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