import 'package:test/test.dart';
import 'package:legendary/legendary.dart';

void statusTest() async {
  late Status status;
  setUp(() async {
    final process = LegendaryProcess(
      stdout: Stream.fromIterable(
        [
          "{",
          '"account": "example"',
          ',"games_available": 0,'
          '"games_installed": 0',
          ',"egl_sync_enabled": false,',
          '"config_directory": null',
          "}"
        ]
      ),
      stderr: Stream.empty()
    );

    final client = LegendaryStreamClient(
      startProcess: (_) => Future.value(process),
      verbosePrint: (_) {}
    );

    status = await client.status();
  });
  test("status is a Status", () {
    expect(status, isA<Status>());
  });

  group("Status fields are correct", () {
    test("Status.account equals example", () {
      expect(
        status.account,
        equals("example")
      );
    });

    test("Status.gamesAvailable equals 0", () {
      expect(
        status.gamesAvailable,
        equals(0)
      );
    });

    test("Status.gamesInstalled equals 0", () {
      expect(
        status.gamesInstalled,
        equals(0)
      );
    });

    test("Status.eglSyncEnabled equals false", () {
      expect(
        status.eglSyncEnabled,
        equals(false)
      );
    });

    test("Status.configDirectory equals null", () {
      expect(
        status.configDirectory,
        equals(null)
      );
    });
  });
}