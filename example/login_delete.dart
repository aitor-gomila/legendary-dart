import 'package:legendary/legendary.dart';

void main(argv) async {
  print(
      "This will delete your Legendary login. You will need to login back afterwards.");

  final legendaryPath = argv[0];

  if (legendaryPath == null) return;

  final client = LegendaryClient(legendaryPath: legendaryPath);
  await client.deleteLogin();
  print("Logged out");
}
