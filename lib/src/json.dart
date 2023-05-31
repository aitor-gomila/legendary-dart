import 'dart:io';
import 'dart:convert';

Future<T> watchStreamForJson<T>({
  required Stream<String> input,
  required T Function(dynamic) transform,
  bool verbose = false
}) async {
  String output = "";

  await for (final text in input) {
    output += text;
  }

  return transform(jsonDecode(output));
}
