import 'package:legendary/src/models/game.dart';
import 'package:legendary/src/models/status.dart';

abstract class BaseLegendaryClient {
  Future<void> setLogin(String code, {
    String? sid,
    String? token,
  });
  Future<void> deleteLogin();
  Future<Status> status();
  Future<List<Game>> list();
  Future<List<InstalledGame>> listInstalled();
  Stream<int> install(String appName);
  Future<InstalledGame> info(String appName);
  Stream<String> launch(String appName);
  Stream<int> move(String appName, String path);
  Stream<int> uninstall(String appName);
}