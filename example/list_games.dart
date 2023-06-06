import 'package:legendary/legendary.dart';

void main(argv) async {
  final line = argv[0];

  if (line == null) return;

  final client = LegendaryProcessClient(legendaryPath: line, verbose: true);
  final list = await client.list();
  print(list.map((e) => e.toJson()));
}