import 'dart:io';
import 'dart:convert';
import 'package:legendary/legendary.dart';

void main() async {
  print("This will delete your Legendary login. You will need to login back afterwards.");
  print("Enter your legendary executable path:");

  var line = stdin.readLineSync(encoding: utf8);

  if (line == null) return;

  var client = LegendaryClient(legendaryPath: line, verbose: true);
  await client.deleteLogin();
  print("Logged out");
}