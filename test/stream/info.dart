import 'dart:convert';
import 'package:test/test.dart';
import 'package:legendary/legendary.dart';

void infoTest() async {
  final InstalledGame correctInstalledGame = InstalledGame(
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
      platform: "",
      requiresOt: false);

  test("InstalledGame fields are correct", () async {
    final info = await LegendaryStreamClient(LegendaryProcess(
            stdout: Stream.fromIterable([jsonEncode(correctInstalledGame)])
                .transform(utf8.encoder),
            stderr: Stream.empty()))
        .info("example");
    final data = await info.data;
    expect(data.toJson(), equals(correctInstalledGame.toJson()));
  });
}
