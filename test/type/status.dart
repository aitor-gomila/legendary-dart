import 'package:legendary/legendary.dart';
import 'package:test/test.dart';

void statusTests() {
  test("Empty map on Status.fromJson throws", () {
    expect(() => Status.fromJson({}), throwsA(isA<TypeError>()));
  });

  test("Status.toJson is accurate", () {
    final status = Status(
      account: "someAccount",
      gamesInstalled: 62,
      gamesAvailable: 0,
      eglSyncEnabled: false,
      configDirectory: "",
    );

    final correctMap = {
      "account": "someAccount",
      "games_installed": 62,
      "games_available": 0,
      "egl_sync_enabled": false,
      "config_directory": ""
    };

    expect(status.toJson(), equals(correctMap));
  });
}
