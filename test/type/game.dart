import 'package:legendary/legendary.dart';
import 'package:test/test.dart';

void gameTests() {
  final Game correctGame = Game(
      appName: "example",
      appTitle: "example",
      metadata: Metadata(
          applicationId: "",
          creationDate: DateTime.parse("2021-07-22T17:56:47.501Z"),
          customAttributes: {
            "CanRunOffline": MetadataAttribute(type: "STRING", value: "true"),
            "CanSkipKoreanIdVerification":
                MetadataAttribute(type: "STRING", value: "true"),
            "CloudSaveFolder": MetadataAttribute(
                type: "STRING",
                value:
                    "{UserSavedGames}/MachineGames/Wolfenstein The New Order/base/savegame/{EpicID}/"),
            "FolderName":
                MetadataAttribute(type: "STRING", value: "WolfensteinTNO"),
            "MonitorPresence":
                MetadataAttribute(type: "STRING", value: "false"),
            "PresenceId": MetadataAttribute(
                type: "STRING", value: "0bd3e505924240adb702295fa08c1eff"),
            "RequirementsJson": MetadataAttribute(type: "STRING", value: "[]"),
            "UseAccessControl":
                MetadataAttribute(type: "STRING", value: "false")
          },
          description: "Wolfenstein: The New Order",
          developer: "Bethesda Softworks LLC",
          developerId: "o-bthbhn6wd7fzj73v5p4436ucn3k37u",
          endOfSupport: false,
          entitlementName: "",
          entitlementType: "",
          id: "",
          eulaIds: [""],
          itemType: "DURABLE",
          keyImages: [
            MetadataImage(
                height: 1440,
                md5: "3a75b2c45a2a12e882feb2e2ff180b0c",
                size: 364883,
                type: "DieselGameBox",
                uploadedDate: DateTime.parse("2021-09-01T19:19:34.692Z"),
                url:
                    "https://cdn1.epicgames.com/salesEvent/salesEvent/EGS_WolfensteinTheNewOrder_MachineGames_S1_2560x1440-3a75b2c45a2a12e882feb2e2ff180b0c",
                width: 2560),
            MetadataImage(
                height: 1600,
                md5: "0f70ad56e210812c26a9dde1a8143a58",
                size: 298255,
                type: "DieselGameBoxTall",
                uploadedDate: DateTime.parse("2021-09-01T19:19:28.723Z"),
                url:
                    "https://cdn1.epicgames.com/salesEvent/salesEvent/EGS_WolfensteinTheNewOrder_MachineGames_S2_1200x1600-0f70ad56e210812c26a9dde1a8143a58",
                width: 1200)
          ],
          lastModifiedDate: DateTime.parse("2022-12-16T17:43:05.090Z"),
          mainGameItem:
              MetadataMainGameItem(id: "", namespace: "", unsearchable: false),
          namespace: "",
          requiresSecureAccount: false,
          status: "ACTIVE",
          title: "Wolfenstein: The New Order",
          unsearchable: true),
      assetInfos: {
        "windows": GameAsset(
            appName: "example",
            assetId: "",
            buildVersion: "",
            catalogItemId: "",
            labelName: "",
            namespace: "",
            metadata: {"installationPoolId": ""})
      },
      baseURLs: []);

  test("Empty map on Game.fromJson throws", () {
    expect(() => Game.fromJson({}), throwsA(isA<TypeError>()));
  });

  test("Game.toJson is accurate", () {
    final Map<String, dynamic> map = {
      "app_name": "example",
      "app_title": "example",
      "metadata": {
        "applicationId": "",
        "creationDate": "2021-07-22T17:56:47.501Z",
        "customAttributes": {
          "CanRunOffline": {"type": "STRING", "value": "true"},
          "CanSkipKoreanIdVerification": {"type": "STRING", "value": "true"},
          "CloudSaveFolder": {
            "type": "STRING",
            "value":
                "{UserSavedGames}/MachineGames/Wolfenstein The New Order/base/savegame/{EpicID}/"
          },
          "FolderName": {"type": "STRING", "value": "WolfensteinTNO"},
          "MonitorPresence": {"type": "STRING", "value": "false"},
          "PresenceId": {
            "type": "STRING",
            "value": "0bd3e505924240adb702295fa08c1eff"
          },
          "RequirementsJson": {"type": "STRING", "value": "[]"},
          "UseAccessControl": {"type": "STRING", "value": "false"}
        },
      },
      "asset_infos": {
        "windows": {
          "app_name": "example",
          "asset_id": "",
          "build_version": "",
          "catalog_item_id": "",
          "label_name": "",
          "namespace": "",
          "metadata": {"installationPoolId": ""},
          "description": "Wolfenstein: The New Order",
          "developer": "Bethesda Softworks LLC",
          "developerId": "o-bthbhn6wd7fzj73v5p4436ucn3k37u",
          "endOfSupport": false,
          "entitlementName": "283080ad58e64fd084d30413888a571c",
          "entitlementType": "EXECUTABLE",
          "eulaIds": [""],
          "id": "",
          "itemType": "DURABLE",
          "keyImages": [
            {
              "height": 1440,
              "md5": "3a75b2c45a2a12e882feb2e2ff180b0c",
              "size": 364883,
              "type": "DieselGameBox",
              "uploadedDate": "2021-09-01T19:19:34.692Z",
              "url":
                  "https://cdn1.epicgames.com/salesEvent/salesEvent/EGS_WolfensteinTheNewOrder_MachineGames_S1_2560x1440-3a75b2c45a2a12e882feb2e2ff180b0c",
              "width": 2560
            },
            {
              "height": 1600,
              "md5": "0f70ad56e210812c26a9dde1a8143a58",
              "size": 298255,
              "type": "DieselGameBoxTall",
              "uploadedDate": "2021-09-01T19:19:28.723Z",
              "url":
                  "https://cdn1.epicgames.com/salesEvent/salesEvent/EGS_WolfensteinTheNewOrder_MachineGames_S2_1200x1600-0f70ad56e210812c26a9dde1a8143a58",
              "width": 1200
            }
          ],
          "lastModifiedDate": "2022-12-16T17:43:05.090Z",
          "requiresSecureAccount": false,
          "status": "ACTIVE",
          "title": "Wolfenstein: The New Order",
          "unsearchable": true
        },
      },
      "base_urls": [],
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
