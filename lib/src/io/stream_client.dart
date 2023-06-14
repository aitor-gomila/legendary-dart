import 'dart:convert';

import 'package:legendary/legendary.dart';
import 'package:legendary/src/io/watch_stream.dart';

// Used for unit testing

class LegendaryStreamClient extends LegendaryBaseClient {
  final LegendaryProcess process;

  Future<LegendaryProcess> getStream(List<String> arguments) async {
    return process;
  }

  LegendaryStreamClient(this.process);
}
