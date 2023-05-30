import 'package:legendary/src/types.dart';

abstract class BaseLegendaryClient {
  Future<void> auth(String authenticationToken);
  Future<Status?> status();
  Future<List<Game>?> list();
  Future<List<Game>?> listInstalled();
  Future<void> install(String appName);
  Future<GameInformation?> info(String appName);
  Stream<String?> launch(String appName);
  Future<void> move(String appName, String path);
  Future<void> uninstall(String appName);
}