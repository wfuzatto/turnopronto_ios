#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "Este bootstrap do iOS deve ser executado no macOS." >&2
  exit 1
fi

command -v flutter >/dev/null 2>&1 || {
  echo "Flutter não encontrado. Instale o Flutter e rode novamente." >&2
  exit 1
}

echo "==> Flutter"
flutter --version

echo "==> Gerando shell nativo iOS"
flutter create   --platforms=ios   --project-name turnopronto_ios   --org br.com.turnopronto   .

echo "==> Dependências"
flutter pub get

echo "==> Verificação da API HTTPS"
curl --fail --silent --show-error --max-time 20   https://turnopronto1.websiteseguro.com/api/v1/health >/dev/null

echo "==> Pronto."
echo "Simulator: flutter run -d ios"
echo "Xcode/iPhone: open ios/Runner.xcworkspace"
