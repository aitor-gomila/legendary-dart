export 'package:legendary/src/status.dart';

final class Image {
  const Image({
    required this.alt,
    required this.width,
    required this.height,
    required this.md5,
    required this.size,
    required this.type,
    required this.uploadedDate,
    required this.url,
  });

  final String alt;
  final int width;
  final int height;
  final String md5;
  final int size;
  final String type;
  final DateTime uploadedDate;
  final String url;
}

final class Metadata {
  const Metadata({
    required this.applicationId,
    required this.creationDate,
    required this.description,
    required this.developer,
    required this.developerId,
    required this.endOfSupport,
    required this.entitlementName,
    required this.entitlementType,
    required this.id,
    required this.itemType,
    required this.keyImages,
    required this.lastModifiedDate,
    required this.namespace,
    required this.requiresSecureAccount,
    required this.status,
    required this.title,
    required this.unsearchable
  });

  final String applicationId;
  final DateTime creationDate;
  final String description;
  final String developer;
  final String developerId;
  final bool endOfSupport;
  final String entitlementName;
  final String entitlementType;
  final String id;
  final String itemType;
  final List<Image> keyImages;
  final DateTime lastModifiedDate;
  final String namespace;
  final bool requiresSecureAccount;
  final String status;
  final String title;
  final bool unsearchable;
}

final class Game {
  const Game({
    required this.metadata,
    required this.appName,
    required this.appTitle,
    required this.baseURLs,
    required this.dlcs,
  });

  final Metadata metadata;
  final String appName;
  final String appTitle;
  final List<String> baseURLs;
  final List<String> dlcs;

  static List<Game> fromList(dynamic list) {
    if (list is! List<dynamic>) throw "list is not a List<dynamic>. it is a ${list.runtimeType}";

    return list.map<Game>((game) {
      if (game is! Map<String, dynamic>) throw "game is not a Map<String, dynamic>. it is a ${game.runtimeType}";

      return Game.fromJson(game);
    }).toList();
  }

  factory Game.fromJson(Map<String, dynamic> obj) {
    var appName = obj["app_name"];
    var appTitle = obj["app_title"];
    var baseURLs = obj["base_urls"];
    var dlcs = obj["dlcs"];
    var metadata = obj["metadata"];

    if (appName is! String) throw "app_name is not a String. it is a ${appName.runtimeType}";
    if (appTitle is! String) throw "app_title is not a String. it is a ${appTitle.runtimeType}";
    if (baseURLs is! List<String>) throw "base_urls is not a List. it is a ${baseURLs.runtimeType}";
    if (dlcs is! List<String>) throw "dlcs is not a List. it is a ${dlcs.runtimeType}";
    if (metadata is! Metadata) throw "metadata is not a Metadata. it is a ${metadata.runtimeType}";

    return Game(
      metadata: metadata,
      appName: appName,
      appTitle: appTitle,
      baseURLs: baseURLs,
      dlcs: dlcs,
    );
  }
}

final class InstalledGame {
  const InstalledGame({
    required this.appName,
    required this.title,
    required this.version,
    required this.cloudSavesSupported,
    required this.cloudSaveFolder,
    required this.cloudSaveFolderMac,
    required this.isDLC,
    required this.external
  });

  final String appName;
  final String title;
  final String version;
  final bool cloudSavesSupported;
  final String cloudSaveFolder;
  final String cloudSaveFolderMac;
  final bool isDLC;
  final bool external;
}

final class GameManifest {
  const GameManifest({
    required this.size,
    required this.type,
    required this.version,
    required this.featureLevel,
    required this.appName,
    required this.launchExe,
    required this.launchCommand,
    required this.buildVersion,
    required this.buildId,
    required this.installTags,
    required this.numFiles,
    required this.numChunks,
    required this.diskSize,
    required this.downloadSize
  });

  final int size;
  final String type;
  final int version;
  final int featureLevel;
  final String appName;
  final String launchExe;
  final String launchCommand;
  final String buildVersion;
  final String buildId;
  final List<String> installTags;
  final int numFiles;
  final int numChunks;
  final int diskSize;
  final int downloadSize;
  
}

final class GameInformation {
  const GameInformation({
    required this.game,
  });

  final InstalledGame game;
}
