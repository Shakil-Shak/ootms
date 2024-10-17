import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:provider/provider.dart';

// Main ChangepasswordPage
class ChangepasswordPage extends StatelessWidget {
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  ChangepasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangepasswordPageController>(
      create: (_) => ChangepasswordPageController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: commonText('Change password', size: 20, isBold: true),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              // Old Password Field
              Consumer<ChangepasswordPageController>(
                builder: (context, controller, _) {
                  return commonTextfieldWithTitle(
                    "Old Password",
                    oldPasswordController,
                    hintText: "Password",
                    issuffixIconVisible: true,
                    textSize: 20.0,
                    prifixIconWidget: Image.asset("assets/icons/lockicon.png"),
                    isPasswordVisible: controller.isoldPasswordVisible,
                    changePasswordVisibility: () {
                      controller.toggleOldPasswordVisibility();
                    },
                    keyboardType: TextInputType.visiblePassword,
                  );
                },
              ),

              const SizedBox(height: 16),

              // New Password Field
              Consumer<ChangepasswordPageController>(
                builder: (context, controller, _) {
                  return commonTextfieldWithTitle(
                    "New Password",
                    passwordController,
                    hintText: "Password",
                    textSize: 20.0,
                    issuffixIconVisible: true,
                    prifixIconWidget: Image.asset("assets/icons/lockicon.png"),
                    isPasswordVisible: controller.isPasswordVisible,
                    changePasswordVisibility: () {
                      controller.togglePasswordVisibility();
                    },
                    keyboardType: TextInputType.visiblePassword,
                  );
                },
              ),

              const SizedBox(height: 16),

              // Confirm Password Field
              Consumer<ChangepasswordPageController>(
                builder: (context, controller, _) {
                  return commonTextfieldWithTitle(
                    "Confirm Password",
                    confirmPasswordController,
                    hintText: "Password",
                    textSize: 20.0,
                    prifixIconWidget: Image.asset("assets/icons/lockicon.png"),
                    issuffixIconVisible: true,
                    isPasswordVisible: controller.isconfirmPasswordVisible,
                    changePasswordVisibility: () {
                      controller.toggleConfirmPasswordVisibility();
                    },
                    keyboardType: TextInputType.visiblePassword,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  commonText("Forgot Password",
                      decoration: TextDecoration.underline,
                      isBold: true,
                      size: 16)
                ],
              ),

              const Spacer(flex: 4),

              // Change Password Button
              commonButton("Submit"),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// Provider class for Change Password page
class ChangepasswordPageController extends ChangeNotifier {
  bool _isPasswordVisible = false;
  bool _isoldPasswordVisible = false;
  bool _isconfirmPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isoldPasswordVisible => _isoldPasswordVisible;
  bool get isconfirmPasswordVisible => _isconfirmPasswordVisible;

  // Toggle Password Visibility
  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Toggle Old Password Visibility
  void toggleOldPasswordVisibility() {
    _isoldPasswordVisible = !_isoldPasswordVisible;
    notifyListeners();
  }

  // Toggle Confirm Password Visibility
  void toggleConfirmPasswordVisibility() {
    _isconfirmPasswordVisible = !_isconfirmPasswordVisible;
    notifyListeners();
  }
}
