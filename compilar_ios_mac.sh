#!/usr/bin/env bash
set -euo pipefail

# TurnoPronto iOS: prepare the Flutter project on macOS and open Xcode.
# Signing is configured locally in Xcode, never committed to GitHub.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Erro: execute este script no macOS." >&2
  exit 1
fi
for command in git flutter xcodebuild; do
  if ! command -v "$command" >/dev/null 2>&1; then
    echo "Erro: $command nao encontrado. Instale-o antes de continuar." >&2
    exit 1
  fi
done

echo "==> Verificando alteracoes locais"
if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
  echo "Existem alteracoes locais rastreadas. Faca commit/stash antes de atualizar." >&2
  exit 1
fi

if [[ "${1:-}" != "--sem-pull" ]]; then
  echo "==> Atualizando codigo do GitHub (somente fast-forward)"
  git pull --ff-only
fi

echo "==> Verificando ambiente Flutter/Xcode"
flutter doctor -v

echo "==> Preparando projeto nativo iOS"
# Flutter-managed iOS files are generated locally; existing Xcode configuration is preserved.
if [[ ! -f ios/Runner.xcodeproj/project.pbxproj ]]; then
  flutter create --platforms=ios --project-name turnopronto_ios --org br.com.turnopronto .
fi
flutter pub get

# iOS location permission required by the Android-equivalent geolocation feature.
if [[ -f ios/Runner/Info.plist ]]; then
  /usr/bin/python3 - <<'PY'
import plistlib
from pathlib import Path
path = Path("ios/Runner/Info.plist")
with path.open("rb") as stream:
    plist = plistlib.load(stream)
plist["NSLocationWhenInUseUsageDescription"] = (
    "O TurnoPronto utiliza sua localização, com sua permissão, "
    "para mostrar vagas próximas e calcular a distância até o trabalho."
)
with path.open("wb") as stream:
    plistlib.dump(plist, stream, fmt=plistlib.FMT_XML, sort_keys=False)
PY
fi

if [[ -f ios/Podfile ]]; then
  if ! command -v pod >/dev/null 2>&1; then
    echo "CocoaPods ausente. Instale-o antes de compilar se o projeto exigir pods." >&2
    exit 1
  fi
  (cd ios && pod install)
fi

echo "==> Abrindo Xcode"
if [[ -d ios/Runner.xcworkspace ]]; then
  open ios/Runner.xcworkspace
else
  open ios/Runner.xcodeproj
fi
echo "Selecione Runner > Signing & Capabilities > seu Personal Team."
echo "Conecte o iPhone, selecione-o como destino e pressione Run (Cmd+R)."
