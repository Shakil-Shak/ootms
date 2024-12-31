import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/api_services.dart';
import 'package:ootms/presentation/api/models/otp_model.dart';

class SignUpOtpController extends ChangeNotifier {
  List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());
  int _timer = 30;
  bool _isResendEnabled = false;
  bool _isLoading = false;

  int get timer => _timer;
  bool get isResendEnabled => _isResendEnabled;
  bool get isLoading => _isLoading;

  SignUpOtpController() {
    startTimer();
  }
  void startTimer() {
    _isResendEnabled = false;
    _timer = 30;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), updateTimer);
  }

  // Update timer countdown
  void updateTimer() {
    if (_timer > 0) {
      _timer--;
      notifyListeners();
      Future.delayed(const Duration(seconds: 1), updateTimer);
    } else {
      _isResendEnabled = true;
      notifyListeners();
    }
  }

  // Resend OTP logic
  Future<void> resendOtp(String email) async {
    if (!_isResendEnabled) return;
    // try {
    //   _isLoading = true;
    //   notifyListeners();
    //   // Call API to resend OTP
    //   final response = await ApiService().postRequest(ApiPaths.verifyOtpUrl, {
    //     "email": email, // Use the provided email for OTP resend
    //   });
    //   if (response != null && response['status'] == 'OK') {
    //     startTimer();
    //     notifyListeners();
    //   } else {
    //     throw Exception(response?['message'] ?? 'Failed to resend OTP.');
    //   }
    // } catch (e) {
    //   print("Resend OTP Error: $e");
    // } finally {
    //   _isLoading = false;
    //   notifyListeners();
    // }
  }

  // Verify OTP logic
  Future<UserRegistrationResponse?> verifyOtp(BuildContext context, String url,
      {Options? token, String? email}) async {
    try {
      _isLoading = true;
      notifyListeners();
      String otp = controllers.map((controller) => controller.text).join();

      print(otp);
      final response = await ApiService().postRequest(
          url,
          (email != null)
              ? {
                  "email": email,
                  "otp": otp,
                }
              : {
                  "otp": otp,
                },
          token: token);

      // Check if the response is valid
      if (response != null && response['status'] == 'OK') {
        // Parse the response into the UserRegistrationResponse model
        final userRegistrationResponse =
            UserRegistrationResponse.fromJson(response);

        print("OTP Verified Successfully: ${userRegistrationResponse.data}");

        return userRegistrationResponse;
      } else {
        throw Exception(response?['message'] ?? 'Failed to verify OTP.');
      }
    } catch (e) {
      print("Verify OTP Error: $e");
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
