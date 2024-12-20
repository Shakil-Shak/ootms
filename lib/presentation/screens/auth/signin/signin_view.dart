import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/auth/signin/forget_password/forget_password_view.dart';
import 'package:ootms/presentation/screens/auth/signup/signup_view.dart';
import 'package:ootms/presentation/screens/role/driver/driver_bottom_navigation.dart';
import 'package:ootms/presentation/screens/role/user/user_bottom_navigation.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final bool user;
  SignInPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInPageController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      commonText("Welcome back!",
                          size: 21, isBold: true, color: AppColor.black),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          commonText("Let’s ",
                              size: 21, isBold: true, color: AppColor.black),
                          commonText("Sign In.",
                              size: 21,
                              isBold: true,
                              color: AppColor.primaryColor),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      commonTextfieldWithTitle("Email", emailController,
                          hintText: "Email",
                          assetIconPath: "assets/icons/emailicon.png",
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(height: 20),
                      Consumer<SignInPageController>(
                        builder: (context, controller, _) {
                          return commonTextfieldWithTitle(
                            "Password",
                            passwordController,
                            assetIconPath: "assets/icons/lockicon.png",
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
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              children: [
                                Consumer<SignInPageController>(
                                    builder: (context, controller, _) {
                                  return Checkbox(
                                    value: controller.remembeMe,
                                    onChanged: (value) {
                                      controller.callRememberMe(value!);
                                    },
                                  );
                                }),
                                commonText("Remember me", size: 14)
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              animetedNavigationPush(
                                  ForgetPasswordPage(), context);
                            },
                            child: commonText("Forgot Password",
                                size: 16, isBold: true, color: AppColor.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Consumer<SignInPageController>(
                    builder: (context, controller, _) {
                      return commonButton("Sign In", onTap: () {
                        if (user) {
                          animetedNavigationPush(const UserRootPage(), context);
                        } else {
                          animetedNavigationPush(
                              const DriverRootPage(), context);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: AppColor.black)),
                    child: commonIconButton(
                        "Sign In With Google",
                        isBold: false,
                        Image.asset("assets/icons/devicon_google.png"),
                        color: Colors.transparent,
                        textColor: AppColor.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: AppColor.black)),
                    child: commonIconButton(
                      "Sign In With Facebook",
                      Image.asset("assets/icons/logos_facebook.png"),
                      isBold: false,
                      color: Colors.transparent,
                      textColor: AppColor.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      commonText("Don't have any account?"),
                      GestureDetector(
                        onTap: () {
                          animetedNavigationPush(
                              SignupPage(
                                user: user,
                              ),
                              context);
                        },
                        child: commonText("  Sign Up",
                            isBold: true,
                            color: AppColor.primaryColor,
                            size: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignInPageController extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get remembeMe => _rememberMe;

  void selectPasswordVisibility(bool isVisible) {
    _isPasswordVisible = isVisible;
    notifyListeners();
  }

  void callRememberMe(bool data) {
    _rememberMe = data;
    notifyListeners();
  }
}
