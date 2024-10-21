// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/auth/signin/signin_view.dart';
import 'package:provider/provider.dart';

class ResetPasswordPage extends StatelessWidget {
  bool user;
  ResetPasswordPage({super.key, required this.user});

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    commonText("Now Reset Your",
                        size: 21, color: AppColor.black, isBold: true),
                    commonText("Password.",
                        size: 21, color: AppColor.primaryColor, isBold: true),
                    const SizedBox(
                      height: 8,
                    ),
                    commonText(
                      "Password  must have 6-8 characters.",
                    ),
                    const SizedBox(height: 50),
                    Consumer<ResetPasswordController>(
                      builder: (context, controller, _) {
                        return commonTextfieldWithTitle(
                          "Password",
                          passwordController,
                          hintText: "Password",
                          issuffixIconVisible: true,
                          isPasswordVisible: controller.isPasswordVisible,
                          changePasswordVisibility: () {
                            controller.selectPasswordVisibility(
                                !controller.isPasswordVisible);
                          },
                          keyboardType: TextInputType.visiblePassword,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Consumer<ResetPasswordController>(
                      builder: (context, controller, _) {
                        return commonTextfieldWithTitle(
                          "Confirm Password",
                          confirmPasswordController,
                          hintText: "Password",
                          issuffixIconVisible: true,
                          isPasswordVisible:
                              controller.isConfirmPasswordVisible,
                          changePasswordVisibility: () {
                            controller.selectConfirmPasswordVisibility(
                                !controller.isConfirmPasswordVisible);
                          },
                          keyboardType: TextInputType.visiblePassword,
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        animetedNavigationPush(
                            SignInPage(
                              user: user,
                            ),
                            context);
                      },
                      child: commonButton("Reset Password"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordController extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  void selectPasswordVisibility(bool isVisible) {
    _isPasswordVisible = isVisible;
    notifyListeners();
  }

  void selectConfirmPasswordVisibility(bool isVisible) {
    _isConfirmPasswordVisible = isVisible;
    notifyListeners();
  }
}
