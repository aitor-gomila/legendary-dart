import 'dart:convert';
import 'package:test/test.dart';
import 'package:legendary/legendary.dart';

void verifyTest() async {
  test("Not installed error throws", () async {
    final info = await LegendaryStreamClient(LegendaryProcess(
            stdout: Stream.empty(),
            stderr: Stream.fromIterable(
                    ['[cli] ERROR: Game "Anchovy" is not installed'])
                .transform(utf8.encoder)))
        .verify("Anchovy");
    expect(await info.error, equals(CommonError.notInstalled));
  });
}
