import 'package:legendary/legendary.dart';
import 'package:test/test.dart';

void installedGameTests() {
  InstalledGame correctInstalledGame = InstalledGame(
    appName: "example",
    installPath: "",
    title: "example",
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
    requiresOt: false
  );

  test("Empty map on InstalledGame.fromJson throws", () {
    expect(() => InstalledGame.fromJson({}), throwsA(isA<TypeError>()));
  });

  test("InstalledGame.fromJson is accurate", () {
    final Map<String, dynamic> map = {
      "app_name": "example",
      "install_path": "",
      "title": "example",
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

    expect(InstalledGame.fromJson(map), equals(correctInstalledGame));
  });
}
