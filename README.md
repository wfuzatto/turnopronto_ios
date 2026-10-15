# TurnoPronto iOS

Aplicativo Flutter para iPhone do TurnoPronto. A pasta `lib/`, as dependências Flutter e a identidade visual foram sincronizadas com o Android (`wfuzatto/turnopronto_app`, versão 0.4.0). O desenvolvimento acontece no GitHub; o Mac é usado apenas para compilar e instalar pelo Xcode.

- API: `https://turnopronto.com.br/api/v1`
- Backend compartilhado: `wfuzatto/turnopronto_web`
- Build para Simulator: GitHub Actions
- Build para iPhone físico: macOS + Xcode + assinatura local (Personal Team ou Apple Developer)

## Primeira instalação no Mac

1. Instale Xcode pela App Store e abra-o uma vez para aceitar os termos.
2. Instale Flutter SDK, Git e CocoaPods se o projeto solicitar. Verifique com `flutter doctor -v`.
3. Conecte o iPhone ao Mac por cabo, confirme a confiança no computador e habilite o Modo de Desenvolvedor no iPhone.
4. No Terminal:

```bash
git clone https://github.com/wfuzatto/turnopronto_ios.git
cd turnopronto_ios
bash compilar_ios_mac.sh
```

5. No Xcode abra o target **Runner** > **Signing & Capabilities**, marque **Automatically manage signing**, escolha sua conta Apple no campo **Team** e defina um **Bundle Identifier** exclusivo, caso necessário.
6. Selecione o iPhone como destino e pressione **Run** (`Cmd+R`). O Xcode compila, assina e instala o app.

Uma conta Apple gratuita (Personal Team) permite testar no próprio dispositivo, mas tem limites de provisionamento e duração do aplicativo. Não é necessária conta paga para esse primeiro teste local.

## Atualizações seguintes

```bash
cd turnopronto_ios
bash compilar_ios_mac.sh
```

O script executa `git pull --ff-only`, confere o ambiente, prepara o projeto Flutter e abre o Xcode. Se houver alterações rastreadas não salvas, ele interrompe antes do pull. Use `bash compilar_ios_mac.sh --sem-pull` para trabalhar com a cópia atual.

**Importante:** como o projeto iOS nativo é gerado localmente, opções do Xcode como Team e Bundle Identifier precisam ser revisadas após recriações completas do diretório `ios/`. Não apague essa pasta entre atualizações normais.

## Diagnóstico

```bash
flutter doctor -v
flutter devices
flutter analyze
flutter test
```

Se o Xcode não abrir o workspace, veja primeiro as mensagens do script; em um projeto sem `Podfile` ele pode abrir o `Runner.xcodeproj` diretamente.

Nunca adicione certificados, perfis, arquivos `.p12`, chaves de assinatura ou senhas no repositório.

## Estado da versão

- Código Flutter sincronizado com o Android em 15/10/2026; incluem-se vagas públicas antes do login, fluxo de autenticação sob demanda, geolocalização e logo SVG.\n- A permissão de localização é configurada no `Info.plist` pelo script do Mac.\n- As funcionalidades dependem de compatibilidade da API com o backend publicado.\n- Ainda é necessário validar execução real no Xcode e corrigir eventuais diferenças de renderização iOS.\n\nEsta preparação permite o fluxo de compilação e instalação local. A validação final do build no iPhone deve ser feita no Mac com o Xcode; não há IPA assinado gerado por este repositório.
