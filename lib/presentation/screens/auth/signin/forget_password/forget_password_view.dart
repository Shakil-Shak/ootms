// ignore_for_file: must_be_immutable

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/local_store.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/api/sharePrefarences/login_tokan.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/components/common_validities.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/auth/otp_view.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key, this.user = true});
  bool user;
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              commonText("Forget Your",
                  size: 21, isBold: true, color: AppColor.black),
              commonText("Password?.",
                  size: 21, isBold: true, color: AppColor.primaryColor),
              const SizedBox(
                height: 5,
              ),
              commonText("Enter your email address to reset your password.",
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 30,
              ),
              commonTextfieldWithTitle("Email", emailController,
                  hintText: "Email",
                  assetIconPath: "assets/icons/emailicon.png",
                  keyboardType: TextInputType.emailAddress),
              const Spacer(),
              commonButton("Get Verification Code", onTap: () async {
                // Validate email
                final emailError =
                    ValidationUtils.validateEmail(emailController.text);
                if (emailError != null) {
                  showCommonSnackbar(context, emailError, isError: true);
                  return;
                }

                try {
                  showCommonSnackbar(context, "Sending verification code...",
                      isError: false);
                  print(emailController.text);
                  final response = await ApiService().postRequest(
                      ApiPaths.forgetPasswordUrl,
                      {
                        "email": emailController.text,
                      },
                      token: Options(headers: {"Accept-Language": "gr"}));
                  print("response");
                  if (response != null && response['status'] == 'OK') {
                    showCommonSnackbar(context, response['message'],
                        isError: false);

              

                    animetedNavigationPush(
                      OtpPage(
                        email: emailController.text,
                        user: user == true? "user": "driver",
                        fromSignUp: false,
                      ),
                      context,
                    );
                  } else {
                    throw Exception(response?['message'] ??
                        'Failed to send verification code.');
                  }
                } catch (e) {
                  showCommonSnackbar(context, e.toString(), isError: true);
                }
              }),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
