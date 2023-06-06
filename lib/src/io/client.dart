import 'dart:io';
import 'dart:convert';

import 'package:legendary/legendary.dart';

// This client is intended for end users.
// You spawn the class, give it the path to legendary,
// and it just works
class LegendaryProcessClient extends LegendaryBaseClient {
  final String legendaryPath;
  final bool verbose;
  late final LegendaryStreamClient streamClient;

  LegendaryProcessClient({
    required this.legendaryPath,
    this.verbose = false,
  }) {
    streamClient = LegendaryStreamClient(
      startProcess: _runLegendaryCommand,
      verbosePrint: (message) {
        if (verbose) stderr.write(message);
      },
    );
  }

  Future<LegendaryProcess> _runLegendaryCommand(List<String> args) async {
    final process = await Process.start(
      legendaryPath,
      [...args, "--json"]
    );

    return LegendaryProcess(
      stdout: process.stdout.transform(utf8.decoder),
      stderr: process.stderr.transform(utf8.decoder)
    );
  }
  
  @override
  Future<void> cleanup() {
    return streamClient.cleanup();
  }
  
  @override
  Future<void> deleteLogin() {
    return streamClient.deleteLogin();
  }
  
  @override
  Stream<int> import(String appName, String location) {
    return streamClient.import(appName, location);
  }
  
  @override
  Future<InstalledGame> info(String appName) {
    return streamClient.info(appName);
  }
  
  @override
  Stream<int> install(String appName) {
    return streamClient.install(appName);
  }
  
  @override
  Stream<String> launch(String appName) {
    return streamClient.launch(appName);
  }
  
  @override
  Future<List<Game>> list() {
    return streamClient.list();
  }
  
  @override
  Future<List<InstalledGame>> listInstalled() {
    return streamClient.listInstalled();
  }
  
  @override
  Stream<int> move(String appName, String path) {
    return streamClient.move(appName, path);
  }
  
  @override
  Future<void> setLogin(String code, {String? sid, String? token}) {
    return streamClient.setLogin(code, sid: sid, token: token);
  }
  
  @override
  Future<Status> status() {
    return streamClient.status();
  }
  
  @override
  Stream<int> uninstall(String appName) {
    return streamClient.uninstall(appName);
  }
  
  @override
  Stream<int> verify(String appName) {
    return streamClient.verify(appName);
  }

}
