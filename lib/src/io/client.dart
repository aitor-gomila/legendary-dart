import 'dart:io';
import 'dart:convert';

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
    final process = await Process.start(legendaryPath, [...arguments, "--json"]);

    return LegendaryProcess(
        stdout: process.stdout.transform(utf8.decoder),
        stderr: process.stderr.transform(utf8.decoder));
  }
}
