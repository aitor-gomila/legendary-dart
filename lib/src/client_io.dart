import 'dart:io';
import 'dart:convert';

import 'package:legendary/legendary.dart';

import 'package:legendary/src/client_base.dart';
import 'package:legendary/src/watch_stream.dart';
import 'package:legendary/src/models/status.dart';
import 'package:legendary/src/models/game.dart';
import 'package:legendary/src/models/manifest.dart';

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
  Future<Game> info(String appName) async {
    final process = await _runLegendaryCommand("info $appName");
    final processStdout = process.stdout.transform(utf8.decoder);

    return await watchStreamForJson(input: processStdout, transform: Game.fromJson);
  }
  
  @override
  Stream<int> install(String appName) {
    // TODO: implement install
    throw UnimplementedError();
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
  Future<List<Game>> list() async {
    final process = await _runLegendaryCommand("list");
    final processStdout = process.stdout.transform(utf8.decoder);

    return await watchStreamForJson<List<Game>>(input: processStdout, transform: Game.fromList, verbose: verbose);
  }
  
  @override
  Future<List<Game>> listInstalled() async {
    final process = await _runLegendaryCommand("list-installed");
    final processStdout = process.stdout.transform(utf8.decoder);

    return await watchStreamForJson<List<Game>>(input: processStdout, transform: Game.fromList, verbose: verbose);
  }
  
  @override
  Future<void> move(String appName, String path) {
    // TODO: implement move
    throw UnimplementedError();
  }
  
  @override
  Future<Status> status() async {
    final process = await _runLegendaryCommand("status");
    final processStdout = process.stdout.transform(utf8.decoder);

    return await watchStreamForJson(input: processStdout, transform: Status.fromJson);
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
      if (verbose) stdout.write(line);

      const String successStatement = "[cli] INFO: User data deleted.";
      if (!line.contains(successStatement)) {
        continue;
      }
      break;
    }
  }
}