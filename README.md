
# 📦 simple_firebase_auth

A lightweight and opinionated wrapper around [`firebase_auth`](https://pub.dev/packages/firebase_auth) and [`firebase_core`](https://pub.dev/packages/firebase_core) to simplify Firebase authentication logic in Flutter.

✅ Firebase initialization  
✅ Sign in / Sign up with Email & Password  
✅ Password reset  
✅ Sign out  
✅ Auth state changes stream  
✅ Minimal setup, beginner-friendly API

---

## ✨ Features

- 🚀 One-liner Firebase init
- 🧠 Clean custom user model (`AuthUser`)
- 📡 Stream-based auth state monitoring
- 🔐 Simple sign in / sign up / reset / logout methods
- 🔁 Zero `FirebaseAuth.instance` boilerplate in your app code

---

## 🚀 Getting Started

### 1. Add dependencies

```yaml
dependencies:
  simple_firebase_auth: ^0.0.1
```

> This package internally uses:
> - `firebase_auth`
> - `firebase_core`

---

### 2. Initialize Firebase (main.dart)

```dart
void main() async {
  await SimpleFirebaseAuth.instance.initialize(); // Required
  runApp(const MyApp());
}
```

---

## 🧑‍💻 Usage Example

### 🔐 Sign In / Sign Up / Reset

```dart
final auth = SimpleFirebaseAuth.instance;

final user = await auth.signIn('test@email.com', 'password123');
// or:
final user = await auth.signUp('new@email.com', 'secretPassword');

await auth.sendPasswordReset('forgot@email.com');
await auth.signOut();
```

### 👤 Get Current User

```dart
final user = await SimpleFirebaseAuth.instance.currentUser();
if (user != null) print(user.uid);
```

### 📡 Listen to Auth State

```dart
StreamBuilder<AuthUser?>(
  stream: SimpleFirebaseAuth.instance.authState(),
  builder: (context, snapshot) {
    final user = snapshot.data;
    if (user == null) return const SignInPage();
    return HomePage(user: user);
  },
);
```

---

## 📄 AuthUser Model

This package exposes a simplified user model:

```dart
class AuthUser {
  final String uid;
  final String? email;
  final bool isAnonymous;
}
```

---

## 🧪 Example

Run the example app:

```bash
cd example
flutter run
```

You’ll find:
- TextFields for email & password
- Buttons for sign in, sign up, reset password
- Auth state and user UID displayed

---

## 🔒 Firebase Setup

This package assumes you’ve already:
1. Added `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS)
2. Enabled **Email/Password** sign-in method in Firebase Console
3. Installed `firebase_auth` and `firebase_core`

> Web/desktop users should pass `FirebaseOptions` to `initialize()`.

---

## 📦 Coming Soon

- Google / Apple / Phone Sign-In
- Firebase Emulator support
- Provider/Riverpod/BLoC adapters

---

## 🙌 License

MIT © Chauhan Pruthviraj


---

## 🛠 How to Run the Example App

### 📁 Project Structure

```
simple_firebase_auth/
├── lib/
│   ├── simple_firebase_auth.dart
│   └── src/
│       └── simple_firebase_auth_impl.dart
├── example/
│   └── lib/
│       └── main.dart
├── pubspec.yaml
├── README.md
└── test/
```

---

### 🔥 Firebase Setup

#### ✅ Android

1. Go to [Firebase Console](https://console.firebase.google.com/) and create a project
2. Add an Android app
3. Download `google-services.json` and place it in:
   ```
   example/android/app/google-services.json
   ```
4. In `example/android/build.gradle` (project-level):
   ```gradle
   classpath 'com.google.gms:google-services:4.3.15'
   ```
5. In `example/android/app/build.gradle`:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   ```

#### ✅ iOS

1. Add an iOS app in Firebase Console
2. Download `GoogleService-Info.plist`
3. Place it in:
   ```
   example/ios/Runner/GoogleService-Info.plist
   ```
4. Ensure minimum iOS version is set in `example/ios/Podfile`:
   ```ruby
   platform :ios, '11.0'
   ```

---

### 🧩 Add Dependencies in `example/pubspec.yaml`

```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^3.15.0
  firebase_auth: ^5.6.1

  simple_firebase_auth:
    path: ../
```

Then run:

```bash
flutter pub get
```

---

### ▶️ Run the App

```bash
cd example
flutter run
```

---

### 🔓 Enable Email/Password Authentication

1. Go to Firebase Console
2. Navigate to **Authentication > Sign-in method**
3. Enable **Email/Password**

---

Now you're ready to test sign-in, sign-up, reset password, and sign-out flows in the running app!
