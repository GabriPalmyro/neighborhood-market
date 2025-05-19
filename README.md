# Neighborhood Market

**Versão Flutter**: 3.27.1 (gerenciado via FVM)
**Repositório**: [https://github.com/GabriPalmyro/neighborhood-market.git](https://github.com/GabriPalmyro/neighborhood-market.git)

## Descrição

O Neighborhood Market é um aplicativo móvel Flutter para compra e venda de produtos em comunidades locais. Permite ao usuário:

* Criar anúncios de produtos com até 5 imagens (captura de câmera ou galeria).
* Compartilhar produtos via links dinâmicos (Firebase Dynamic Links).
* Receber push notifications personalizadas (OneSignal).
* Realizar pagamentos integrados com Stripe (Android e iOS) e Google Pay.
* Armazenar dados sensíveis com segurança (flutter\_secure\_storage).
* Carregar configurações remotas do servidor (Firebase Remote Config).
* Navegação declarativa com `go_router` e gerenciamento de estado com BLoC.

## Principais Funcionalidades

* **Cadastro de Produtos**: captura de fotos, validação de tamanho/formatos e limite de imagens.
* **Deep Linking**: abertura de produtos diretamente via links públicos e dinâmicos.
* **Push Notifications**: ícones customizados, cor de acento e notificações remotas com OneSignal.
* **Pagamentos**: Stripe Android (`stripe_android`), Stripe iOS e Google Pay.
* **Configuração Remota**: ajustes de funcionalidades sem redeploy via Firebase Remote Config.
* **Segurança**: permissões de câmera, galeria, notificações e armazenamento seguro.
* **Arquitetura**: Flutter + Dart, FVM, BLoC Pattern, Freezed para imutabilidade.

## Tecnologias e Dependências

* **Flutter 3.27.1** (FVM)
* **Dart**
* **State Management**: `bloc` / `flutter_bloc`
* **Routing**: `go_router`
* **Permissões**: `permission_handler`
* **Captura de Imagens**: `image_picker`
* **Armazenamento Seguro**: `flutter_secure_storage`
* **Firebase**: `firebase_core`, `firebase_dynamic_links`, `firebase_remote_config`
* **Notificações**: `onesignal_flutter`
* **Pagamentos**: Android (`stripe_android`), iOS (`stripe_ios`), Google Pay (`play-services-wallet`)
* **Utilitários**: `freezed_annotation`, `vector_math`, `material_color_utilities`, `share_plus`
* **Teste**: `bloc_test`, `leak_tracker_flutter_testing`

## Estrutura de Diretórios

```
neighborhood-market/
├── android/                 # Projeto Android
├── ios/                     # Projeto iOS
├── lib/
│   ├── main.dart            # App entrypoint
│   ├── core/                # Configurações e serviços (Firebase, Stripe, OneSignal)
│   ├── features/            # Funcionalidades em módulos (product builder, notifications, payments)
│   ├── shared/              # Widgets, estilos, utils
├── test/                    # Testes unitários e BLoC
├── fvm_config.json          # Versão Flutter definida pelo FVM
├── .env.template            # Variáveis de ambiente (não comitar chaves)
├── .gitignore
└── README.md
```

## Pré-requisitos

* `git`
* `fvm` (`dart pub global activate fvm`)
* Flutter SDK (via FVM)
* Xcode (macOS) / Android Studio + SDK

## Configuração do Projeto

1. **Clone o repositório**

   ```bash
   git clone https://github.com/GabriPalmyro/neighborhood-market.git
   cd neighborhood-market
   ```
2. **Instale a versão Flutter**

   ```bash
   fvm install
   fvm use
   ```
3. **Variáveis de Ambiente**

   * Copie `.env.template` para `.env` e preencha:

     ```
     STRIPE_PUBLISHABLE_KEY=...
     STRIPE_SECRET_KEY=...
     ONESIGNAL_APP_ID=...
     GOOGLE_SERVICES_JSON_PATH=...
     GOOGLE_SERVICE_INFO_PLIST_PATH=...
     ```
4. **Instale dependências Flutter**

   ```bash
   fvm flutter pub get
   ```
5. **Android**

   * Edite `android/app/src/main/AndroidManifest.xml` para permissões e configurações do OneSignal:

     ```xml
     <meta-data android:name="com.onesignal.NotificationIcon" android:resource="@drawable/ic_notification_custom"/>
     <meta-data android:name="com.onesignal.NotificationAccentColor" android:value="FFFFFF"/>
     ```
   * Execute:

     ```bash
     cd android
     pod install # se necessário para plugins iOS (OneSignal Extension)
     cd ..
     ```
6. **iOS**

   * Adicione as descrições de uso em `Info.plist`:

     ```xml
     <key>NSCameraUsageDescription</key>
     <string>...</string>
     <key>NSPhotoLibraryUsageDescription</key> ...
     <key>NSMicrophoneUsageDescription</key> ...
     <key>NSAppleMusicUsageDescription</key> ...
     <key>NSLocationWhenInUseUsageDescription</key> ...
     ```
   * Execute:

     ```bash
     cd ios
     pod install
     cd ..
     ```

## Execução

* **Android/iOS**

  ```bash
  fvm flutter run
  ```
* **Release Build**

  ```bash
  fvm flutter build apk --release
  fvm flutter build ios --release
  ```

## Testes

* **Teste unitário**

  ```bash
  fvm flutter test
  ```
* **Teste de BLoC**

  ```bash
  fvm flutter test test/bloc
  ```

## Contribuição

1. Crie uma *issue* para reportar bugs ou sugerir melhorias.
2. Crie uma *branch* com a feature ou correção (`git checkout -b feature/nova-coisa`).
3. Faça commit das suas alterações e envie um *pull request*.

## Licença

MIT © Gabriel Palmyro
