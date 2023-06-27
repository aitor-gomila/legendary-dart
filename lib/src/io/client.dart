import 'dart:io';
import 'dart:convert';

import 'package:path/path.dart';

import 'package:legendary/legendary.dart';

// This client is intended for end users.
// You spawn the class, give it the path to legendary,
// and it just works
class LegendaryClient extends LegendaryBaseClient {
  final String legendaryPath;

  LegendaryClient({
    required this.legendaryPath,
  });

  @override
  Future<LegendaryProcess> getStream(List<String> arguments) async {
    final process =
        await Process.start(legendaryPath, [...arguments, "--json", "-y"]);

    return LegendaryProcess(stdout: process.stdout, stderr: process.stderr);
  }

  @override
  Future<LegendaryProcess> launch(String appName) async {
    final process = await getStream(["launch", appName]);
    var total = "";

    await for (final line in process.stdout.transform(utf8.decoder)) {
      total += line;
    }

    final json = jsonDecode(total);
    final launchParameters = LaunchParameters.fromJson(json);

    final fullGameExecutablePath =
        join(launchParameters.gameDirectory, launchParameters.gameExecutable);

    final childProcess = await Process.start(
        launchParameters.launchCommand[0],
        [
          fullGameExecutablePath,
          ...launchParameters.gameParameters,
          ...launchParameters.eglParameters,
        ],
        workingDirectory: launchParameters.workingDirectory,
        environment: launchParameters.environment);

    return LegendaryProcess(
        stdout: childProcess.stdout, stderr: childProcess.stderr);
  }
}
