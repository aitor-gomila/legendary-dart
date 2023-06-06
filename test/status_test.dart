import 'dart:convert';
import 'package:legendary/legendary.dart';
import 'package:test/test.dart';

void statusTests() {
  test("Correct string on Status.fromJson doesn't throw, fields are accurate", () {
    var string = '{"account": "someAccount", "games_available": 62, "games_installed": 0, "egl_sync_enabled": false, "config_directory": ""}';
    final status = Status.fromJson(jsonDecode(string));
    if (
      status.account != "someAccount" ||
      status.gamesAvailable != 62 ||
      status.gamesInstalled != 0 ||
      status.eglSyncEnabled != false ||
      status.configDirectory != ""
    ) fail("some field is not correct");
  });

  test("Empty map on Status.fromJson throws", () {
    expect(
      () => Status.fromJson({}),
      throwsA(isA<String>())
    );
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
      "games_installed":62,
      "games_available":0,
      "egl_sync_enabled":false,
      "config_directory":""
    };

    expect(status.toJson(), equals(correctMap));
  });
}
