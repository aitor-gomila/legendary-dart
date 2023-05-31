import 'dart:convert';

Future<T?> watchStreamForJson<T>({
  required Stream<String> input,
  required T Function(dynamic) transform,
}) async {
  dynamic obj;

  await for (final text in input) {
    try {
      obj = jsonDecode(text);
    } catch (_) {
      continue;
    }

    if (obj == null) throw "obj is null";

    return transform(obj);
  }
  return null;
}
