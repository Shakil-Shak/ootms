// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/controllers/user/static_controller/static_controller.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/common/widgets.dart';
import 'package:ootms/presentation/screens/role/driver/home/equipment.dart';
import 'package:ootms/presentation/screens/role/driver/settings/driver_settings.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_current_shipments.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_load_request.dart';
import 'package:ootms/presentation/screens/role/driver/subsciption.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/color/app_color.dart';
import '../../../../../main.dart';
import '../../../../api/sharePrefarences/local_storage_save.dart';
import '../../../../components/common_button.dart';
import '../../user/home/user_support.dart';
import '../../user/settings/about_us_screen.dart';
import '../../user/settings/user_privacy_policy.dart';
import '../../user/settings/user_settings.dart';
import '../../user/settings/user_terms_conditions.dart';
import '../../user/shipping/user_load_request.dart';

Widget driverCustomDrawer(BuildContext context) {
  return Drawer(
    child: Consumer<ProfileController>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User info at the top
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/profile.jpg'), // Change to your profile image path
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
                const SizedBox(height: 16),
                // Menu items
                DrawerMenuItem(
                  iconPath: 'assets/icons/shipment.png',
                  text: 'Current Shipment',
                  onTap: () {
                    animetedNavigationPush(
                        DriverCurrentShipmentsPage(), context);
                  },
                ),
                DrawerMenuItem(
                  iconPath: 'assets/icons/arrow_up.png',
                  text: 'Load Request',
                  onTap: () {
                    value.getLoadRequestData(context: context).then((value) =>
                        animetedNavigationPush(
                             DriverLoadRequestPage(), context));
                  },
                ),
                DrawerMenuItem(
                  iconPath:
                      'assets/icons/user home page/truck-svgrepo-com 1.png',
                  text: 'My Equipment',
                  onTap: () {
                    value.getEquipmentData().then((value) =>
                        animetedNavigationPush(MyEquipmentPage(), context));
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
                  iconPath: 'assets/icons/settings.png',
                  text: 'Settings',
                  onTap: () {
                    animetedNavigationPush(const DriverSettingsPage(), context);
                  },
                ),
                const SizedBox(height: 20),
                // About and support section at the bottom
                Consumer<StaticController>(
                  builder: (context, value, child) {
                    return DrawerMenuItem(
                      icon: const Icon(Icons.info_outline),
                      text: 'About Us',
                      onTap: () {
                        value.getAboutUs(context);
                        animetedNavigationPush(const AboutUsScreen(), context);
                      },
                    );
                  },
                ),
                DrawerMenuItem(
                  iconPath: 'assets/icons/shild.png',
                  text: 'Support',
                  onTap: () {
                    animetedNavigationPush(UserSupportPage(), context);
                  },
                ),
                Consumer<StaticController>(
                  builder: (context, controller, child) {
                    return DrawerMenuItem(
                      iconPath: 'assets/icons/privacy.png',
                      text: 'Privacy Policy',
                      onTap: () {
                        controller.getPrivacyPolicy(context);
                        animetedNavigationPush(
                            const UserPrivacyPolicyPage(), context);
                      },
                    );
                  },
                ),
                Consumer<StaticController>(
                  builder: (context, controll, child) {
                    return DrawerMenuItem(
                      iconPath: 'assets/icons/terms_and_condition.png',
                      text: 'Terms and Conditions',
                      onTap: () {
                        controll.getTermsConditions(context);
                        animetedNavigationPush(
                            const UserTermsconditionsPage(), context);
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                DrawerMenuItem(
                  iconPath: 'assets/icons/logout.png',
                  text: 'Log Out',
                  onTap: () {
                    _showDeleteAccountDialog(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
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
              child:
                  commonText('Do you want to Logout?', size: 16, isBold: true),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: commonButton(
                      "Cancel",
                      borderRadious: 10,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      color: const Color(0xFFDDDDDD),
                      textColor: AppColor.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: commonButton(
                      "Logout",
                      onTap: () {
                        deleteUserAccessDetails(context: context);
                        main();
                      },
                      borderRadious: 10,
                      color: const Color(0xFFCE0000),
                    ),
                  ),
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
