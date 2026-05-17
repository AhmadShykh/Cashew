import 'package:budget/struct/settings.dart';
import 'package:budget/widgets/accountAndBackup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;

OAuthCredential? _credential;

Future<void> clearFirebaseAuthSession() async {
  _credential = null;
  try {
    await FirebaseAuth.instance.signOut();
  } catch (e) {
    debugPrint('Firebase signOut failed: $e');
  }
}

Future<bool> linkGoogleAccountToFirebase() async {
  try {
    if (googleUser == null) {
      debugPrint('linkGoogleAccountToFirebase: no Google user');
      return false;
    }

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    if (googleAuth?.idToken == null) {
      debugPrint(
        'linkGoogleAccountToFirebase: missing idToken — use serverClientId on Android',
      );
      return false;
    }

    _credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(_credential!);
    final String? email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      await updateSettings(
        'currentUserEmail',
        email,
        updateGlobalState: true,
      );
    }
    debugPrint(
      'Firebase Auth linked: ${FirebaseAuth.instance.currentUser?.uid}',
    );
    return true;
  } catch (e, stack) {
    debugPrint('linkGoogleAccountToFirebase failed: $e\n$stack');
    _credential = null;
    return false;
  }
}

Future<FirebaseFirestore?> firebaseGetDBInstanceAnonymous() async {
  try {
    await FirebaseAuth.instance.signInAnonymously();
    return FirebaseFirestore.instance;
  } catch (e) {
    print("There was an error with firebase login");
    print(e.toString());
    return null;
  }
}

// returns null if authentication unsuccessful
Future<FirebaseFirestore?> firebaseGetDBInstance() async {
  if (FirebaseAuth.instance.currentUser != null) {
    return FirebaseFirestore.instance;
  }

  if (_credential != null) {
    try {
      await FirebaseAuth.instance.signInWithCredential(_credential!);
      updateSettings(
        'currentUserEmail',
        FirebaseAuth.instance.currentUser?.email,
        pagesNeedingRefresh: [],
        updateGlobalState: false,
      );
      return FirebaseFirestore.instance;
    } catch (e) {
      debugPrint('firebaseGetDBInstance credential retry: $e');
      _credential = null;
    }
  }

  if (googleUser == null) {
    await signInGoogle(silentSignIn: true);
  }

  if (await linkGoogleAccountToFirebase()) {
    return FirebaseFirestore.instance;
  }

  return null;
}
