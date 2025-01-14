// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/common/signup_otp_controller.dart';
import 'package:ootms/presentation/api/models/otp_model.dart';
import 'package:ootms/presentation/api/models/user_registration.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_otp_field.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/auth/signin/forget_password/reset_password_view.dart';
import 'package:ootms/presentation/screens/auth/signup/compleate_profile.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatelessWidget {
  final bool user, fromSignUp;
  final String? token, email;
  const OtpPage({
    super.key,
    this.token,
    this.email,
    required this.user,
    this.fromSignUp = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignUpOtpController(),
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: commonText(
                    "Enter Verification\nCode.",
                    textAlign: TextAlign.center,
                    size: 21,
                    isBold: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: commonText(
                        "Enter the code that was sent to your email.",
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    Consumer<SignUpOtpController>(
                      builder: (context, controller, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(4, (index) {
                            return buildOTPTextField(
                                controller.controllers[index], index, context);
                          }),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        commonText(
                          "Did not get the OTP?",
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Consumer<SignUpOtpController>(
                          builder: (context, controller, child) {
                            return InkWell(
                              onTap: () {
                                controller.resendOtp(context);
                              },
                              child: controller.isResend == true
                                  ? const SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColor.primaryColor,
                                        ),
                                      ))
                                  : commonText("Resend",
                                      size: 14,
                                      isBold: true,
                                      decoration: TextDecoration.underline),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Consumer<SignUpOtpController>(
                    builder: (context, controller, _) {
                  return commonButton(
                    controller.isLoading ? "Verifying..." : "Verify",
                    onTap: controller.isLoading
                        ? null // Disable button when loading
                        : () async {
                            if (token != null) {
                              final responsedata = await controller.verifyOtp(
                                  context, ApiPaths.verifyEmailUrl,
                                  token: Options(headers: {
                                    "SignUpToken": "signUpToken $token",
                                  }));

                              if (responsedata == null) {
                                return;
                              }

                              final response =
                                  UserRegistrationModel.fromJson(responsedata);
                              if (response != null) {
                                if (response.status == 'OK') {
                                  if (fromSignUp) {
                                    animetedNavigationPush(
                                      CompleateProfilePage(user: user),
                                      context,
                                    );
                                  }
                                } else {
                                  showCommonSnackbar(
                                      context,
                                      response.message ??
                                          'Failed to verify OTP.');
                                }
                              } else {
                                showCommonSnackbar(
                                  context,
                                  "Invalid OTP. Please try again.",
                                  isError: true,
                                );
                              }
                            } else {
                              final responsedata = await controller.verifyOtp(
                                  context, ApiPaths.verifyOtpUrl,
                                  email: email);
                              if (responsedata == null) {
                                return;
                              }
                              final response = OtpModels.fromJson(responsedata);
                              if (response != null) {
                                animetedNavigationPush(
                                    ResetPasswordPage(
                                      user: user,
                                      email: email!,
                                      token: response.data.forgetPasswordToken,
                                    ),
                                    context);
                              } else {
                                showCommonSnackbar(
                                  context,
                                  "Invalid OTP. Please try again.",
                                  isError: true,
                                );
                              }
                            }
                          },
                  );
                }),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
