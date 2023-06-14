import 'dart:convert';
import 'package:test/test.dart';
import 'package:legendary/legendary.dart';
import 'package:legendary/src/io/stream_client.dart';

void statusTest() async {
  final Status correctStatus = Status(
    account: "example",
    gamesAvailable: 62,
    gamesInstalled: 0,
    eglSyncEnabled: false,
    configDirectory: null,
  );
  late Status status;

  setUp(() async {
    status = await LegendaryStreamClient.status(
      Stream.fromIterable(
        [
          jsonEncode(correctStatus)
        ]
      ),
    );
  });

  test("status is a Status", () {
    expect(status, isA<Status>());
  });
  test("status.toJson equals correct status", () {
    expect(status.toJson(), equals(correctStatus.toJson()));
  });
}
