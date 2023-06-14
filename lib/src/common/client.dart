import 'dart:convert';

import 'package:legendary/legendary.dart';
import 'package:legendary/src/io/watch_stream.dart';

class LegendaryProcess {
  final Stream<String> stdout;
  final Stream<String> stderr;

  LegendaryProcess({ required this.stdout, required this.stderr });
}

abstract class LegendaryBaseClient {
  Future<LegendaryProcess> getStream(List<String> arguments);
  Future<InstalledGame> info(String appName) async {
    final stream = await getStream(["info", appName]);
    final processedStream = await watchStreamAndReturnSum(stream.stdout);

    final json = jsonDecode(processedStream);

    return InstalledGame.fromJson(
      Map<String, dynamic>.from(json)
    );
  }

  Future<List<Game>> list() async {
    final stream = await getStream(["list"]);
    final processedStream = await watchStreamAndReturnSum(stream.stdout);

    final json = jsonDecode(processedStream);

    return GameList.fromList(
      List<dynamic>.from(json)
    );
  }

  Future<List<InstalledGame>> listInstalled() async {
    final stream = await getStream(["list-installed"]);
    final String processedStream = await watchStreamAndReturnSum(stream.stdout);

    final json = jsonDecode(processedStream);

    return InstalledGameList.fromList(
      List<dynamic>.from(json)
    );
  }

  Stream<String> launch(String appName) async* {
    final stream = await getStream(["launch", appName]);

    yield* stream.stdout;
    yield* stream.stderr;
  }

  Stream<int> install(String appName) async* {
    // TODO: implement install
    throw UnimplementedError();
  }

  Stream<int> move(String appName, String path) async* {
    // TODO: implement move
    throw UnimplementedError();
  }

  Future<Status> status() async {
    final stream = await getStream(["status"]);
    final processedStream = await watchStreamAndReturnSum(stream.stdout);

    final json = jsonDecode(processedStream);

    return Status.fromJson(
      Map<String, dynamic>.from(json)
    );
  }

  Stream<int> uninstall(String appName) {
    // TODO: implement uninstall
    throw UnimplementedError();
  }

  Future<void> setLogin(String code, { sid, token }) async {
    final stream = await getStream(["auth", "--code", code]);
    final String successStatement = "[cli] INFO: Successfully logged in as ";

    return await watchStreamAndWatchForString(stream.stderr, string: successStatement);
  }

  Future<void> deleteLogin() async {
    final stream = await getStream(["auth", "--delete"]);
    const String successStatement = "[cli] INFO: User data deleted.";

    return await watchStreamAndWatchForString(
      stream.stderr,
      string: successStatement,
    );
  }

  Future<void> cleanup() async {
    final stream = await getStream(["cleanup"]);
    const String successStatement = "[cli] INFO: Cleanup complete! Removed";

    return await watchStreamAndWatchForString(
      stream.stderr,
      string: successStatement
    );
  }

  Stream<int> import(String appName, String location) {
    // TODO: implement import
    throw UnimplementedError();
  }

  Stream<int> verify(String appName) {
    // TODO: implement verify
    throw UnimplementedError();
  }
}
