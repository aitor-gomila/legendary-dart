import 'dart:io';
import 'dart:convert';
import 'package:legendary/legendary.dart';

void main() async {
  print("---- WARNING ----");
  print("This will run any executable you provide");
  print("Use at your own risk");
  print("---- WARNING ----");
  print("Enter your legendary executable path:");

  var line = stdin.readLineSync(encoding: utf8);

  if (line == null) return;

  var client = LegendaryClient(legendaryPath: line);
  print(await client.list());
}