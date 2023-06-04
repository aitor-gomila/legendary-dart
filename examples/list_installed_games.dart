import 'package:legendary/legendary.dart';

void main(argv) async {
  final line = argv[0];

  if (line == null) return;

  final client = LegendaryClient(legendaryPath: line);
  final list = await client.listInstalled();
  print(list.map((e) => e.toJson()));
}