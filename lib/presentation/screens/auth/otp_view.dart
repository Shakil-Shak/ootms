import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_otp_field.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/user_bottom_navigation.dart';
import 'package:provider/provider.dart';

class OtpPage extends StatelessWidget {
  final bool user;
  OtpPage({Key? key, required this.user}) : super(key: key);

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
                SizedBox(
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
                        SizedBox(
                          width: 16,
                        ),
                        commonText("Resend",
                            size: 14,
                            isBold: true,
                            decoration: TextDecoration.underline)
                      ],
                    ),
                  ],
                ),
                Spacer(),
                commonButton("Verify", onTap: () {
                  if (user) {
                    animetedNavigationPush(const UserRootPage(), context);
                  } else {}
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

class SignUpOtpController extends ChangeNotifier {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  int _timer = 30;
  bool _isResendEnabled = false;

  int get timer => _timer;
  bool get isResendEnabled => _isResendEnabled;

  SignUpOtpController() {
    startTimer();
  }

  void startTimer() {
    _isResendEnabled = false;
    _timer = 30;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), updateTimer);
  }

  void updateTimer() {
    if (_timer > 0) {
      _timer--;
      notifyListeners();
      Future.delayed(const Duration(seconds: 1), updateTimer);
    } else {
      _isResendEnabled = true;
      notifyListeners();
    }
  }

  void resendOtp() {
    startTimer();
    // Add any additional logic for resending the OTP here
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
