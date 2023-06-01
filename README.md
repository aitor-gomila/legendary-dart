`legendary` is a Dart package that lets you interact with [Legendary](https://github.com/derrod/legendary), an epic games launcher for linux, directly from code. It is used in my [Flutter-based Epic Games Launcher]().

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

First, use `dart pub add legendary` to add the package to your project. Then, import it, and use it!:

```dart
import 'package:legendary/legendary.dart';

void main() async {
    final client = LegendaryClient("absolute/path/to/legendary.exe");
    await client.auth("auth_token");
    await client.status();
    await client.list();
}
```

You can see the types in the [github repository](https://github.com/aitor-gomila/legendary-dart) or in your IDE intellisense.

## Additional information

- [Legendary repository from derroid](https://github.com/derroid/legendary)