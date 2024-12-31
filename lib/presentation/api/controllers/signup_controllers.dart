import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/api_services.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/api/models/signup_model.dart';

class SignupPageController extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  bool get isLoading => _isLoading;

  final ApiService _apiService = ApiService();

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  Future<SignUpResponseModel?> signup({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String user,
  }) async {
    if (password != confirmPassword) {
      throw Exception("Passwords do not match.");
    }

    try {
      _isLoading = true;
      notifyListeners();

      final response = await _apiService.postRequest(
        ApiPaths.signupUrl, // Replace with your actual signup endpoint
        {
          "fullName": fullName,
          "email": email,
          "password": password,
          "role": user
        },
      );

      if (response != null && response['status'] == "OK") {
        final signupResponse = SignUpResponseModel.fromJson(response);
        _isLoading = false;
        notifyListeners();
        print(signupResponse.data.signUpToken);
        return signupResponse;
      } else {
        _isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print("Signup Error: $e");
      return null;
    }
  }
}
