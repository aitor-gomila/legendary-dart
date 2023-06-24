import 'dart:io';
import 'dart:convert';
import 'package:legendary/legendary.dart';

void main(argv) async {
  final legendaryPath = argv[0];

  if (legendaryPath == null) return;

  final client = LegendaryClient(legendaryPath: legendaryPath);

  final gameId = argv[1];
  if (gameId == null) return;

  final childProcess = await client.launch(gameId);
  stdout.addStream(childProcess.stdout.transform(utf8.encoder));
  stderr.addStream(childProcess.stderr.transform(utf8.encoder));
}
