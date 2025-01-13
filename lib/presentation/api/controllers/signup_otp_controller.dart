import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';

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
  Future<dynamic> verifyOtp(BuildContext context, String url,
      {Options? token, String? email}) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Collect and validate OTP
      String otp =
          controllers.map((controller) => controller.text.trim()).join();
      if (otp.length < 4) {
        showCommonSnackbar(context, "OTP must be 4 digits.", isError: true);
        return null;
      }

      // Debugging logs
      print("OTP: $otp");
      if (email != null) {
        print("Email: $email");
      }

      // Construct the request body
      final Map<String, String> requestBody = {"otp": otp};
      // if (email != null && email.trim().isNotEmpty) {
      //   requestBody["email"] = email.trim();
      // }
      print("requestBody: $requestBody");
       print("token: $token");
      final response = await ApiService().postRequest(url, requestBody, token: token);
      print("======================================otpResponse${response}");
      print(
          "======================================otpResponse${response["statusCode"]}");

      return response;
    } catch (e) {
      showCommonSnackbar(context, "Failed to verify OTP", isError: true);
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
