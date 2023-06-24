import 'dart:io';
import 'dart:convert';

import 'package:path/path.dart';

import 'package:legendary/legendary.dart';
import 'package:legendary/src/common/watch_stream.dart';

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
    final process = await Process.start(legendaryPath, [...arguments, "--json"]);

    return LegendaryProcess(
        stdout: process.stdout.transform(utf8.decoder),
        stderr: process.stderr.transform(utf8.decoder));
  }

  @override
  Future<LegendaryProcess> launch(String appName) async {
    final process = await getStream(["launch", appName]);
    final output = await watchStreamAndReturnSum(process.stdout);
    final json = jsonDecode(output);
    final launchParameters = LaunchParameters.fromJson(json);

    final fullGameExecutablePath = join(launchParameters.gameDirectory, launchParameters.gameExecutable);

    final childProcess = await Process.start(
      launchParameters.launchCommand[0],
      [
        fullGameExecutablePath,
        ...launchParameters.gameParameters,
        ...launchParameters.eglParameters,
      ],
      workingDirectory: launchParameters.workingDirectory,
      environment: launchParameters.environment
    );

    return LegendaryProcess(
      stdout: childProcess.stdout.transform(utf8.decoder),
      stderr: childProcess.stderr.transform(utf8.decoder)
    );
  }
}
