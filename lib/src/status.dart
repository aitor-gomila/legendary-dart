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
  
  factory Status.fromMap(Map<String, dynamic> obj) {
    var account = obj["account"];
    var gamesAvailable = obj["games_available"];
    var gamesInstalled = obj["games_installed"];
    var eglSyncEnabled = obj["egl_sync_enabled"];
    var configDirectory = obj["config_directory"];

    if (account.runtimeType != String) throw "account is not type String. it is ${account.runtimeType}";
    if (gamesAvailable.runtimeType != int) throw "gamesAvailable is not type int. it is ${gamesAvailable.runtimeType}";
    if (gamesInstalled.runtimeType != int) throw "gamesInstalled is not type int. it is ${gamesInstalled.runtimeType}";
    if (eglSyncEnabled.runtimeType != bool) throw "eglSyncEnabled is not type bool. it is ${eglSyncEnabled.runtimeType}";
    if (configDirectory.runtimeType != String) throw "configDirectory is not type String. it is ${configDirectory.runtimeType}";

    return Status(
      account: account,
      gamesAvailable: gamesAvailable,
      gamesInstalled: gamesInstalled,
      eglSyncEnabled: eglSyncEnabled,
      configDirectory: configDirectory,
    );
  }
}