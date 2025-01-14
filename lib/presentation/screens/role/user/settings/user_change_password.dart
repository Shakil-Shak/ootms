import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../api/service/api_services.dart';
import '../../../../api/url_paths.dart';
import '../../../../components/common_loading.dart';

// Main ChangepasswordPage
class UserChangepasswordPage extends StatelessWidget {
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();

  UserChangepasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserChangepasswordPageController>(
      create: (_) => UserChangepasswordPageController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: commonText('Change password', size: 20, isBold: true),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body:  SingleChildScrollView(
  child: ConstrainedBox(
    constraints: BoxConstraints(
      minHeight: MediaQuery.of(context).size.height, // Full screen height
    ),
    child: IntrinsicHeight(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                // Old Password Field
                Consumer<UserChangepasswordPageController>(
                  builder: (context, controller, _) {
                    return commonTextfieldWithTitle(
                      "Current Password",
                      oldPasswordController,
                      hintText: "Password",
                      issuffixIconVisible: true,
                      textSize: 20.0,
                      prifixIconWidget:
                          Image.asset("assets/icons/lockicon.png"),
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
                Consumer<UserChangepasswordPageController>(
                  builder: (context, controller, _) {
                    return commonTextfieldWithTitle(
                      "New Password",
                      passwordController,
                      hintText: "Password",
                      textSize: 20.0,
                      issuffixIconVisible: true,
                      prifixIconWidget:
                          Image.asset("assets/icons/lockicon.png"),
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
                Consumer<UserChangepasswordPageController>(
                  builder: (context, controller, _) {
                    return commonTextfieldWithTitle(
                      "Confirm Password",
                      confirmPasswordController,
                      hintText: "Password",
                      textSize: 20.0,
                      prifixIconWidget:
                          Image.asset("assets/icons/lockicon.png"),
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
                const Spacer(flex: 1),
                // Change Password Button
                Consumer<UserChangepasswordPageController>(
                  builder: (context, controller, child) {
                    return commonButton(
                      "Submit",
                      onTap: () {
                        controller.changePass(
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
          // Loading Indicator
            Consumer<UserChangepasswordPageController>(
              builder: (context, controller, _) {
                return CommonLoading(isLoading: controller.isLoading);
              },
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

// Provider class for Change Password page
class UserChangepasswordPageController extends ChangeNotifier {
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

    try {
      var response = await apiService.patchRequest(ApiPaths.chagePassword, {
        "oldPassword": currentPass.toString(),
        "newPassword": newPass.toString(),
        "userEmail": userEmail.toString(),
      });
      debugPrint(
          "========================================statuscode ${response["statusCode"]}");
      if (response["statusCode"] == "200") {
        Navigator.pop(context);
        showCommonSnackbar(context, "Change password successful!");
      } else {
        showCommonSnackbar(context, "Change password Failed! Try Again");
      }
    } catch (e) {
      debugPrint("=========$e");
      showCommonSnackbar(context, "Invalid password, try again!");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
