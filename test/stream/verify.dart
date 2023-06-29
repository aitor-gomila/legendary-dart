import 'dart:convert';
import 'package:test/test.dart';
import 'package:legendary/legendary.dart';

void verifyTest() async {
  test("Not installed error throws", () async {
    final info = await LegendaryStreamClient(LegendaryProcess(
            stdout: Stream.empty(),
            stderr: Stream.fromIterable([
              '[cli] INFO: Loading installed manifest for "Anchovy"',
              '[cli] ERROR: Game "Anchovy" is not installed'
            ]).transform(utf8.encoder)))
        .verify("Anchovy");

    expect(await info.error, equals(CommonError.notInstalled));
  });

  test("Install path doesn't exist throws", () async {
    final info = await LegendaryStreamClient(LegendaryProcess(
            stdout: Stream.empty(),
            stderr: Stream.fromIterable([
              '[cli] INFO: Loading installed manifest for "Anchovy"',
              '[cli] ERROR: Install path "/home/aitor/Games/RaymanLegends" does not exist, make sure all necessary mounts are available. If you previously deleted the game folder without uninstalling, run "legendary uninstall -y Anchovy" and reinstall from scratch.'
            ]).transform(utf8.encoder)))
        .verify("Anchovy");

    expect(await info.error, equals(CommonError.pathNotExist));
  });

  test("Correct verify is accurate", () async {
    final info = await LegendaryStreamClient(LegendaryProcess(
            stdout: Stream.fromIterable([
              'Verification progress: 0/260 (0.0%) [0.0 MiB/s]	',
              'Verification progress: 260/260 (100.0%) [439.8 MiB/s]'
            ]).transform(utf8.encoder),
            stderr: Stream.fromIterable([
              '[cli] INFO: Loading installed manifest for "Anchovy"',
              '[cli] INFO: Verifying "Rayman Legends" version "1.00"',
              '[cli] INFO: Verification finished successfully.'
            ]).transform(utf8.encoder)))
        .verify("Anchovy");

    final progress = await info.data.toList();

    expect(await info.error, equals(null));
    expect(
        progress[0],
        equals(VerifyProgress(
            currentPart: 0,
            totalParts: 260,
            percentage: 0,
            speed: 0,
            unit: "MiB/s")));
    expect(
        progress[1],
        equals(VerifyProgress(
            currentPart: 260,
            totalParts: 260,
            percentage: 100,
            speed: 439.8,
            unit: "MiB/s")));
  });
}
