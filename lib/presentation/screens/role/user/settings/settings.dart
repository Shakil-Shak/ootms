import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/settings/changePassword.dart';
import 'package:provider/provider.dart';

// Main settings page
class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DeleteAccountPageController>(
      create: (_) => DeleteAccountPageController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: commonText('Settings', size: 20, isBold: true),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              SettingsOption(
                icon: Image.asset("assets/icons/Lock.png"),
                text: 'Change password',
                onTap: () {
                  animetedNavigationPush(
                      ChangeNotifierProvider(
                          create: (context) => ChangepasswordPageController(),
                          child: ChangepasswordPage()),
                      context);
                },
              ),
              const SizedBox(height: 16.0),
              SettingsOption(
                icon: Image.asset(
                  "assets/icons/privacy.png",
                ),
                text: 'Privacy Policy',
                onTap: () {
                  // Implement the Report a problem feature
                },
              ),
              const SizedBox(height: 16.0),
              SettingsOption(
                icon: Image.asset(
                  "assets/icons/terms_and_condition.png",
                ),
                text: 'Terms and Conditions',
                onTap: () {
                  // Implement the Report a problem feature
                },
              ),
              const SizedBox(height: 16.0),
              SettingsOption(
                icon: Image.asset("assets/icons/delete.png"),
                text: 'Delete account',
                onTap: () {
                  _showDeleteAccountDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to show the delete account dialog
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: Consumer<DeleteAccountPageController>(
            builder: (context, controller, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Center(
                    child: commonText('Do you want to delete your account?',
                        size: 16, isBold: true),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: commonButton("Cancle", borderRadious: 10,
                              onTap: () {
                        Navigator.pop(context);
                      }, color: Color(0xFFDDDDDD), textColor: AppColor.black)),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: commonButton("Delete", onTap: () {
                        Navigator.pop(context);
                      }, borderRadious: 10, color: Color(0xFFCE0000)))
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

// Settings Option widget
class SettingsOption extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;

  const SettingsOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(width: 16.0),
                commonText(text, size: 16.0, color: Colors.black),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
            )
          ],
        ),
      ),
    );
  }
}

// Provider class for Delete Account page
class DeleteAccountPageController extends ChangeNotifier {
  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void selectPasswordVisibility(bool visibility) {
    _isPasswordVisible = visibility;
    notifyListeners();
  }
}
