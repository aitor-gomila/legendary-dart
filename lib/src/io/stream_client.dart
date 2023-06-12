import 'dart:convert';

import 'package:legendary/legendary.dart';
import 'package:legendary/src/io/watch_stream.dart';

// Used for unit testing

class LegendaryStreamClient {
  static Future<InstalledGame> info(Stream<String> stream, String appName) async {
    final processedStream = await watchStreamAndReturnSum(stream);

    final json = jsonDecode(processedStream);

    return InstalledGame.fromJson(
      Map<String, dynamic>.from(json)
    );
  }

  static Future<List<Game>> list(Stream<String> stream) async {
    final processedStream = await watchStreamAndReturnSum(stream);

    final json = jsonDecode(processedStream);

    return GameList.fromList(
      List<dynamic>.from(json)
    );
  }

  static Future<List<InstalledGame>> listInstalled(Stream<String> stream) async {
    final String processedStream = await watchStreamAndReturnSum(stream);

    final json = jsonDecode(processedStream);

    return InstalledGameList.fromList(
      List<dynamic>.from(json)
    );
  }

  static Stream<String> launch(Stream<String> stream, String appName) {
    return stream;
  }

  static Stream<int> install(Stream<String> stream, String appName) {
    // TODO: implement install
    throw UnimplementedError();
  }

  static Stream<int> move(Stream<String> stream, String appName, String path) {
    // TODO: implement move
    throw UnimplementedError();
  }

  static Future<Status> status(Stream<String> stream) async {
    final processedStream = await watchStreamAndReturnSum(stream);

    final json = jsonDecode(processedStream);

    return Status.fromJson(
      Map<String, dynamic>.from(json)
    );
  }

  static Stream<int> uninstall(Stream<String> stream, String appName) {
    // TODO: implement uninstall
    throw UnimplementedError();
  }

  static Future<void> setLogin(Stream<String> stream, String code, { sid, token }) async {
    final String successStatement = "[cli] INFO: Successfully logged in as ";

    return await watchStreamAndWatchForString(stream, string: successStatement);
  }

  static Future<void> deleteLogin(Stream<String> stream) async {
    const String successStatement = "[cli] INFO: User data deleted.";

    return await watchStreamAndWatchForString(
      stream,
      string: successStatement,
    );
  }

  static Future<void> cleanup(Stream<String> stream) async {
    const String successStatement = "[cli] INFO: Cleanup complete! Removed";

    return await watchStreamAndWatchForString(
      stream,
      string: successStatement
    );
  }

  static Stream<int> import(Stream<String> stream, String appName, String location) {
    // TODO: implement import
    throw UnimplementedError();
  }

  static Stream<int> verify(Stream<String> stream, String appName) {
    // TODO: implement verify
    throw UnimplementedError();
  }
}
