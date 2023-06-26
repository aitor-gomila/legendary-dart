import 'package:legendary/legendary.dart';

void main(argv) async {
  final legendaryPath = argv[0];

  if (legendaryPath == null) return;

  final client = LegendaryClient(legendaryPath: legendaryPath);

  final gameId = argv[1];
  if (gameId == null) return;

  final gamePath = argv[2];
  if (gamePath == null) return;

  final verify = client.install(gameId, gamePath);
  verify.listen((progress) => print(
      "${progress.currentPart}/${progress.totalParts} ${progress.percentage}% ${progress.runningFor.toString()} ${progress.estimatedTimeOfArrival.toString()}"));
}
