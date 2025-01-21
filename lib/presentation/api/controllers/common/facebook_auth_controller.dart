import 'dart:developer';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthController {
  bool _isLoginInProgress = false;

  Future<Map<String, dynamic>?> signIn() async {
    if (_isLoginInProgress) {
      log("Login already in progress.");
      return null;
    }

    _isLoginInProgress = true; // Lock the login process
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance
            .getUserData(fields: "name,email,picture.width(200)");
        log('User Data: $userData');
        return userData;
      } else {
        log('Facebook sign-in failed: ${result.message}');
        return null;
      }
    } catch (error) {
      log('Facebook sign-in error: $error');
      FacebookAuth.instance.logOut();
      return null;
    } finally {
      _isLoginInProgress = false; // Unlock the login process
    }
  }

  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    log('User Logged Out');
  }
}
