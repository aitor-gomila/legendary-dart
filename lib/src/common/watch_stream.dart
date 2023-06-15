Future<String> watchStreamAndReturnSum(Stream<String> input) async {
  String output = "";

  await for (final line in input) {
    output += line;
  }

  return output;
}

Future<void> watchStreamAndWatchForString(Stream<String> input, {
  required String string
}) async {
  bool success = false;

  await for (final line in input) {
    if (line.contains(string)) {
      success = true;
      break;
    }
  }

  if (!success) throw "message $string was not found in stream";
}
