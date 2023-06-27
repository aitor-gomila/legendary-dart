import 'package:legendary/legendary.dart';

void main(argv) async {
  final legendaryPath = argv[0];

  if (legendaryPath == null) return;

  final client = LegendaryClient(legendaryPath: legendaryPath);

  final gameId = argv[1];
  if (gameId == null) return;

  await client.uninstall(gameId);
}
