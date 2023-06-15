import 'dart:convert';

import 'package:legendary/legendary.dart';

// Used for unit testing

class LegendaryStreamClient extends LegendaryBaseClient {
  final LegendaryProcess process;

  Future<LegendaryProcess> getStream(List<String> arguments) async {
    return process;
  }

  LegendaryStreamClient(this.process);
}
