# Neighborhood Market

**Flutter Version**: 3.27.1 (managed via FVM)
**Repository**: [https://github.com/GabriPalmyro/neighborhood-market.git](https://github.com/GabriPalmyro/neighborhood-market.git)

## Overview

Neighborhood Market is a Flutter mobile application for buying and selling items within local communities. Key features include:

* **Product Listings**: Create product posts with up to five images (camera capture or gallery selection).
* **Deep Linking**: Share and open product pages via Firebase Dynamic Links.
* **Push Notifications**: Customized icons and accent colors using OneSignal.
* **Payments**: Integrated Stripe payments (Android and iOS) and Google Pay support.
* **Secure Storage**: Store sensitive data securely with `flutter_secure_storage`.
* **Remote Configuration**: Adjust app behavior remotely via Firebase Remote Config.
* **Navigation & State**: Declarative routing with `go_router` and state management using the BLoC pattern.

## Key Features

* **Add Products**: Capture photos, validate file size and formats, limit number of images.
* **Dynamic Links**: Seamlessly open specific product pages from shared links.
* **Notifications**: Send targeted notifications with custom icons and colors.
* **Checkout**: Secure in-app purchases with Stripe SDKs and Google Pay.
* **Remote Control**: Toggle features and configurations without releasing new builds.
* **Data Security**: Enforce runtime permissions and secure local storage.
* **Architecture**: Clean, modular code with Flutter + Dart, FVM, BLoC, and Freezed for immutability.

## Technologies & Dependencies

* **Flutter 3.27.1** (via FVM)
* **Dart**
* **State Management**: `bloc`, `flutter_bloc`
* **Routing**: `go_router`
* **Permissions**: `permission_handler`
* **Image Picker**: `image_picker`
* **Secure Storage**: `flutter_secure_storage`
* **Firebase**: `firebase_core`, `firebase_dynamic_links`, `firebase_remote_config`
* **Notifications**: `onesignal_flutter`
* **Payments**: `stripe_android`, `stripe_ios`, `play-services-wallet` (Google Pay)
* **Utilities**: `freezed_annotation`, `vector_math`, `material_color_utilities`, `share_plus`
* **Testing**: `bloc_test`, `leak_tracker_flutter_testing`

## Project Structure

```plaintext
neighborhood-market/
├── android/                 # Android project files
├── ios/                     # iOS project files
├── lib/
│   ├── main.dart            # Application entry point
│   ├── core/                # Services and configurations (Firebase, Stripe, OneSignal)
│   ├── features/            # Feature modules (product creation, notifications, payments)
│   ├── shared/              # Shared widgets, styles, utilities
├── test/                    # Unit and BLoC tests
├── fvm_config.json          # FVM configuration file
├── .env.template            # Environment variable template (excluded from VCS)
├── .gitignore               # Git ignore rules
└── README.md                # Project overview and setup instructions
```

## Prerequisites

* Git
* FVM (`dart pub global activate fvm`)
* Flutter SDK (installed via FVM)
* Xcode (macOS) or Android Studio + Android SDK

## Setup Instructions

1. **Clone repository**

   ```bash
   git clone https://github.com/GabriPalmyro/neighborhood-market.git
   cd neighborhood-market
   ```

2. **Install Flutter version**

   ```bash
   fvm install
   fvm use
   ```

3. **Configure environment variables**

   * Copy `.env.template` to `.env` and fill in your keys:

     ```environment
     STRIPE_PUBLISHABLE_KEY=your_key_here
     STRIPE_SECRET_KEY=your_secret_key_here
     ONESIGNAL_APP_ID=your_onesignal_app_id
     GOOGLE_SERVICES_JSON_PATH=path/to/google-services.json
     GOOGLE_SERVICE_INFO_PLIST_PATH=path/to/GoogleService-Info.plist
     ```

4. **Install Flutter dependencies**

   ```bash
   fvm flutter pub get
   ```

5. **Android Configuration**

   * Update `android/app/src/main/AndroidManifest.xml`:

     ```xml
     <meta-data
       android:name="com.onesignal.NotificationIcon"
       android:resource="@drawable/ic_notification_custom"/>
     <meta-data
       android:name="com.onesignal.NotificationAccentColor"
       android:value="FFFFFF"/>
     ```
   * (If using iOS extension) run:

     ```bash
     cd ios
     pod install
     cd ..
     ```

6. **iOS Configuration**

   * Add permission descriptions to `Info.plist`:

     ```xml
     <key>NSCameraUsageDescription</key>
     <string>Permission to use camera for product photos</string>
     <key>NSPhotoLibraryUsageDescription</key>
     <string>Permission to access photo library</string>
     <key>NSMicrophoneUsageDescription</key>
     <string>Permission to record audio for product videos</string>
     <key>NSAppleMusicUsageDescription</key>
     <string>Not used directly; required by an external SDK</string>
     <key>NSLocationWhenInUseUsageDescription</key>
     <string>Not used directly; required by an external SDK</string>
     ```
   * Install CocoaPods:

     ```bash
     cd ios
     pod install
     cd ..
     ```

## Running the App

* **Debug**

  ```bash
  fvm flutter run
  ```

* **Release Build**

  ```bash
  fvm flutter build apk --release
  fvm flutter build ios --release
  ```

## Testing

* **Unit Tests**

  ```bash
  fvm flutter test
  ```

* **BLoC Tests**

  ```bash
  fvm flutter test test/bloc
  ```

## Contributing

1. Open an issue to report bugs or request features.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Make your changes and commit (`git commit -m 'Add new feature'`).
4. Push to your branch and open a pull request.

## License

This project is licensed under the MIT License © Gabriel Palmyro
