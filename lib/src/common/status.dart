final class Status {
  const Status(
      {required this.account,
      required this.gamesAvailable,
      required this.gamesInstalled,
      required this.eglSyncEnabled,
      required this.configDirectory});

  final String account;
  final int gamesAvailable;
  final int gamesInstalled;
  final bool eglSyncEnabled;
  final String? configDirectory;

  Map<String, dynamic> toJson() => {
        "account": account,
        "games_available": gamesAvailable,
        "games_installed": gamesInstalled,
        "egl_sync_enabled": eglSyncEnabled,
        "config_directory": configDirectory,
      };

  factory Status.fromJson(Map<String, dynamic> obj) {
    final account = obj["account"];
    final gamesAvailable = obj["games_available"];
    final gamesInstalled = obj["games_installed"];
    final eglSyncEnabled = obj["egl_sync_enabled"];
    final configDirectory = obj["config_directory"];

    return Status(
      account: account,
      gamesAvailable: gamesAvailable,
      gamesInstalled: gamesInstalled,
      eglSyncEnabled: eglSyncEnabled,
      configDirectory: configDirectory,
    );
  }
}
