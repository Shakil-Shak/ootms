import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../api/service/api_services.dart';
import '../../../../api/url_paths.dart';
import '../../../../components/common_snackbar.dart';

// Main ChangepasswordPage
class DriverChangepasswordPage extends StatelessWidget {
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  DriverChangepasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DriverChangepasswordPageController>(
      create: (_) => DriverChangepasswordPageController(),
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
              Consumer<DriverChangepasswordPageController>(
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
              Consumer<DriverChangepasswordPageController>(
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
              Consumer<DriverChangepasswordPageController>(
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
                  const SizedBox(
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
              Consumer<DriverChangepasswordPageController>(
                builder: (context, value, child) {
                  return commonButton(
                    "Submit",
                    onTap: () {
                      value.changePass(
                          currentPass: oldPasswordController.text,
                          newPass: passwordController.text,
                          userEmail: confirmPasswordController.text,
                          context: context);
                    },
                  );
                },
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// Provider class for Change Password page
class DriverChangepasswordPageController extends ChangeNotifier {
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

  //============================================change password method
  final ApiService apiService = ApiService();
  bool isLoading = false;
  changePass(
      {String? currentPass,
      String? newPass,
      String? userEmail,
      context}) async {
    isLoading = true;
    notifyListeners();
    Map<String,String> body = {
        "oldPassword": currentPass.toString(),
        "newPassword": newPass.toString(),
        "userEmail": userEmail.toString(),
      };

    try {
      var response = await apiService.patchRequest(ApiPaths.chagePassword, body);
      print("====================================================response$response");
      debugPrint(
          "========================================statuscode ${response["statusCode"]}");
      if (response["statusCode"] == "200") {
        Navigator.pop(context);
        showCommonSnackbar(context, "Change password successful!");
      } else {
        showCommonSnackbar(context, "Change password Failed! Try Again",isError: true);
      }
    } catch (e) {
      debugPrint("=========eeeeee$e");
      showCommonSnackbar(context, "Invalid password, try again!",isError: true);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
