import 'dart:io';
import 'dart:convert';

import 'package:legendary/legendary.dart';
import 'package:legendary/src/io/stream_client.dart';

// This client is intended for end users.
// You spawn the class, give it the path to legendary,
// and it just works
class LegendaryProcessClient extends LegendaryStreamClient implements LegendaryBaseClient {
  final String legendaryPath;
  final bool verbose;

  LegendaryProcessClient({
    required this.legendaryPath,
    this.verbose = false,
  });

  Future<Process> _runLegendaryCommand(List<String> args) async {
    return await Process.start(
      legendaryPath,
      [...args, "--json"]
    );
  }
  
  @override
  Future<void> cleanup() async {
    // FIXME: not sure whether to use stdout or stderr
    final process = await _runLegendaryCommand(["cleanup"]);
    final stderr = process.stderr.transform(utf8.decoder);

    return LegendaryStreamClient.cleanup(stderr);
  }
  
  @override
  Future<void> deleteLogin() async {
    final process = await _runLegendaryCommand(["auth", "--delete"]);
    final stderr = process.stderr.transform(utf8.decoder);

    return LegendaryStreamClient.deleteLogin(stderr);
  }
  
  @override
  Stream<int> import(String appName, String location) async* {
    // FIXME: not sure whether to use stdout or stderr
    final process = await _runLegendaryCommand(["move", appName, location]);
    final stderr = process.stderr.transform(utf8.decoder);

    yield* LegendaryStreamClient.import(stderr, appName, location);
  }
  
  @override
  Future<InstalledGame> info(String appName) async {
    final process = await _runLegendaryCommand(["info", appName]);
    final stderr = process.stderr.transform(utf8.decoder);

    return LegendaryStreamClient.info(stderr, appName);
  }
  
  @override
  Stream<int> install(String appName) async* {
    // FIXME: not sure whether to use stdout or stderr
    final process = await _runLegendaryCommand(["install", appName]);
    final stderr = process.stderr.transform(utf8.decoder);

    yield* LegendaryStreamClient.install(stderr, appName);
  }
  
  @override
  Stream<String> launch(String appName) async* {
    // FIXME: not sure whether to use stdout or stderr
    final process = await _runLegendaryCommand(["launch", appName]);
    final stderr = process.stderr.transform(utf8.decoder);

    yield* LegendaryStreamClient.launch(stderr, appName);  }
  
  @override
  Future<List<Game>> list() async {
    final process = await _runLegendaryCommand(["list"]);
    final stdout = process.stdout.transform(utf8.decoder);

    return LegendaryStreamClient.list(stdout);
  }
  
  @override
  Future<List<InstalledGame>> listInstalled() async {
    final process = await _runLegendaryCommand(["list-installed"]);
    final stdout = process.stdout.transform(utf8.decoder);

    return LegendaryStreamClient.listInstalled(stdout);  }
  
  @override
  Stream<int> move(String appName, String path) async* {
    // FIXME: not sure whether to use stdout or stderr
    final process = await _runLegendaryCommand(["move", appName, path]);
    final stderr = process.stderr.transform(utf8.decoder);

    yield* LegendaryStreamClient.move(stderr, appName, path);  }
  
  @override
  Future<void> setLogin(String code, {String? sid, String? token}) async {
    final process = await _runLegendaryCommand(["cleanup"]);
    final stderr = process.stderr.transform(utf8.decoder);

    return LegendaryStreamClient.setLogin(stderr, code, sid: sid, token: token);
  }
  
  @override
  Future<Status> status() async {
    final process = await _runLegendaryCommand(["status"]);
    final stdout = process.stdout.transform(utf8.decoder);

    return LegendaryStreamClient.status(stdout);  }
  
  @override
  Stream<int> uninstall(String appName) async* {
    // FIXME: not sure whether to use stdout or stderr
    final process = await _runLegendaryCommand(["uninstall", appName]);
    final stderr = process.stderr.transform(utf8.decoder);

    yield* LegendaryStreamClient.uninstall(stderr, appName);
  }
  
  @override
  Stream<int> verify(String appName) async* {
    // FIXME: not sure whether to use stdout or stderr
    final process = await _runLegendaryCommand(["cleanup", appName]);
    final stderr = process.stderr.transform(utf8.decoder);

    yield* LegendaryStreamClient.verify(stderr, appName);
  }

}
