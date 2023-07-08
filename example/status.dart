import 'package:legendary/legendary.dart';

void main(argv) async {
  final legendaryPath = argv[0];

  if (legendaryPath == null) return;

  final client = LegendaryClient(legendaryPath: legendaryPath);
  final status = await (await client.status()).data;

  print(status.toJson());
}
