import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/common/signup_controllers.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_loading.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/components/common_validities.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/auth/signin/signin_view.dart';
import 'package:ootms/presentation/screens/auth/otp_view.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_terms_conditions.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  final bool user;
  SignupPage({super.key, required this.user});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool agreeWithPolicy = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupPageController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
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
                            size: 21,
                            isBold: true,
                            color: AppColor.primaryColor),
                      ),
                      Center(
                        child: commonText("Fill in your information."),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            commonTextfieldWithTitle(
                              "Full Name",
                              fullNameController,
                              hintText: "Full Name",
                              keyboardType: TextInputType.text,
                              onValidate: (value) =>
                                  OtherHelper.validator(value),
                            ),
                            const SizedBox(height: 20),
                            commonTextfieldWithTitle(
                              "Email",
                              emailController,
                              assetIconPath: "assets/icons/emailicon.png",
                              hintText: "Email",
                              keyboardType: TextInputType.emailAddress,
                              onValidate: (value) =>
                                  OtherHelper.emailValidator(value),
                            ),
                            const SizedBox(height: 20),
                            Consumer<SignupPageController>(
                              builder: (context, controller, _) {
                                return commonTextfieldWithTitle(
                                  "Password",
                                  passwordController,
                                  hintText: "Password",
                                  assetIconPath: "assets/icons/lockicon.png",
                                  issuffixIconVisible: true,
                                  isPasswordVisible:
                                      controller.isPasswordVisible,
                                  changePasswordVisibility:
                                      controller.togglePasswordVisibility,
                                  keyboardType: TextInputType.visiblePassword,
                                  onValidate: (value) =>
                                      OtherHelper.passwordValidator(value),
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
                                  changePasswordVisibility: controller
                                      .toggleConfirmPasswordVisibility,
                                  keyboardType: TextInputType.visiblePassword,
                                  onValidate: (value) {
                                    if (passwordController.text !=
                                        confirmPasswordController.text) {
                                      return "Password don't match";
                                    } else if (confirmPasswordController
                                        .text.isEmpty) {
                                      return "This field is required";
                                    }
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: agreeWithPolicy,
                            onChanged: (value) => setState(() {
                              agreeWithPolicy = value!;
                            }),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonText("Agree with "),
                                InkWell(
                                  onTap: () {
                                    animetedNavigationPush(
                                        UserTermsconditionsPage(), context);
                                  },
                                  child: commonText("Terms and Conditions.",
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Consumer<SignupPageController>(
                        builder: (context, controller, _) {
                          return commonButton("Sign Up", onTap: () async {
                            if (formKey.currentState!.validate()) {
                              if (agreeWithPolicy == true) {
                                try {
                                  final signupResponse =
                                      await controller.signup(
                                          fullName: fullNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          confirmPassword:
                                              confirmPasswordController.text,
                                          user:
                                              widget.user ? "user" : "driver");

                                  if (signupResponse != null) {
                                    showCommonSnackbar(context,
                                        "Signup successful! OTP sent to your email.");
                                    animetedNavigationPush(
                                      OtpPage(
                                        user: widget.user,
                                        email: emailController.text,
                                        fromSignUp: true,
                                        token: signupResponse.data.signUpToken,
                                      ),
                                      context,
                                    );
                                  } else {
                                    showCommonSnackbar(context,
                                        "Signup failed. Please try again.",
                                        isError: true);
                                  }
                                } catch (e) {
                                  showCommonSnackbar(context, e.toString(),
                                      isError: true);
                                }
                              }
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
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
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
                      // const SizedBox(height: 20),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(horizontal: 20),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       border:
                      //           Border.all(width: 1, color: AppColor.black)),
                      //   child: commonIconButton(
                      //       "Sign Up With Facebook",
                      //       isBold: false,
                      //       Image.asset("assets/icons/logos_facebook.png"),
                      //       color: Colors.transparent,
                      //       textColor: AppColor.black),
                      // ),
                      const SizedBox(height: 20),
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
                ),
              ),
            ),
            // Loading Indicator
            Consumer<SignupPageController>(
              builder: (context, controller, _) {
                return CommonLoading(isLoading: controller.isLoading);
              },
            ),
          ],
        ),
      ),
    );
  }
}
