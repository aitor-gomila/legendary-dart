final class Status {
  const Status({
    required this.account,
    required this.gamesAvailable,
    required this.gamesInstalled,
    required this.eglSyncEnabled,
    required this.configDirectory
  });

  final String account;
  final int gamesAvailable;
  final int gamesInstalled;
  final bool eglSyncEnabled;
  final String configDirectory;
  
  factory Status.fromJson(dynamic obj) {
    if (obj is! Map<String, dynamic>) throw "obj is not a Map<String, dynamic>. it is a ${obj.runtimeType}";

    final account = obj["account"];
    final gamesAvailable = obj["games_available"];
    final gamesInstalled = obj["games_installed"];
    final eglSyncEnabled = obj["egl_sync_enabled"];
    final configDirectory = obj["config_directory"];

    if (account is! String) throw "account is not type String. it is ${account.runtimeType}";
    if (gamesAvailable is! int) throw "gamesAvailable is not type int. it is ${gamesAvailable.runtimeType}";
    if (gamesInstalled is! int) throw "gamesInstalled is not type int. it is ${gamesInstalled.runtimeType}";
    if (eglSyncEnabled is! bool) throw "eglSyncEnabled is not type bool. it is ${eglSyncEnabled.runtimeType}";
    if (configDirectory is! String) throw "configDirectory is not type String. it is ${configDirectory.runtimeType}";

    return Status(
      account: account,
      gamesAvailable: gamesAvailable,
      gamesInstalled: gamesInstalled,
      eglSyncEnabled: eglSyncEnabled,
      configDirectory: configDirectory,
    );
  }
}