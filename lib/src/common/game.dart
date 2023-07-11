final class MetadataAttribute {
  final String type;
  final String value;

  Map<String, dynamic> toJson() => {"type": type, "value": value};

  factory MetadataAttribute.fromJson(Map<String, dynamic> obj) =>
      MetadataAttribute(type: obj["type"], value: obj["value"]);

  const MetadataAttribute({required this.type, required this.value});
}

final class MetadataImage {
  final int width;
  final int height;
  final int size;
  final String md5;
  final String type;
  final DateTime uploadedDate;
  final String url;

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "size": size,
        "md5": md5,
        "type": type,
        "uploadedDate": uploadedDate.toIso8601String(),
        "url": url
      };

  factory MetadataImage.fromJson(Map<String, dynamic> obj) => MetadataImage(
      width: obj["width"],
      height: obj["height"],
      size: obj["size"],
      md5: obj["md5"],
      type: obj["type"],
      uploadedDate: DateTime.parse(obj["uploadedDate"]),
      url: obj["url"]);

  const MetadataImage(
      {required this.width,
      required this.height,
      required this.size,
      required this.md5,
      required this.type,
      required this.uploadedDate,
      required this.url});
}

final class MetadataMainGameItem {
  final String id;
  final String namespace;
  final bool unsearchable;

  Map<String, dynamic> toJson() =>
      {"id": id, "namespace": namespace, "unsearchable": unsearchable};

  factory MetadataMainGameItem.fromJson(Map<String, dynamic> obj) =>
      MetadataMainGameItem(
          id: obj["id"],
          namespace: obj["namespace"],
          unsearchable: obj["unsearchable"]);

  MetadataMainGameItem(
      {required this.id, required this.namespace, required this.unsearchable});
}

final class Metadata {
  final String applicationId;
  final DateTime creationDate;
  final Map<String, MetadataAttribute?> customAttributes;
  final String description;
  final String developer;
  final String developerId;
  final bool endOfSupport;
  final String entitlementName;
  final String entitlementType;
  final List<String> eulaIds;
  final String id;
  final String itemType;
  final List<MetadataImage> keyImages;
  final DateTime lastModifiedDate;
  final MetadataMainGameItem? mainGameItem;
  final String namespace;
  final bool requiresSecureAccount;
  final String status;
  final String title;
  final bool unsearchable;

  Map<String, dynamic> toJson() => {
        "applicationId": applicationId,
        "creationDate": creationDate.toIso8601String(),
        "customAttributes": customAttributes
            .map((key, value) => MapEntry(key, value?.toJson())),
        "description": description,
        "developer": developer,
        "developerId": developerId,
        "endOfSupport": endOfSupport,
        "entitlementName": entitlementName,
        "entitlementType": entitlementType,
        "eulaIds": eulaIds,
        "id": id,
        "itemType": itemType,
        "keyImages": keyImages.map((e) => e.toJson()),
        "lastModifiedDate": lastModifiedDate.toIso8601String(),
        "mainGameItem": mainGameItem?.toJson(),
        "namespace": namespace,
        "requiresSecureAccount": requiresSecureAccount,
        "status": status,
        "title": title,
        "unsearchable": unsearchable
      };

  factory Metadata.fromJson(Map<String, dynamic> obj) => Metadata(
      applicationId: obj["applicationId"],
      creationDate: DateTime.parse(obj["creationDate"]),
      customAttributes: obj["customAttributes"].map(
          (key, value) => MapEntry(key, MetadataAttribute.fromJson(value))),
      description: obj["description"],
      developer: obj["developer"],
      developerId: obj["developerId"],
      endOfSupport: obj["endOfSupport"],
      entitlementName: obj["entitlementName"],
      entitlementType: obj["entitlementType"],
      eulaIds: obj["eulaIds"],
      id: obj["id"],
      itemType: obj["itemType"],
      keyImages: obj["keyImages"].map((e) => MetadataImage.fromJson(e)),
      lastModifiedDate: DateTime.parse(obj["lastModifiedDate"]),
      mainGameItem: MetadataMainGameItem.fromJson(obj["mainGameItem"]),
      namespace: obj["namespace"],
      requiresSecureAccount: obj["requiresSecureAccount"],
      status: obj["status"],
      title: obj["title"],
      unsearchable: obj["unsearchable"]);

  const Metadata(
      {required this.applicationId,
      required this.creationDate,
      required this.customAttributes,
      required this.description,
      required this.developer,
      required this.developerId,
      required this.endOfSupport,
      required this.entitlementName,
      required this.entitlementType,
      required this.eulaIds,
      required this.id,
      required this.itemType,
      required this.keyImages,
      required this.lastModifiedDate,
      required this.namespace,
      required this.requiresSecureAccount,
      required this.status,
      required this.title,
      required this.unsearchable,
      required this.mainGameItem});
}

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
      metadata: Metadata.fromJson(metadata),
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
  final Metadata metadata;
  String? appVersion(String platform) => assetInfos[platform]?.buildVersion;
  bool get isDLC => metadata.mainGameItem == null;
  String? get thirdPartyStore =>
      metadata.customAttributes["ThirdPartyManagedApp"]?.value;
  String? get partnerLinkType =>
      metadata.customAttributes["partnerLinkType"]?.value;
  String? get partnerLinkId =>
      metadata.customAttributes["partnerLinkId"]?.value;
  bool get supportsCloudSaves =>
      metadata.customAttributes["CloudSaveFolder"] == null;
  bool get supportsMacCloudSaves =>
      metadata.customAttributes["CloudSaveFolder_MAC"] == null;
  String get catalogItemId => metadata.id;
  String get namespace => metadata.namespace;

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

  factory Game.fromJson(Map<String, dynamic> obj) => Game(
        appName: obj["app_name"],
        appTitle: obj["app_title"],
        assetInfos: obj["asset_infos"].map<String, GameAsset>(
            (String key, dynamic asset) =>
                MapEntry(key, GameAsset.fromJson(asset))),
        baseURLs: List<String>.from(obj["base_urls"]),
        metadata: Metadata.fromJson(obj["metadata"]),
      );
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

  factory InstalledGame.fromJson(Map<String, dynamic> obj) => InstalledGame(
        appName: obj["app_name"],
        installPath: obj["install_path"],
        title: obj["title"],
        version: obj["version"],
        baseURLs: List<String>.from(obj["base_urls"]),
        canRunOffline: obj["can_run_offline"],
        eglGuid: obj["egl_guid"],
        executable: obj["executable"],
        installSize: obj["install_size"],
        installTags: List<String>.from(obj["install_tags"]),
        isDLC: obj["is_dlc"],
        launchParameters: obj["launch_parameters"],
        manifestPath: obj["manifest_path"],
        needsVerification: obj["needs_verification"],
        platform: obj["platform"],
        prereqInfo: obj["prereq_info"],
        requiresOt: obj["requires_ot"],
        savePath: obj["save_path"],
      );

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

  factory LaunchParameters.fromJson(Map<String, dynamic> obj) =>
      LaunchParameters(
          gameParameters: List<String>.from(obj["game_parameters"]),
          gameExecutable: obj["game_executable"],
          gameDirectory: obj["game_directory"],
          eglParameters: List<String>.from(obj["egl_parameters"]),
          launchCommand: List<String>.from(obj["launch_command"]),
          workingDirectory: obj["working_directory"],
          userParameters: List<String>.from(obj["user_parameters"]),
          environment: Map<String, String>.from(obj["environment"]),
          preLaunchCommand: obj["pre_launch_command"],
          preLaunchWait: obj["pre_launch_wait"]);

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
