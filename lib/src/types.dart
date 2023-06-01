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

  factory Image.fromJson(Map<String, dynamic> obj) {
    final alt = obj["alt"];
    if (alt is! String) throw "alt is not a String. it is a ${alt.runtimeType}";

    final width = obj["width"];
    if (width is! int) throw "width is not a int. it is a ${width.runtimeType}";

    final height = obj["height"];
    if (height is! int) throw "height is not a int. it is a ${height.runtimeType}";

    final md5 = obj["md5"];
    if (md5 is! String) throw "md5 is not a String. it is a ${md5.runtimeType}";

    final size = obj["size"];
    if (size is! int) throw "size is not a int. it is a ${size.runtimeType}";

    final type = obj["type"];
    if (type is! String) throw "type is not a String. it is a ${type.runtimeType}";

    final uploadedDate = obj["uploadedDate"];
    if (uploadedDate is! String) throw "uploadedDate is not a String. it is a ${uploadedDate.runtimeType}";

    final url = obj["url"];
    if (url is! String) throw "url is not a String. it is a ${url.runtimeType}";

    return Image(
      alt: alt,
      width: width,
      height: height,
      md5: md5,
      size: size,
      type: type,
      uploadedDate: DateTime.parse(uploadedDate),
      url: url,
    );
  }
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

  factory Metadata.fromJson(Map<String, dynamic> obj) {
    final applicationId = obj["application_id"];
    if (applicationId is! String) throw "applicationId is not a String. it is a ${applicationId.runtimeType}";
    
    final creationDate = obj["creationDate"];
    if (creationDate is! String) throw "creationDate is not a String. it is a ${creationDate.runtimeType}";
    
    final description = obj["description"];
    if (description is! String) throw "description is not a String. it is a ${description.runtimeType}";

    final developer = obj["developer"];
    if (developer is! String) throw "developer is not a String. it is a ${developer.runtimeType}";
    
    final developerId = obj["developerId"];
    if (developerId is! String) throw "developerId is not a String. it is a ${developerId.runtimeType}";
    
    final endOfSupport = obj["endOfSupport"];
    if (endOfSupport is! bool) throw "endOfSupport is not a bool. it is a ${endOfSupport.runtimeType}";
    
    final entitlementName = obj["entitlementName"];
    if (entitlementName is! String) throw "entitlementName is not a String. it is a ${entitlementName.runtimeType}";

    final entitlementType = obj["entitlementType"];
    if (entitlementType is! String) throw "entitlementType is not a String. it is a ${entitlementType.runtimeType}";

    final id = obj["id"];
    if (id is! String) throw "id is not a String. it is a ${id.runtimeType}";

    final itemType = obj["itemType"];
    if (itemType is! String) throw "itemType is not a String. it is a ${itemType.runtimeType}";

    final uncheckedKeyImages = obj["keyImages"];
    if (uncheckedKeyImages is! List) throw "uncheckedKeyImages is not a List. it is a ${uncheckedKeyImages.runtimeType}";

    final keyImages = uncheckedKeyImages.map((obj) => Image.fromJson(obj)).toList();

    final lastModifiedDate = obj["lastModifiedDate"];
    if (lastModifiedDate is! String) throw "lastModifiedDate is not a String. it is a ${lastModifiedDate.runtimeType}";

    final namespace = obj["namespace"];
    if (namespace is! String) throw "namespace is not a String. it is a ${namespace.runtimeType}";

    final requiresSecureAccount = obj["requiresSecureAccount"];
    if (requiresSecureAccount is! bool) throw "requiresSecureAccount is not a bool. it is a ${requiresSecureAccount.runtimeType}";

    final status = obj["status"];
    if (status is! String) throw "status is not a String. it is a ${status.runtimeType}";

    final title = obj["title"];
    if (title is! String) throw "title is not a String. it is a ${title.runtimeType}";

    final unsearchable = obj["unsearchable"];
    if (unsearchable is! bool) throw "unsearchable is not a bool. it is a ${unsearchable.runtimeType}";

    return Metadata(
      applicationId: applicationId,
      creationDate: DateTime.parse(creationDate),
      description: description,
      developer: developer,
      developerId: developerId,
      endOfSupport: endOfSupport,
      entitlementName: entitlementName,
      entitlementType: entitlementType,
      id: id,
      itemType: itemType,
      keyImages: keyImages,
      lastModifiedDate: DateTime.parse(lastModifiedDate),
      namespace: namespace,
      requiresSecureAccount: requiresSecureAccount,
      status: status,
      title: title,
      unsearchable: unsearchable,
    );
  }
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
    final appName = obj["app_name"];
    final appTitle = obj["app_title"];
    final baseURLs = obj["base_urls"];
    final dlcs = obj["dlcs"];
    final metadata = obj["metadata"];

    if (appName is! String) throw "app_name is not a String. it is a ${appName.runtimeType}";
    if (appTitle is! String) throw "app_title is not a String. it is a ${appTitle.runtimeType}";
    if (baseURLs is! List<dynamic>) throw "base_urls is not a List<dynamic>. it is a ${baseURLs.runtimeType}";
    for (final url in baseURLs) {
      if (url is! String) throw "url from base_urls is not a String. it is a ${url.runtimeType}";
    }

    if (dlcs is! List<dynamic>) throw "dlcs is not a List<dynamic>. it is a ${dlcs.runtimeType}";
    for (final url in dlcs) {
      if (url is! String) throw "url from dlcs is not a String. it is a ${url.runtimeType}";
    }

    if (metadata is! Map<String, dynamic>) throw "metadata is not a Metadata. it is a ${metadata.runtimeType}";

    return Game(
      metadata: Metadata.fromJson(metadata),
      appName: appName,
      appTitle: appTitle,
      baseURLs: baseURLs as List<String>,
      dlcs: dlcs as List<String>,
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
