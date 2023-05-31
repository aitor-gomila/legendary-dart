import 'dart:io';
import 'dart:convert';
import 'package:legendary/legendary.dart';

void main() async {
  print("Enter your legendary executable path:");

  var line = stdin.readLineSync(encoding: utf8);

  if (line == null) return;

  var client = LegendaryClient(legendaryPath: line);
  var status = await client.status();
  print("Account: ${status?.account}");
  print("Games available: ${status?.gamesAvailable}");
  print("Games installed: ${status?.gamesInstalled}");
  print("EGL Sync Enabled: ${status?.eglSyncEnabled}");
  print("Config directory: ${status?.configDirectory}");
}