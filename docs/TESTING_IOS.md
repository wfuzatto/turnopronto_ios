# Testes do TurnoPronto iOS

## 1. iOS Simulator no Mac

Requisitos:

- macOS
- Xcode
- Flutter estável
- Xcode Command Line Tools

Execute:

```bash
./bootstrap_ios.sh
flutter run -d ios
```

Ou gere o pacote do Simulator:

```bash
./scripts/build_simulator.sh
```

Saída:

```text
build/TurnoPronto-iOS-Simulator.zip
```

O ZIP do GitHub Actions é para **iOS Simulator**, não é um IPA instalável em iPhone físico.

## 2. iPhone físico pelo Xcode

Execute:

```bash
./bootstrap_ios.sh
open ios/Runner.xcworkspace
```

No Xcode:

1. Selecione **Runner**.
2. Abra **Signing & Capabilities**.
3. Selecione sua Apple Developer Team.
4. Se necessário, defina um Bundle Identifier exclusivo.
5. Conecte o iPhone por cabo ou Wi‑Fi.
6. Selecione o iPhone como destino.
7. Pressione **Run**.

Para teste pessoal, o Xcode pode assinar automaticamente usando seu Apple ID/Team. Para distribuição a outros aparelhos, prepare TestFlight/App Store Connect.

## 3. API

A URL de teste padrão é:

```text
https://turnopronto1.websiteseguro.com/api/v1
```

Ela é HTTPS e compatível com o App Transport Security do iOS.

Para trocar no build:

```bash
flutter run -d ios --dart-define=API_URL=https://exemplo/api/v1
```

## 4. Assinatura

Nunca versionar:

- certificados `.p12`
- provisioning profiles
- chaves privadas
- senhas
- credenciais da App Store Connect

O workflow atual não precisa de assinatura porque gera somente build do Simulator.
