import 'dart:io';
import 'package:legendary/legendary.dart';

void main(argv) async {
  print("This will set your Legendary login.");

  final legendaryPath = argv[0];

  if (legendaryPath == null) return;

  print("Write your login code below:");

  final code = stdin.readLineSync();

  if (code == null) return;

  final client = LegendaryClient(legendaryPath: legendaryPath);
  await client.setLogin(code);
  print("Logged in");
}
