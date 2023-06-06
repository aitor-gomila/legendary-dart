import 'dart:convert';
import 'package:legendary/legendary.dart';
import 'package:test/test.dart';

void gameTests() {
  test("Correct string on Game.fromJson doesn't throw, fields are accurate", () {
    var string = '''{
      "app_name": "Fortnite",
      "app_title": "Fortnite",
      "asset_infos": {
        "windows": {
          "app_name": "Fortnite",
          "asset_id": "",
          "build_version": "",
          "catalog_item_id": "",
          "label_name": "",
          "namespace": "",
          "metadata": {}
          }
        },
        "metadata": {},
        "base_urls": []
      }''';
    final game = Game.fromJson(jsonDecode(string));

    expect(game, isA<Game>());
  });

  test("Empty map on Game.fromJson throws", () {
    expect(
      () => Game.fromJson({}),
      throwsA(isA<NoSuchMethodError>())
    );
  });

  test("Game.toJson is accurate", () {
    final status = Game(
      appName: "Fortnite",
      appTitle: "Fortnite",
      assetInfos: {
        "windows": GameAsset(
          appName: "Fortnite",
          assetId: "",
          buildVersion: "",
          catalogItemId: "",
          labelName: "",
          metadata: {},
          namespace: "",
        )
      },
      baseURLs: [],
      metadata: {}
    );

    final Map<String, dynamic> correctMap = {
      "app_name": "Fortnite",
      "app_title": "Fortnite",
      "asset_infos": {
        "windows": {
          "app_name": "Fortnite",
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

    expect(status.toJson(), equals(correctMap));
  });
}
