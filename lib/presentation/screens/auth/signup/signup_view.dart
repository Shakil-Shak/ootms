// ignore_for_file: must_be_immutable

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
  SignupPage({super.key, required this.user});
  bool user;
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
                            if (widget.user) {
                              animetedNavigationPush(
                                const OtpPage(user: true, fromSignUp: true),
                                context,
                              );
                            } else {
                              animetedNavigationPush(
                                const OtpPage(user: false, fromSignUp: true),
                                context,
                              );
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      Row(children: [
                        Expanded(
                            child: Container(
                          height: 1,
                          color: AppColor.black,
                        )),
                        commonText("  Or  ", size: 16),
                        Expanded(
                            child: Container(
                          height: 1,
                          color: AppColor.black,
                        )),
                      ]),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: AppColor.black)),
                        child: commonIconButton("Sign Up With Google",
                            Image.asset("assets/icons/devicon_google.png"),
                            color: Colors.transparent,
                            isBold: false,
                            textColor: AppColor.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: 1, color: AppColor.black)),
                        child: commonIconButton(
                            "Sign Up With Google",
                            isBold: false,
                            Image.asset("assets/icons/logos_facebook.png"),
                            color: Colors.transparent,
                            textColor: AppColor.black),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          commonText("Already have an account?",
                              color: Colors.black),
                          GestureDetector(
                            onTap: () {
                              animetedNavigationPush(
                                  SignInPage(
                                    user: widget.user,
                                  ),
                                  context);
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

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }
}
