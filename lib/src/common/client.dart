import 'package:legendary/legendary.dart';

abstract class LegendaryBaseClient {
  Future<void> setLogin(String code, {
    String? sid,
    String? token,
  });
  Future<void> deleteLogin();
  Future<Status> status();
  Future<List<Game>> list();
  Future<List<InstalledGame>> listInstalled();
  Future<InstalledGame> info(String appName);
  Future<void> cleanup();
  Stream<String> launch(String appName);
  Stream<int> verify(String appName);
  Stream<int> install(String appName);
  Stream<int> import(String appName, String location);
  Stream<int> move(String appName, String path);
  Stream<int> uninstall(String appName);
}
