final class GameAsset {
  final String appName;
  final String assetId;
  final String buildVersion;
  final String catalogItemId;
  final String labelName;
  final String namespace;
  final Map<String, dynamic> metadata;

  Map<String, dynamic> toJson() => {
        "app_name": appName,
        "asset_id": assetId,
        "build_version": buildVersion,
        "catalog_item_id": catalogItemId,
        "label_name": labelName,
        "namespace": namespace,
        "metadata": metadata
      };

  factory GameAsset.fromJson(Map<String, dynamic> obj) {
    final appName = obj["app_name"];
    final assetId = obj["asset_id"];
    final buildVersion = obj["build_version"];
    final catalogItemId = obj["catalog_item_id"];
    final labelName = obj["label_name"];
    final namespace = obj["namespace"];
    final metadata = obj["metadata"];

    return GameAsset(
      appName: appName,
      assetId: assetId,
      buildVersion: buildVersion,
      catalogItemId: catalogItemId,
      labelName: labelName,
      namespace: namespace,
      metadata: Map<String, dynamic>.from(metadata),
    );
  }

  const GameAsset({
    required this.appName,
    required this.assetId,
    required this.buildVersion,
    required this.catalogItemId,
    required this.labelName,
    required this.namespace,
    required this.metadata,
  });
}

final class Game {
  final String appName;
  final String appTitle;
  final Map<String, GameAsset> assetInfos;
  final List<String> baseURLs;
  final Map<String, dynamic> metadata;
  String? appVersion(String platform) => assetInfos[platform]?.buildVersion;
  bool get isDLC => metadata["mainGameItem"];
  String get thirdPartyStore =>
      metadata["customAttributes"]["ThirdPartyManagedApp"]["value"];
  String get partnerLinkType =>
      metadata["customAttributes"]["partnerLinkType"]["value"];
  String get partnerLinkId =>
      metadata["customAttributes"]["partnerLinkId"]["value"];
  bool get supportsCloudSaves =>
      !metadata["customAttributes"]["CloudSaveFolder"];
  bool get supportsMacCloudSaves =>
      !metadata["customAttributes"]["CloudSaveFolder_MAC"];
  String get catalogItemId => metadata["id"];
  String get namespace => metadata["namespace"];

  const Game({
    required this.appName,
    required this.appTitle,
    required this.assetInfos,
    required this.baseURLs,
    required this.metadata,
  });

  Map<String, dynamic> toJson() => {
        "app_name": appName,
        "app_title": appTitle,
        "asset_infos":
            assetInfos.map((key, value) => MapEntry(key, value.toJson())),
        "base_urls": baseURLs,
        "metadata": metadata,
      };

  factory Game.fromJson(Map<String, dynamic> obj) {
    final appName = obj["app_name"];
    final appTitle = obj["app_title"];
    final assetInfos = obj["asset_infos"];

    Map<String, GameAsset> typedAssetInfos = assetInfos.map<String, GameAsset>(
        (String key, dynamic asset) =>
            MapEntry(key, GameAsset.fromJson(asset)));

    final baseURLs = obj["base_urls"];
    final metadata = obj["metadata"];

    return Game(
      appName: appName,
      appTitle: appTitle,
      assetInfos: typedAssetInfos,
      baseURLs: List<String>.from(baseURLs),
      metadata: Map<String, dynamic>.from(metadata),
    );
  }
}

extension GameList on List<Game> {
  static List<Game> fromList(List<dynamic> list) =>
      list.map((obj) => Game.fromJson(obj)).toList();
}

final class InstalledGame {
  final String appName;
  final String installPath;
  final String title;
  final String version;

  final List<String> baseURLs;
  final bool canRunOffline;
  final String eglGuid;
  final String executable;
  final int installSize;
  final List<String> installTags;
  final bool isDLC;
  final String launchParameters;
  final String manifestPath;
  final bool needsVerification;
  final String platform;
  final Map<String, dynamic>? prereqInfo;
  final bool requiresOt;
  final String? savePath;

  Map<String, dynamic> toJson() => {
        "app_name": appName,
        "install_path": installPath,
        "title": title,
        "version": version,
        "base_urls": baseURLs,
        "can_run_offline": canRunOffline,
        "egl_guid": eglGuid,
        "executable": executable,
        "install_size": installSize,
        "install_tags": installTags,
        "is_dlc": isDLC,
        "launch_parameters": launchParameters,
        "manifest_path": manifestPath,
        "needs_verification": needsVerification,
        "platform": platform,
        "prereq_info": prereqInfo,
        "requires_ot": requiresOt,
        "save_path": savePath
      };

  factory InstalledGame.fromJson(Map<String, dynamic> obj) {
    final appName = obj["app_name"];
    final installPath = obj["install_path"];
    final title = obj["title"];
    final version = obj["version"];
    final baseURLs = obj["base_urls"];
    final canRunOffline = obj["can_run_offline"];
    final eglGuid = obj["egl_guid"];
    final executable = obj["executable"];
    final installSize = obj["install_size"];
    final installTags = obj["install_tags"];
    final isDLC = obj["is_dlc"];
    final launchParameters = obj["launch_parameters"];
    final manifestPath = obj["manifest_path"];
    final needsVerification = obj["needs_verification"];
    final platform = obj["platform"];
    final prereqInfo = obj["prereq_info"];
    final requiresOt = obj["requires_ot"];
    final savePath = obj["save_path"];

    return InstalledGame(
      appName: appName,
      installPath: installPath,
      title: title,
      version: version,
      baseURLs: List<String>.from(baseURLs),
      canRunOffline: canRunOffline,
      eglGuid: eglGuid,
      executable: executable,
      installSize: installSize,
      installTags: List<String>.from(installTags),
      isDLC: isDLC,
      launchParameters: launchParameters,
      manifestPath: manifestPath,
      needsVerification: needsVerification,
      platform: platform,
      prereqInfo: prereqInfo,
      requiresOt: requiresOt,
      savePath: savePath,
    );
  }

  const InstalledGame(
      {required this.appName,
      required this.installPath,
      required this.title,
      required this.version,
      required this.baseURLs,
      required this.canRunOffline,
      required this.eglGuid,
      required this.executable,
      required this.installSize,
      required this.installTags,
      required this.isDLC,
      required this.launchParameters,
      required this.manifestPath,
      required this.needsVerification,
      required this.platform,
      this.prereqInfo,
      required this.requiresOt,
      this.savePath});
}

extension InstalledGameList on List<InstalledGame> {
  static List<InstalledGame> fromList(List<dynamic> list) =>
      list.map<InstalledGame>((obj) => InstalledGame.fromJson(obj)).toList();
}

final class SaveGameFile {
  final String appName;
  final String fileName;
  final String manifestName;
  final DateTime? dateTime;

  const SaveGameFile(
      {required this.appName,
      required this.fileName,
      required this.manifestName,
      this.dateTime});
}

enum SaveGameStatus { localNewer, remoteNewer, sameAge, noSave }

final class LaunchParameters {
  final List<String> gameParameters;
  final String gameExecutable;
  final String gameDirectory;
  final List<String> eglParameters;
  final List<String> launchCommand;
  final String workingDirectory;
  final List<String> userParameters;
  final Map<String, String> environment;
  final String preLaunchCommand;
  final bool preLaunchWait;

  Map<String, dynamic> toJson() => {
        "game_parameters": gameParameters,
        "game_executable": gameExecutable,
        "game_directory": gameDirectory,
        "egl_parameters": eglParameters,
        "launch_command": launchCommand,
        "working_directory": workingDirectory,
        "user_parameters": userParameters,
        "environment": environment,
        "pre_launch_command": preLaunchCommand,
        "pre_launch_wait": preLaunchWait
      };

  factory LaunchParameters.fromJson(Map<String, dynamic> obj) {
    final gameParameters = obj["game_parameters"];
    final gameExecutable = obj["game_executable"];
    final gameDirectory = obj["game_directory"];
    final eglParameters = obj["egl_parameters"];
    final launchCommand = obj["launch_command"];
    final workingDirectory = obj["working_directory"];
    final userParameters = obj["user_parameters"];
    final environment = obj["environment"];
    final preLaunchCommand = obj["pre_launch_command"];
    final preLaunchWait = obj["pre_launch_wait"];

    return LaunchParameters(
        gameParameters: List<String>.from(gameParameters),
        gameExecutable: gameExecutable,
        gameDirectory: gameDirectory,
        eglParameters: List<String>.from(eglParameters),
        launchCommand: List<String>.from(launchCommand),
        workingDirectory: workingDirectory,
        userParameters: List<String>.from(userParameters),
        environment: Map<String, String>.from(environment),
        preLaunchCommand: preLaunchCommand,
        preLaunchWait: preLaunchWait);
  }

  const LaunchParameters(
      {required this.gameParameters,
      required this.gameExecutable,
      required this.gameDirectory,
      required this.eglParameters,
      required this.launchCommand,
      required this.workingDirectory,
      required this.userParameters,
      required this.environment,
      required this.preLaunchCommand,
      required this.preLaunchWait});
}
