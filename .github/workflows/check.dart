name: Test source code

on:
  pull_request:
    branches: [main]
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: dart-lang/setup-dart@v1

      - run: dart pub get
      - run: dart format --output=none --set-exit-if-changed .
      - run: dart analyze
      - run: dart test
