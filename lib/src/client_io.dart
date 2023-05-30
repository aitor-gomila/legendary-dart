import 'dart:io';
import 'dart:convert';
import 'package:legendary/legendary.dart';

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
  Future<GameInformation?> info(String appName) {
    // TODO: implement info
    throw UnimplementedError();
  }
  
  @override
  Future<void> install(String appName) {
    // TODO: implement install
    throw UnimplementedError();
  }
  
  @override
  Stream<String?> launch(String appName) {
    // TODO: implement launch
    throw UnimplementedError();
  }
  
  @override
  Future<List<Game>?> list() async {
    var process = await _runLegendaryCommand("list");
    var processStdout = process.stdout.transform(utf8.decoder);

    await for (var line in processStdout) {
      if (verbose) stdout.write(line);

      // Check if line is json-invalid, and if it is, continue to the next line
      List<dynamic>? array;
      try {
        array = json.decode(line);
      } catch (error) {
        // Allowed to continue softly in this case
        continue;
      }

      if (array == null) throw "array is null";
      if (array.isEmpty) throw "array is empty";

      // Check if the json is type-safe
      List<Game> typedList = array.map(
        (obj) => Game.fromMap(obj)
      ).toList();

      // Finally return
      return typedList;
    }

    return null;
  }
  
  @override
  Future<List<Game>?> listInstalled() {
    // TODO: implement listInstalled
    throw UnimplementedError();
  }
  
  @override
  Future<void> move(String appName, String path) {
    // TODO: implement move
    throw UnimplementedError();
  }
  
  @override
  Future<Status?> status() async {
    var process = await _runLegendaryCommand("status");
    var processStdout = process.stdout.transform(utf8.decoder);
    await for (var line in processStdout) {
      if(verbose) stdout.write(line);

      Map<String, dynamic>? map;

      try {
        map = json.decode(line);
      } catch(_) {
        continue;
      }
      if (map == null) continue;

      return Status.fromMap(map);
    }
    return null;
  }
  
  @override
  Future<void> uninstall(String appName) {
    // TODO: implement uninstall
    throw UnimplementedError();
  }

  @override
  Future<void> auth(String authenticationToken) {
    // TODO: implement auth
    throw UnimplementedError();
  }
}