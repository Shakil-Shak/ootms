import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ootms/helpers/prefs_helper.dart';
import 'package:ootms/presentation/api/models/otp_model.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';
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
  bool isResend = false;
  Future<void> resendOtp(context) async {
    if (!_isResendEnabled) return;
    try {
      isResend = true;
      notifyListeners();
      try {
        final response =
            await ApiService().otherPostRequest(ApiPaths.resendOtp, {});
        if (response != null && response['status'] == 'OK') {
          showCommonSnackbar(context, "Otp Resend Successfully", isError: true);
          startTimer();
          notifyListeners();
        } else {
          showCommonSnackbar(context, "Failed to resend OTP", isError: true);
        }
      } catch (e) {}
    } catch (e) {
      print("Resend OTP Error: $e");
    } finally {
      isResend = false;
      notifyListeners();
    }
  }

  // Verify OTP logic
  Future<dynamic> verifyOtp(BuildContext context, String url,
      {Options? token, String? email}) async {
    try {
      _isLoading = true;
      notifyListeners();

      String otp =
          controllers.map((controller) => controller.text.trim()).join();
      if (otp.length < 4) {
        showCommonSnackbar(context, "OTP must be 4 digits.", isError: true);
        return null;
      }

      print("OTP: $otp");
      if (email != null) {
        print("Email: $email");
      }

      final Map<String, String> requestBody = {
        "otp": otp,
        // "email": email.toString(),
      };
      // if (email != null && email.trim().isNotEmpty) {
      //   requestBody["email"] = email.trim();
      // }
      print("requestBody: $requestBody");
      print("token: $token");
      final response =
          await ApiService().otherPostRequest(url, requestBody, token: token);

      if (response != null && response['status'] == "OK") {
        final signInModel = OtpModels.fromJson(response);
        // PrefsHelper.setString("userRole", signInModel.data.attributes.id);

        saveUserAcessDetails(signInModel.data.forgetPasswordToken, "");

        _isLoading = false;
        notifyListeners();
        return signInModel;
      }
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
