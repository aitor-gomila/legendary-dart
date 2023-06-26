import 'package:legendary/legendary.dart';
import 'package:test/test.dart';

void gameTests() {
  final Game correctGame =
      Game(appName: "example", appTitle: "example", assetInfos: {
    "windows": GameAsset(
        appName: "example",
        assetId: "",
        buildVersion: "",
        catalogItemId: "",
        labelName: "",
        namespace: "",
        metadata: {})
  }, metadata: {}, baseURLs: []);

  test("Empty map on Game.fromJson throws", () {
    expect(() => Game.fromJson({}), throwsA(isA<NoSuchMethodError>()));
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

    expect(Game.fromJson(map).toJson(), equals(correctGame.toJson()));
  });

  final LaunchParameters correctLaunchParameters = LaunchParameters(
      gameParameters: [],
      gameExecutable: "SonicMania.exe",
      gameDirectory: "/home/aitor/Games/SonicMania",
      eglParameters: ["-AUTH_LOGIN=unused"],
      launchCommand: ["wine"],
      workingDirectory: "/home/aitor/Games/SonicMania",
      userParameters: [],
      environment: {},
      preLaunchCommand: "",
      preLaunchWait: false);

  test("LaunchParameters.fromJson is accurate", () {
    final launchParameters = {
      "game_parameters": [],
      "game_executable": "SonicMania.exe",
      "game_directory": "/home/aitor/Games/SonicMania",
      "egl_parameters": ["-AUTH_LOGIN=unused"],
      "launch_command": ["wine"],
      "working_directory": "/home/aitor/Games/SonicMania",
      "user_parameters": [],
      "environment": {},
      "pre_launch_command": "",
      "pre_launch_wait": false
    };

    expect(LaunchParameters.fromJson(launchParameters).toJson(),
        equals(correctLaunchParameters.toJson()));
  });
}
