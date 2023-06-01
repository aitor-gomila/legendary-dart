import 'package:legendary/legendary.dart';

void main(argv) async {
  final line = argv[0];

  if (line == null) return;

  final client = LegendaryClient(legendaryPath: line);
  final status = await client.status();
  print("Account: ${status.account}");
  print("Games available: ${status.gamesAvailable}");
  print("Games installed: ${status.gamesInstalled}");
  print("EGL Sync Enabled: ${status.eglSyncEnabled}");
  print("Config directory: ${status.configDirectory}");
}