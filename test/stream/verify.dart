import 'dart:convert';
import 'package:test/test.dart';
import 'package:legendary/legendary.dart';

void verifyTest() async {
  late CommonError? infoError;
  late Stream<VerifyProgress> infoProgress;

  setUp(() async {
    final info = await LegendaryStreamClient(LegendaryProcess(
            stdout: Stream.empty(),
            stderr: Stream.fromIterable(['[cli] ERROR: Game "Anchovy" is not installed'])))
        .verify("Anchovy");
    infoError = await info.error;
    infoProgress = info.progress;
  });

  test("Not installed error throws", () {
    expect(infoError, equals(CommonError.notInstalled));
  });
}
