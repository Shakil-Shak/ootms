// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/auth/signin/signin_view.dart';
import 'package:ootms/presentation/screens/auth/signup/signup_view.dart';

class SignInSignUpChosserPage extends StatefulWidget {
  SignInSignUpChosserPage({super.key, required this.role});
  String role;

  @override
  State<SignInSignUpChosserPage> createState() =>
      _SignInSignUpChosserPageState();
}

class _SignInSignUpChosserPageState extends State<SignInSignUpChosserPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        commonText("Now continue after register in",
            size: 21, textAlign: TextAlign.center),
        commonText("“OOTMS.”", size: 21, isBold: true),
        SizedBox(
          height: 50,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonButton("Sign In",
                onTap: () => animetedNavigationPush(SignInPage(), context),
                color: AppColor.primaryColor,
                textColor: AppColor.white),
            SizedBox(
              height: 20,
            ),
            commonBorderButton("Sign Up",
                onTap: () => animetedNavigationPush(SignupPage(), context)),
          ],
        )
      ],
    );
  }
}
