# 0.1.2

- **BREAKING:** made methods `info`, `list` and `listInstalled` use `Result`. Now, to to use them, you must `info = await client.info()` and then `await info.data`

# 0.1.1

- **BREAKING:** renamed `LegendaryProcessClient` to `LegendaryClient`
- Implemented methods `launch`, `verify`, `install`, `import`.
- Published docs to https://aitor-gomila.github.io/legendary-dart

## 0.1.0

First public version published to pub.dev

- Added support for methods `list`, `listInstalled`, `info`, and `status` of `LegendaryProcessClient`.
- Added unit testing for types `Game`, `InstalledGame`, `Status`.
- Added support for methods `setLogin` and `deleteLogin` of `LegendaryProcessClient`.
- Added unit testing for methods `status`, and `info` using `LegendaryStreamClient`.
