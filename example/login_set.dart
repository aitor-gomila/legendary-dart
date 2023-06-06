import 'dart:io';
import 'package:legendary/legendary.dart';

void main(argv) async {
  print("This will set your Legendary login.");

  final line = argv[0];  

  if (line == null) return;

  print ("Write your login code below:");

  final code = stdin.readLineSync();

  if (code == null) return;

  final client = LegendaryProcessClient(legendaryPath: line);
  await client.setLogin(code);
  print("Logged in");

}
