import 'dart:io';
import 'dart:convert';
import 'package:legendary/legendary.dart';

void main(argv) async {
  final line = argv[0];

  if (line == null) return;

  final client = LegendaryClient(legendaryPath: line, verbose: true);
  print(await client.list());
}