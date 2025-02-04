import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_change_password.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_privacy_policy.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_terms_conditions.dart';
import 'package:provider/provider.dart';

import '../../../../api/controllers/user/static_controller/static_controller.dart';

// Main settings page
class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: commonText('Settings', size: 20, isBold: true),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Consumer<StaticController>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  UserSettingsOption(
                    icon: Image.asset("assets/icons/Lock.png"),
                    text: 'Change password',
                    onTap: () {
                      animetedNavigationPush(
                          ChangeNotifierProvider(
                              create: (context) =>
                                  UserChangepasswordPageController(),
                              child: UserChangepasswordPage()),
                          context);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  UserSettingsOption(
                    icon: Image.asset(
                      "assets/icons/privacy.png",
                    ),
                    text: 'Privacy Policy',
                    onTap: () {
                      value.getPrivacyPolicy(context);
                      animetedNavigationPush(
                          const UserPrivacyPolicyPage(), context);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  UserSettingsOption(
                    icon: Image.asset(
                      "assets/icons/terms_and_condition.png",
                    ),
                    text: 'Terms and Conditions',
                    onTap: () {
                      value.getTermsConditions(context);
                      animetedNavigationPush(
                          const UserTermsconditionsPage(), context);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  UserSettingsOption(
                    icon: Image.asset("assets/icons/delete.png"),
                    text: 'Delete account',
                    onTap: () {
                      _showDeleteAccountDialog(context);
                    },
                  ),
                ],
              ),
            );
          },
        ));
  }

// Method to show the delete account dialog with a sliding effect from the center
  void _showDeleteAccountDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - animation.value) * 300),
                  child: child,
                );
              },
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<StaticController>(
                    builder: (context, controller, _) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: commonText(
                                'Do you want to delete your account?',
                                size: 16,
                                isBold: true),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                  child: commonButton("Cancel",
                                      borderRadious: 10, onTap: () {
                                Navigator.pop(context);
                              },
                                      color: const Color(0xFFDDDDDD),
                                      textColor: AppColor.black)),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: commonButton("Delete", onTap: () {
                                Navigator.pop(context);
                              },
                                      borderRadious: 10,
                                      color: const Color(0xFFCE0000)))
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Settings Option widget
class UserSettingsOption extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;

  const UserSettingsOption({
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
            const Icon(
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
// class UserDeleteAccountPageController extends ChangeNotifier {

// }
