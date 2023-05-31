import 'dart:io';
import 'dart:convert';

import 'package:legendary/legendary.dart';

import 'client_base.dart';
import 'json.dart';

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
  Future<GameInformation> info(String appName) {
    // TODO: implement info
    throw UnimplementedError();
  }
  
  @override
  Future<void> install(String appName) {
    // TODO: implement install
    throw UnimplementedError();
  }
  
  @override
  Stream<String> launch(String appName) {
    // TODO: implement launch
    throw UnimplementedError();
  }
  
  @override
  Future<List<Game>> list() async {
    var process = await _runLegendaryCommand("list");
    var processStdout = process.stdout.transform(utf8.decoder);

    return await watchStreamForJson<List<Game>>(input: processStdout, transform: Game.fromList, verbose: verbose);
  }
  
  @override
  Future<List<Game>> listInstalled() {
    // TODO: implement listInstalled
    throw UnimplementedError();
  }
  
  @override
  Future<void> move(String appName, String path) {
    // TODO: implement move
    throw UnimplementedError();
  }
  
  @override
  Future<Status> status() async {
    var process = await _runLegendaryCommand("status");
    var processStdout = process.stdout.transform(utf8.decoder);

    return await watchStreamForJson(input: processStdout, transform: Status.fromJson);
  }
  
  @override
  Future<void> uninstall(String appName) {
    // TODO: implement uninstall
    throw UnimplementedError();
  }

  @override
  Future<void> setLogin(String code, { sid, token }) async {
    var process = _runLegendaryCommand("auth --disable-webview --token $code");
    throw UnimplementedError();
  }
  @override
  Future<void> deleteLogin() async {
    var process = await _runLegendaryCommand("auth --disable-webview --delete");
    var processStdout = process.stdout.transform(utf8.decoder);

    await for (var line in processStdout) {
      if (verbose) stdout.write(line);

      const String successStatement = "[cli] INFO: User data deleted.";
      if (!line.contains(successStatement)) {
        continue;
      }
      break;
    }
  }
}