Future<T> watchStream<T>({
  required Stream<String> input,
  required T Function(String) transform,
  bool verbose = false
}) async {
  String output = "";

  await for (final text in input) {
    output += text;
  }

  return transform(output);
}
