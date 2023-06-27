import 'package:legendary/legendary.dart';

void main(argv) async {
  final legendaryPath = argv[0];

  if (legendaryPath == null) return;

  final client = LegendaryClient(legendaryPath: legendaryPath);

  final gameId = argv[1];
  if (gameId == null) return;

  final verify = await client.verify(gameId);
  verify.data.listen((progress) => print(
      "${progress.currentPart}/${progress.totalParts} ${progress.percentage}% ${progress.speed} ${progress.unit}"));
}
