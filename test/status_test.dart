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

  test("Empty string on Status.fromJson throws", () {
    try {
      Status.fromJson(jsonDecode(""));
    } catch (err) {
      print(err);
      return;
    }
    // If doesn't throw, fail
    fail("Parsing bad json didn't fail on Status.fromJson");
  });

  test("Parsing missing property on Status.fromJson throws", () {
    try {
      Status.fromJson(jsonDecode('{"account": "someAccount"}'));
    } catch (err) {
      print(err);
      return;
    }
    // If doesn't throw, fail
    fail("Parsing missing property didn't fail on Status.fromJson");
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
