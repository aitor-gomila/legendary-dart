import 'package:legendary/legendary.dart';

void main(argv) async {
  print("This will delete your Legendary login. You will need to login back afterwards.");

  final line = argv[0];  

  if (line == null) return;

  final client = LegendaryClient(legendaryPath: line, verbose: true);
  await client.deleteLogin();
  print("Logged out");
}