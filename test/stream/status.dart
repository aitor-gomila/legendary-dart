import 'dart:convert';
import 'package:test/test.dart';
import 'package:legendary/legendary.dart';

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
    status = await LegendaryStreamClient(LegendaryProcess(
            stdout: Stream.fromIterable([jsonEncode(correctStatus)]),
            stderr: Stream.empty()))
        .status();
  });

  test("status is a Status", () {
    expect(status, isA<Status>());
  });
  test("status.toJson equals correct status", () {
    expect(status.toJson(), equals(correctStatus.toJson()));
  });
}
