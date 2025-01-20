import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final String? name = account.displayName;
        final String? email = account.email;
        final String? photoUrl = account.photoUrl;

        log('User signed in:');
        log('Name: $name');
        log('Email: $email');
        log('Photo URL: $photoUrl');

        return account;
      } else {
        log('User canceled the sign-in');
        return null;
      }
    } catch (error) {
      log('Google sign-in error: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    log('User Signed Out');
  }
}
