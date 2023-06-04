import 'package:legendary/legendary.dart';

void main(argv) async {
  final line = argv[0];

  if (line == null) return;

  final client = LegendaryClient(legendaryPath: line);
  final status = await client.status();

  print(status.toJson());
}