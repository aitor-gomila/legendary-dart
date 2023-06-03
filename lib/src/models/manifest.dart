final class Manifest {
  final int headerSize;
  final int sizeCompressed;
  final int sizeUncompressed;
  final String shaHash;
  final int storedAs;
  final int version;
  final List<int> data;

  final List<ManifestMeta>? meta;
  final List<CDL>? chunkDataList;
  final List<FML>? fileManifestList;
  final List<CustomFields>? customFields;

  int get compressed => storedAs & 0x1;

  const Manifest({
    required this.headerSize,
    required this.sizeCompressed,
    required this.sizeUncompressed,
    required this.shaHash,
    required this.storedAs,
    required this.version,
    required this.data,
    this.meta,
    this.chunkDataList,
    this.fileManifestList,
    this.customFields,
  });
}

final class ManifestMeta {
  final int metaSize;
  final int dataVersion;
  final int featureLevel;
  final bool isFileData;
  final int appId;
  final String appName;
  final String buildVersion;
  final String launchExe;
  final String launchCommand;
  final List<String> prereqIds;
  final String prereqName;
  final String prereqPath;
  final String prereqArgs;
  final String uninstallActionPath;
  final String uninstallActionArgs;

  final String buildId;

  const ManifestMeta({
    required this.metaSize,
    required this.dataVersion,
    required this.featureLevel,
    required this.isFileData,
    required this.appId,
    required this.appName,
    required this.buildVersion,
    required this.launchExe,
    required this.launchCommand,
    required this.prereqIds,
    required this.prereqName,
    required this.prereqPath,
    required this.prereqArgs,
    required this.uninstallActionPath,
    required this.uninstallActionArgs,
    required this.buildId,
  });
}

final class CDL {
  final int version;
  final int size;
  final int count;
  final List<dynamic> elements;

  const CDL({
    required this.version,
    required this.size,
    required this.count,
    required this.elements,
  });
}

final class FML {
  final int version;
  final int size;
  final int count;
  final List<dynamic> elements;

  const FML({
    required this.version,
    required this.size,
    required this.count,
    required this.elements,
  });
}

final class FileManifest {
  final String fileName;
  final String symlinkTarget;
  final List<int> hash;
  final int flags;
  final List installTags;
  final List chunkParts;
  final int fileSize;
  final List<int> hashMd5;
  final String mimeType;
  final List<int> hashSha256;

  int get readOnly => flags & 0x1;
  int get compressed => flags & 0x2;
  int get executable => flags & 0x4;
  List<int> get shaHash => hash;

  const FileManifest({
    required this.fileName,
    required this.symlinkTarget,
    required this.hash,
    required this.flags,
    required this.installTags,
    required this.chunkParts,
    required this.fileSize,
    required this.hashMd5,
    required this.mimeType,
    required this.hashSha256,
  });
}

final class CustomFields {
  final int size;
  final int version;
  final int count;

  const CustomFields({
    required this.size,
    required this.version,
    required this.count,
  });
}