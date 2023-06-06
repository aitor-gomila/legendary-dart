import 'dart:io';
import 'dart:convert';

import 'package:legendary/legendary.dart';
import 'package:legendary/src/io/watch_stream.dart';

class LegendaryProcess {
  final Stream<String> stdout;
  final Stream<String> stderr;

  LegendaryProcess({
    required this.stdout,
    required this.stderr,
  });
}

typedef ProcessStarterFunction = Future<LegendaryProcess> Function(List<String>);

// Used for unit testing, and separation of concerns

class LegendaryStreamClient extends LegendaryBaseClient {
  final ProcessStarterFunction startProcess;
  final bool verbose;

  LegendaryStreamClient({ required this.startProcess, this.verbose = false });

  @override
  Future<InstalledGame> info(String appName) async {
    final process = await startProcess(["info", appName]);
    final stream = await watchStreamAndReturnSum(process.stdout);
    if (verbose) stderr.write(stream);

    final json = jsonDecode(stream);
    if (json is! Map<String, dynamic>) throw "json is not a Map<String, dynamic>. it is a ${json.runtimeType}";

    return InstalledGame.fromJson(json);
  }

  @override
  Future<List<Game>> list() async {
    final process = await startProcess(["list"]);
    final stream = await watchStreamAndReturnSum(process.stdout);
    if (verbose) stderr.write(stream);

    final json = jsonDecode(stream);
    if (json is! List) throw "json is not a List. it is a ${json.runtimeType}";

    return GameList.fromList(json);
  }

  @override
  Future<List<InstalledGame>> listInstalled() async {
    final process = await startProcess(["list-installed"]);
    final String stream = await watchStreamAndReturnSum(process.stdout);
    if (verbose) stderr.write(stream);

    final json = jsonDecode(stream);
    if (json is! List) throw "json is not a List. it is a ${json.runtimeType}";

    return InstalledGameList.fromList(json);
  }

  @override
  Stream<String> launch(String appName) async* {
    final process = await startProcess(["launch", appName]);

    yield* process.stdout;
    yield* process.stderr;
  }

  @override
  Stream<int> install(String appName) {
    // TODO: implement install
    throw UnimplementedError();
  }

  @override
  Stream<int> move(String appName, String path) {
    // TODO: implement move
    throw UnimplementedError();
  }

  @override
  Future<Status> status() async {
    final process = await startProcess(["status"]);
    final stream = await watchStreamAndReturnSum(process.stdout);
    if (verbose) stderr.write(stream);

    final json = jsonDecode(stream);
    if (json is! Map<String, dynamic>) throw "json is not a Map<String, dynamic>. it is a ${json.runtimeType}";

    return Status.fromJson(json);
  }

  @override
  Stream<int> uninstall(String appName) {
    // TODO: implement uninstall
    throw UnimplementedError();
  }

  @override
  Future<void> setLogin(String code, { sid, token }) async {
    // if either sid or token are defined, put them
    // if not, don't
    final sidString = sid != null? "--sid $sid" : "";
    final tokenString = token != null ? "--token $token" : "";

    final process = await startProcess(["auth", "--disable-webview", "--code", code, sidString, tokenString]);
    final String successStatement = "[cli] INFO: Successfully logged in as ";

    return await watchStreamAndWatchForString(process.stderr, string: successStatement);
  }

  @override
  Future<void> deleteLogin() async {
    final process = await startProcess(["auth", "--delete"]);
    const String successStatement = "[cli] INFO: User data deleted.";

    return await watchStreamAndWatchForString(
      process.stderr,
      string: successStatement,
    );
  }

  @override
  Future<void> cleanup() {
    // TODO: implement cleanup
    throw UnimplementedError();
  }

  @override
  Stream<int> import(String appName, String location) {
    // TODO: implement import
    throw UnimplementedError();
  }

  @override
  Stream<int> verify(String appName) {
    // TODO: implement verify
    throw UnimplementedError();
  }
}
