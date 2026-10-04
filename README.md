# TurnoPronto iOS

Aplicativo iOS oficial do TurnoPronto.

Este repositório é **exclusivo para iOS** e não deve conter artefatos Android. O backend/API continua em `wfuzatto/turnopronto_web`.

## Estado

- Flutter
- API fixa: `https://turnopronto.com.br/api/v1`
- Build de teste para iOS Simulator via GitHub Actions
- Preparado para execução no Mac/Xcode
- Preparado para assinatura posterior em iPhone/TestFlight

## Teste rápido no Mac

```bash
git clone https://github.com/wfuzatto/turnopronto_ios.git
cd turnopronto_ios
./bootstrap_ios.sh
flutter pub get
open ios/Runner.xcworkspace
```

Para Simulator sem Xcode aberto:

```bash
flutter run -d ios
```

Para iPhone físico, abra o projeto no Xcode, selecione seu Team em **Signing & Capabilities**, conecte o iPhone e execute.

> Nunca versionar certificados, provisioning profiles, senhas ou chaves privadas.
