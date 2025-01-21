import 'package:flutter/material.dart';
import 'package:ootms/helpers/prefs_helper.dart';
import 'package:ootms/presentation/api/models/signin_model.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class SocialAuthController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  Future<SignInModel?> socialSignIn(
      {required String email,
      required String fullName,
      required String role}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.postRequest(
        ApiPaths.socialSigninUrl,
        {"email": email, "fullName": fullName, "role": role},
      );

      if (response != null && response['status'] == "OK") {
        final signInModel = SignInModel.fromJson(response);
        // PrefsHelper.setString("userRole", signInModel.data.attributes.id);

        PrefsHelper.setString("userId", signInModel.data.attributes.id);

        saveUserAcessDetails(signInModel.data.accessToken, role);

        _isLoading = false;
        notifyListeners();
        return signInModel;
      } else {
        _isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e, s) {
      _isLoading = false;
      notifyListeners();
      print("Error during sign in: $e");
      print("Error during sign in: $s");
      return null;
    }
  }
}
