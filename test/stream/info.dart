import 'dart:convert';
import 'package:test/test.dart';
import 'package:legendary/legendary.dart';
import 'package:legendary/src/io/stream_client.dart';

void infoTest() async {
  late InstalledGame info;
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
    requiresOt: false
  );

  setUp(() async {
    info = await LegendaryStreamClient.info(
      Stream.fromIterable(
        [
          jsonEncode(correctInstalledGame)
        ]
      ),
      "example"
    );
  });
  
  test("InstalledGame fields are correct", () {
    expect(info.toJson(), equals(correctInstalledGame.toJson()));
  });
}
