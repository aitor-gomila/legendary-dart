`legendary` is a Dart package that lets you interact with [Legendary](https://github.com/derrod/legendary), an epic games launcher for linux, windows, and mac, directly from code. It is used in my [Flutter-based Epic Games Launcher](https://github.com/aitor-gomila/flutter-epic-games-launcher).

## Features

- Authenticate and log out.
- List your bought games.
- List your installed games.
- Install games and import games that are already installed.
- Everything else that Legendary can do! [Report missing or broken features.](https://github.com/aitor-gomila/legendary-dart/issues/new)

## Getting started

First, use `dart pub add legendary` to add the package to your project. Then, import it, and use it!:

```dart
import 'package:legendary/legendary.dart';

void main() async {
    final client = LegendaryProcessClient(legendaryPath: "absolute/path/to/legendary.exe");
    await client.setLogin("auth_token", token: "", sid: "");
    await client.status();
    await client.list();
}
```

You can see the types in the [github repository](https://github.com/aitor-gomila/legendary-dart) or in your IDE intellisense.

You can also see examples in the [example directory](https://github.com/aitor-gomila/legendary-dart/tree/main/example).

## Additional information

- Backend: [Legendary from derroid](https://github.com/derroid/legendary)
- My Flutter-based: [Epic Games Launcher from aitor-gomila](https://github.com/aitor-gomila/flutter-epic-games-launcher)
- Inspired by: [Heroic Games Launcher from flavioislima](https://github.com/Heroic-Games-Launcher/HeroicGamesLauncher)
