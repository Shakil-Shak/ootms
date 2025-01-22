import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ootms/helpers/base_client.dart';
import 'package:ootms/helpers/local_store.dart';
import 'package:ootms/presentation/api/sharePrefarences/login_tokan.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';
import 'package:ootms/presentation/screens/auth/otp_view.dart';
import 'package:ootms/presentation/screens/auth/signin/forget_password/forget_password_view.dart';
import 'package:ootms/presentation/screens/auth/signin/forget_password/reset_password_view.dart';
import 'package:ootms/presentation/screens/auth/signin/signin_view.dart';
import 'package:ootms/presentation/screens/auth/signup/compleate_profile.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());

  ///register Controller
  Future registerController({
    required String fullName,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      isLoading(true);
      var map = {
        "fullName": fullName,
        "email": email.toLowerCase().trim(),
        "password": password,
        "role": role,
      };

      var headers = {
        // 'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: ApiPaths.signupUrl, body: jsonEncode(map), headers: headers),
      );

      if (responseBody != null) {
        print("this is token ${responseBody['data']['signUpToken']}");

        String token = responseBody['data']['signUpToken'].toString();
        LocalStorage.saveData(key: ootmsSignUpToken, data: token);

        print(token);
        print(
            "))))))))))))))))))))))))))))) ${LocalStorage.getData(key: ootmsSignUpToken)}");

        //   String message = responseBody['message'].toString();
        // kSnackBar(message: message, bgColor: AppColors.green);

        Get.offAll(
          () => OtpPage(
            user: role,
            email: email,
            fromSignUp: true,
          ),
        );

        isLoading(false);
      } else {
        throw 'Sign Up in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

  ///signUp OTP verify
  Future otpVerifyController(
      {required String api,
      required bool isUser,
      required BuildContext context}) async {
    try {
      isLoading(true);
      String otp =
          otpControllers.map((controller) => controller.text.trim()).join();
      var map = {
        "otp": otp.toLowerCase().trim(),
      };

      var headers = {
        // 'Accept': 'application/json',
        'Content-Type': 'application/json',
        'SignUpToken':
            'signUpToken ${LocalStorage.getData(key: ootmsSignUpToken)}',
      };

      print("ddddddd" '${LocalStorage.getData(key: ootmsSignUpToken)}');

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: api, body: jsonEncode(map), headers: headers),
      );

      if (responseBody != null) {
        String token = responseBody['data']['accessToken'].toString();
        LocalStorage.saveData(key: ootmsUserAccessToken, data: token);

        String message = responseBody['message'].toString();
        //   kSnackBar(message: message, bgColor: AppColors.green);
        showCommonSnackbar(context, message);

        Get.offAll(
          () => CompleateProfilePage(user: isUser),
        );

        isLoading(false);
      } else {
        throw 'Sign Up in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

  ///forgotOtpVerify OTP verify
  Future forgotOtpVerify(
      {required bool isUser,
      required String email,
      required BuildContext context}) async {
    try {
      isLoading(true);
      String otp =
          otpControllers.map((controller) => controller.text.trim()).join();
      var map = {
        "email": email.toLowerCase().trim(),
        "otp": otp.toLowerCase().trim(),
      };

      var headers = {
        // 'Accept': 'application/json',
        'Content-Type': 'application/json',
 
      };



      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: ApiPaths.verifyOtpUrl,
            body: jsonEncode(map),
            headers: headers),
      );

      if (responseBody != null) {
        String token = responseBody['data']['forgetPasswordToken'].toString();
        LocalStorage.saveData(key: forgetPasswordToken, data: token);

        String message = responseBody['message'].toString();
        //   kSnackBar(message: message, bgColor: AppColors.green);
        showCommonSnackbar(context, message);

        Get.offAll(
          () => ResetPasswordPage(
            user: isUser,
            email: email,
            token: forgetPasswordToken,
          ),
        );

        isLoading(false);
      } else {
        throw 'Sign Up in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

  // resend Otp
  Future otpResendController(
    BuildContext context,
  ) async {
    try {
      isLoading(true);
      String otp =
          otpControllers.map((controller) => controller.text.trim()).join();
      var map = {
        "otp": otp.toLowerCase().trim(),
      };

      var headers = {
        // 'Accept': 'application/json',
        'Content-Type': 'application/json',
        'SignUpToken':
            'signUpToken ${LocalStorage.getData(key: ootmsSignUpToken)}',
      };

      print("ddddddd" '${LocalStorage.getData(key: ootmsSignUpToken)}');

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: ApiPaths.resendOtp, body: jsonEncode(map), headers: headers),
      );

      if (responseBody != null) {
        showCommonSnackbar(context, "Otp Resend Successfully", isError: false);

        isLoading(false);
      } else {
        throw 'Sign Up in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }

//Forget Password set

  Future forgetPasswordSetController(
      {required BuildContext context, required String email, required String password, required bool user}) async {
    try {
      isLoading(true);
     
      var map = {"email": email, "password": password};

      var headers = {
        // 'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Forget-password':
            'Forget-password ${LocalStorage.getData(key: forgetPasswordToken)}',
      };

      print("ddddddd" '${LocalStorage.getData(key: forgetPasswordToken)}');

      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.postRequest(
            api: ApiPaths.resetPasswordUrl, body: jsonEncode(map), headers: headers),
      );

      if (responseBody != null) {
        Get.offAll(() => SignInPage(
                                user: user,
                              ),);

        isLoading(false);
      } else {
        throw 'Sign Up in Failed!';
      }
    } catch (e) {
      debugPrint("Catch Error:::::: $e");
    } finally {
      isLoading(false);
    }
  }
}
