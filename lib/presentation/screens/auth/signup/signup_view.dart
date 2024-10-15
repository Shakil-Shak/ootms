import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/auth/signin/signin_view.dart';
import 'package:ootms/presentation/screens/auth/otp_view.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool agreewithpolicy = false;

  @override
  Widget build(BuildContext context) {
    log("Clicked");
    return ChangeNotifierProvider(
      create: (_) => SignupPageController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: commonText("Welcome Here!",
                        size: 21, isBold: true, color: AppColor.black),
                  ),
                  Center(
                    child: commonText("Create An Account.",
                        size: 21, isBold: true, color: AppColor.primaryColor),
                  ),
                  Center(
                    child: commonText(
                      "Fill in your information.",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      commonTextfieldWithTitle("Full Name", fullNameController,
                          hintText: "Full Name",
                          keyboardType: TextInputType.text),
                      const SizedBox(height: 20),
                      commonTextfieldWithTitle("Email", emailController,
                          assetIconPath: "assets/icons/emailicon.png",
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 20),
                      Consumer<SignupPageController>(
                        builder: (context, controller, _) {
                          return commonTextfieldWithTitle(
                            "Password",
                            passwordController,
                            hintText: "Password",
                            assetIconPath: "assets/icons/lockicon.png",
                            issuffixIconVisible: true,
                            isPasswordVisible: controller.isPasswordVisible,
                            changePasswordVisibility:
                                controller.togglePasswordVisibility,
                            keyboardType: TextInputType.visiblePassword,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Consumer<SignupPageController>(
                        builder: (context, controller, _) {
                          return commonTextfieldWithTitle(
                            "Confirm Password",
                            confirmPasswordController,
                            hintText: "Confirm Password",
                            issuffixIconVisible: true,
                            assetIconPath: "assets/icons/lockicon.png",
                            isPasswordVisible:
                                controller.isConfirmPasswordVisible,
                            changePasswordVisibility:
                                controller.toggleConfirmPasswordVisibility,
                            keyboardType: TextInputType.visiblePassword,
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: agreewithpolicy,
                        onChanged: (value) => setState(() {
                          agreewithpolicy = value!;
                        }),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Agree with "),
                            commonText("Terms and Conditions.",
                                color: Colors.green),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Consumer<SignupPageController>(
                        builder: (context, controller, _) {
                          return commonButton("Sign Up", onTap: () {
                            if (controller.selectedRole == "User") {
                              animetedNavigationPush(
                                OtpPage(user: true),
                                context,
                              );
                            } else if (controller.selectedRole == "Driver") {
                              animetedNavigationPush(
                                OtpPage(user: false),
                                context,
                              );
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          commonText("Already have an account?",
                              color: Colors.black),
                          GestureDetector(
                            onTap: () {
                              animetedNavigationPush(SignInPage(), context);
                            },
                            child: commonText(" Sign In",
                                decoration: TextDecoration.underline,
                                size: 13,
                                isBold: true,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupPageController extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String _selectedRole = 'User';

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  String get selectedRole => _selectedRole;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  void selectRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}
