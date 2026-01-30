# Gym App (MVP)

Flutter + Firebase app for gym management (multi-gym).

## Features (current)
- Firebase Auth (email/password)
- AuthGate: session-based navigation
- Multi-gym: create/select gym
- Active gym persisted locally (SharedPreferences)

## Setup
1. Create a Firebase project
2. Enable Authentication (Email/Password)
3. Create Firestore database
4. Run FlutterFire configure:
   - `flutterfire configure`
5. Run:
   - `flutter pub get`
   - `flutter run`

## Notes
Firebase config files are not committed:
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `lib/firebase_options.dart`