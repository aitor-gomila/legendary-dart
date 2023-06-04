final class GameAsset {
  final String appName;
  final String assetId;
  final String buildVersion;
  final String catalogItemId;
  final String labelName;
  final String namespace;
  final Map<String, dynamic> metadata;

  // FIXME: dangerous JSON conversion. check types
  factory GameAsset.fromJson(dynamic obj) {
    if (obj is! Map<String, dynamic>) throw "obj is not a Map<String, dynamic>. it is a ${obj.runtimeType}";

    final appName = obj["app_name"];
    if (appName is! String) throw "appName is not a String. it is a ${appName.runtimeType}";

    final assetId = obj["asset_id"];
    if (assetId is! String) throw "assetId is not a String. it is a ${assetId.runtimeType}";

    final buildVersion = obj["build_version"];
    if (buildVersion is! String) throw "buildVersion is not a String. it is a ${buildVersion.runtimeType}";

    final catalogItemId = obj["catalog_item_id"];
    if (catalogItemId is! String) throw "catalogItemId is not a String. it is a ${catalogItemId.runtimeType}";

    final labelName = obj["label_name"];
    if (labelName is! String) throw "labelName is not a String. it is a ${labelName.runtimeType}";

    final namespace = obj["namespace"];
    if (namespace is! String) throw "namespace is not a String. it is a ${namespace.runtimeType}";

    final metadata = obj["metadata"];
    if (metadata is! Map<String, dynamic>) throw "metadata is not a Map<String, dynamic>. it is a ${metadata.runtimeType}";

    return GameAsset(
      appName: appName,
      assetId: assetId,
      buildVersion: buildVersion,
      catalogItemId: catalogItemId,
      labelName: labelName,
      namespace: namespace,
      metadata: metadata,
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
  String? appVersion (String platform) => assetInfos[platform]?.buildVersion;
  bool get isDLC => metadata["mainGameItem"];
  String get thirdPartyStore => metadata["customAttributes"]["ThirdPartyManagedApp"]["value"];
  String get partnerLinkType => metadata["customAttributes"]["partnerLinkType"]["value"];
  String get partnerLinkId => metadata["customAttributes"]["partnerLinkId"]["value"];
  bool get supportsCloudSaves => !metadata["customAttributes"]["CloudSaveFolder"];
  bool get supportsMacCloudSaves => !metadata["customAttributes"]["CloudSaveFolder_MAC"];
  String get catalogItemId => metadata["id"];
  String get namespace => metadata["namespace"];

  const Game({
    required this.appName,
    required this.appTitle,
    required this.assetInfos,
    required this.baseURLs,
    required this.metadata,
  });

  factory Game.fromJson(Map<String, dynamic> obj) {
    final appName = obj["app_name"];
    if (appName is! String) throw "appName is not a String. it is a ${appName.runtimeType}";

    final appTitle = obj["app_title"];
    if (appTitle is! String) throw "appTitle is not a String. it is a ${appTitle.runtimeType}";

    final assetInfos = obj["asset_infos"];
    if (assetInfos is! Map) throw "assetInfos is not a Map. it is a ${assetInfos.runtimeType}";

    Map<String, GameAsset> typedAssetInfos = assetInfos.map((key, asset) => MapEntry(
      key,
      GameAsset.fromJson(asset)
    ));

    final baseURLs = obj["base_urls"];
    if (baseURLs is! List) throw "baseURLs is not a List. it is a ${baseURLs.runtimeType}";
    List<String> typedBaseURLs = baseURLs.map((e) => String.fromEnvironment(e)).toList();

    final metadata = obj["metadata"];

    return Game(
      appName: appName,
      appTitle: appTitle,
      assetInfos: typedAssetInfos,
      baseURLs: typedBaseURLs,
      metadata: metadata,
    );
  }

}

extension GameList on List<Game> {
  static List<Game> fromList(List<dynamic> list) {
    return list.map((obj) => Game.fromJson(obj)).toList();
  }
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

  const InstalledGame({
    required this.appName,
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
    this.savePath
  });
}

final class SaveGameFile {
  final String appName;
  final String fileName;
  final String manifestName;
  final DateTime? dateTime;

  const SaveGameFile({
    required this.appName,
    required this.fileName,
    required this.manifestName,
    this.dateTime
  });
}

enum SaveGameStatus {
  localNewer,
  remoteNewer,
  sameAge,
  noSave
}

enum VerifyResult {
  hashMatch,
  hashMismatch,
  fileMissing,
  otherError
}

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

  const LaunchParameters({
    required this.gameParameters,
    required this.gameExecutable,
    required this.gameDirectory,
    required this.eglParameters,
    required this.launchCommand,
    required this.workingDirectory,
    required this.userParameters,
    required this.environment,
    required this.preLaunchCommand,
    required this.preLaunchWait
  });
}
