import 'dart:convert';
import 'package:legendary/legendary.dart';
import 'package:test/test.dart';

void gameTests() {
  Game correctGame = Game(
    appName: "example",
    appTitle: "example",
    assetInfos: {
      "windows": GameAsset(
        appName: "example",
        assetId: "",
        buildVersion: "",
        catalogItemId: "",
        labelName: "",
        namespace: "",
        metadata: {}
      )
    },
    metadata: {},
    baseURLs: []
  );

  test("Empty map on Game.fromJson throws", () {
    expect(
      () => Game.fromJson({}),
      throwsA(isA<NoSuchMethodError>())
    );
  });

  test("Game.toJson is accurate", () {
    final Map<String, dynamic> map = {
      "app_name": "example",
      "app_title": "example",
      "asset_infos": {
        "windows": {
          "app_name": "example",
          "asset_id": "",
          "build_version": "",
          "catalog_item_id": "",
          "label_name": "",
          "namespace": "",
          "metadata": {},
        }
      },
      "base_urls": [],
      "metadata": {},
    };

    expect(Game.fromJson(map), equals(correctGame));
  });
}
