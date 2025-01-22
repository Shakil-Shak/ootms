// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/common/auth_controller.dart';
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
  final bool fromSignUp;
  final String? user, email;
  OtpPage({
    super.key,
    this.email,
    required this.user,
    this.fromSignUp = false,
  });

  final RegisterController registerController = Get.put(RegisterController());

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return buildOTPTextField(
                            registerController.otpControllers[index],
                            index,
                            context);
                      }),
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
                                registerController.otpResendController(context);
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
                Obx(
                  () => commonButton(
                    registerController.isLoading.value == true
                        ? "Verifying..."
                        : "Verify",
                    onTap: registerController.isLoading.value
                        ? null // Disable button when loading
                        : () async {
                          if(fromSignUp){
registerController.otpVerifyController(
                                  isUser: user == "user" ? true : false,
                                  api: ApiPaths.verifyEmailUrl,
                                  context: context);
                          }else{
                            registerController.forgotOtpVerify(
                                  isUser: user == "user" ? true : false,
                                 email: email.toString(),
                                  context: context);
                          }
                            
                          },
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
