import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/api_services.dart';
import 'package:ootms/presentation/api/login_tokan.dart';
import 'package:ootms/presentation/api/models/signin_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPageController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isLoading = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get remembeMe => _rememberMe;
  bool get isLoading => _isLoading;

  void selectPasswordVisibility(bool isVisible) {
    _isPasswordVisible = isVisible;
    notifyListeners();
  }

  void callRememberMe(bool data) {
    _rememberMe = data;
    notifyListeners();
  }

  Future<SignInModel?> signIn(
      {required String email, required String password}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.postRequest(
        ApiPaths.signinUrl,
        {
          "email": email,
          "password": password,
        },
      );

      if (response != null && response['status'] == "OK") {
        final signInModel = SignInModel.fromJson(response);
        if (_rememberMe) {
          await _saveTokenToLocalStorage(signInModel.data.accessToken);
        }
        _isLoading = false;
        notifyListeners();
        return signInModel;
      } else {
        _isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Error during sign in: $e");
      return null;
    }
  }

  Future<void> _saveTokenToLocalStorage(String token) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    print("object");
    await preferences.setString(ootmsAccessToken, token);
  }
}
