import 'dart:convert';
import 'package:legendary/legendary.dart';
import 'package:test/test.dart';

void installedGameTests() {
  test(
      "Correct string on InstalledGame.fromJson doesn't throw, fields are accurate",
      () {
    var string =
        '{"app_name": "Fortnite", "install_path": "", "title": "Fortnite", "version": "", "base_urls": [], "can_run_offline": false, "egl_guid": "", "executable": "", "install_size": 0, "install_tags": [], "is_dlc": false, "launch_parameters": "", "manifest_path": "", "needs_verification": false, "platform": "windows", "requires_ot": false}';
    final installedGame = InstalledGame.fromJson(jsonDecode(string));

    expect(installedGame, isA<InstalledGame>());
  });

  test("Empty map on InstalledGame.fromJson throws", () {
    expect(() => InstalledGame.fromJson({}), throwsA(isA<TypeError>()));
  });

  test("InstalledGame.toJson is accurate", () {
    final status = InstalledGame(
        appName: "Fortnite",
        installPath: "",
        title: "Fortnite",
        version: "",
        baseURLs: [],
        canRunOffline: false,
        eglGuid: "",
        executable: "",
        installSize: 0,
        installTags: [],
        isDLC: false,
        launchParameters: "",
        manifestPath: "",
        needsVerification: false,
        platform: "windows",
        requiresOt: false);

    final Map<String, dynamic> correctMap = {
      "app_name": "Fortnite",
      "install_path": "",
      "title": "Fortnite",
      "version": "",
      "base_urls": [],
      "can_run_offline": false,
      "egl_guid": "",
      "executable": "",
      "install_size": 0,
      "install_tags": [],
      "is_dlc": false,
      "launch_parameters": "",
      "manifest_path": "",
      "needs_verification": false,
      "platform": "windows",
      "requires_ot": false,
      "prereq_info": null,
      "save_path": null,
    };

    expect(status.toJson(), equals(correctMap));
  });
}
