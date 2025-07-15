import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

/// Custom user model to abstract Firebase's [User] object.
class AuthUser {
  AuthUser(this.uid, this.email, this.isAnonymous);

  /// The unique user ID from Firebase.
  final String uid;

  /// The email of the user (can be null for anonymous).
  final String? email;

  /// Whether the user signed in anonymously.
  final bool isAnonymous;
}

/// Singleton class providing simple wrappers around Firebase Auth.
class SimpleFirebaseAuth {
  // Private constructor to enforce singleton pattern.
  SimpleFirebaseAuth._();

  /// The single shared instance of [SimpleFirebaseAuth].
  static final instance = SimpleFirebaseAuth._();

  bool _ready = false;

  /// Firebase app instance (not used much but ensures core is initialized).
  // ignore: unused_field
  final _core = Firebase.app;

  /// Initializes Firebase core. Must be called before using FirebaseAuth.
  /// Optionally accepts custom [FirebaseOptions] for web or custom config.
  Future<void> initialize({FirebaseOptions? options}) async {
    if (_ready) return;

    // Ensure Flutter widgets binding is initialized (required for Firebase).
    WidgetsFlutterBinding.ensureInitialized();

    // Initialize Firebase with optional config.
    await Firebase.initializeApp(options: options);

    _ready = true;
  }

  /// Returns a stream of [AuthUser], listening to auth state changes.
  Stream<AuthUser?> authState() =>
      FirebaseAuth.instance.authStateChanges().map(_mapUser);

  /// Returns the current signed-in user (or null if not signed in).
  Future<AuthUser?> currentUser() async =>
      _mapUser(FirebaseAuth.instance.currentUser);

  /// Signs in a user with email and password.
  Future<AuthUser> signIn(String email, String password) async {
    final cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _mapUser(cred.user)!;
  }

  /// Creates a new user with email and password.
  Future<AuthUser> signUp(String email, String password) async {
    final cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _mapUser(cred.user)!;
  }

  /// Signs out the currently logged-in user.
  Future<void> signOut() => FirebaseAuth.instance.signOut();

  /// Sends a password reset email to the given address.
  Future<void> sendPasswordReset(String email) =>
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);

  /// Converts a [User] object to a custom [AuthUser].
  /// Returns null if input is null.
  AuthUser? _mapUser(User? u) =>
      u == null ? null : AuthUser(u.uid, u.email, u.isAnonymous);
}
