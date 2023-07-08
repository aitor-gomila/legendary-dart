import 'package:legendary/legendary.dart';

void main(argv) async {
  final legendaryPath = argv[0];

  if (legendaryPath == null) return;

  final client = LegendaryClient(legendaryPath: legendaryPath);
  final list = await client.list();
  final data = await list.data;
  print(data.map((e) => e.toJson()));
}
