import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthController {
  Future<Map<String, dynamic>?> signIn() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken;
        // Fetch user profile data or use the token for authenticated requests
        return FacebookAuth.instance.getUserData();
      } else {
        print('Facebook sign-in failed: ${result.message}');
        return null;
      }
    } catch (error) {
      print('Facebook sign-in error: $error');
      return null;
    }
  }

  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
    print('User Logged Out');
  }
}
