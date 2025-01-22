// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/assets/images_string.dart';
import 'package:ootms/presentation/api/controllers/user/static_controller/static_controller.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/common/widgets.dart';
import 'package:ootms/presentation/screens/role/driver/subsciption.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/assign_preferred_driver%20copy.dart';
import 'package:ootms/presentation/screens/role/user/settings/about_us_screen.dart';
import 'package:ootms/presentation/screens/role/user/shipment/pending_shipment.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_current_shipments.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_load_request.dart';
import 'package:ootms/presentation/screens/role/user/home/user_support.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_terms_conditions.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_privacy_policy.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_settings.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/color/app_color.dart';
import '../../../../../main.dart';
import '../../../../api/sharePrefarences/local_storage_save.dart';
import '../../../../components/common_button.dart';

Widget userCustomDrawer(BuildContext context) {
  return Drawer(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(child: Consumer<StaticController>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info at the top
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(AppImages.profile),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      commonText('Mostain Billah', size: 14, isBold: true),
                      commonText(
                        'example@gmail.com',
                      ),
                    ],
                  ),
                ],
              ),

              DrawerMenuItem(
                iconPath: 'assets/icons/shipment.png',
                text: 'Current Shipment',
                onTap: () {
                  Navigator.pop(context);
                  animetedNavigationPush(UserCurrentShipmentsPage(), context);
                },
              ),
              DrawerMenuItem(
                iconPath: 'assets/icons/loading.png',
                text: 'Pending Shipments',
                onTap: () {
                  Navigator.pop(context);
                  animetedNavigationPush(PendingShipmentScreen(), context);
                },
              ),
              DrawerMenuItem(
                iconPath: 'assets/icons/arrow_up.png',
                text: 'My Load Request',
                onTap: () async {
                  Navigator.pop(context);
                  animetedNavigationPush(
                      UserLoadRequestPage(
                        isFromDrawer: true,
                      ),
                      context);
                },
              ),
              DrawerMenuItem(
                iconPath: 'assets/icons/subscription.png',
                text: 'Subscriptions',
                onTap: () {
                  Navigator.pop(context);
                  animetedNavigationPush(const SubscriptionPage(), context);
                },
              ),
              DrawerMenuItem(
                iconPath: 'assets/icons/driverIcon.png',
                text: 'Add Preferred Driver',
                onTap: () {
                  animetedNavigationPush(
                      const AddPreferredDriverPage2(), context);
                },
              ),

              DrawerMenuItem(
                iconPath: 'assets/icons/settings.png',
                text: 'Settings',
                onTap: () {
                  Navigator.pop(context);
                  animetedNavigationPush( UserSettingsPage(), context);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              // About and support section at the bottom
              DrawerMenuItem(
                icon: const Icon(Icons.info_outline),
                text: 'About Us',
                onTap: () {
                  value.getAboutUs(context);
                  animetedNavigationPush(const AboutUsScreen(), context);
                },
              ),
              DrawerMenuItem(
                iconPath: 'assets/icons/shild.png',
                text: 'Support',
                onTap: () {
                  Navigator.pop(context);
                  animetedNavigationPush(UserSupportPage(), context);
                },
              ),
              DrawerMenuItem(
                iconPath: 'assets/icons/privacy.png',
                text: 'Privacy Policy',
                onTap: () {
                  Navigator.pop(context);
                  animetedNavigationPush(
                      const UserPrivacyPolicyPage(), context);
                },
              ),
              DrawerMenuItem(
                iconPath: 'assets/icons/terms_and_condition.png',
                text: 'Terms and Conditions',
                onTap: () {
                  Navigator.pop(context);
                  animetedNavigationPush(
                      const UserTermsconditionsPage(), context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DrawerMenuItem(
                iconPath: 'assets/icons/logout.png',
                text: 'Log Out',
                onTap: () {
                  _showDeleteAccountDialog(context);
                },
              ),
            ],
          );
        },
      )),
    ),
  );
}

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
        content: Column(
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
              child: commonText('Do you want to log out your profile?',
                  size: 18, isBold: true),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                      child: commonButton("Cancel", borderRadious: 10,
                          onTap: () {
                    Navigator.pop(context);
                  },
                          color: const Color(0xFFDDDDDD),
                          textColor: AppColor.black)),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: commonButton("Logout", onTap: () {
                    deleteUserAccessDetails(context: context);
                    main();
                  }, borderRadious: 10, color: AppColor.primaryColor))
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}
