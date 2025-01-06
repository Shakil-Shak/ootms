import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/models/signin_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';

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
      {required String email,
      required String password,
      required String role}) async {
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

        saveUserAcessDetails(signInModel.data.accessToken, role);

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
}
