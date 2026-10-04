#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Build iOS exige macOS." >&2
  exit 1
fi

./bootstrap_ios.sh

flutter analyze
flutter test

flutter build ios   --simulator   --debug

APP_PATH="build/ios/iphonesimulator/Runner.app"
OUT="build/TurnoPronto-iOS-Simulator.zip"

test -d "$APP_PATH"
rm -f "$OUT"
ditto -c -k --sequesterRsrc --keepParent "$APP_PATH" "$OUT"

echo "Gerado: $OUT"
