// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/assets/images_string.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/common/widgets.dart';
import 'package:ootms/presentation/screens/role/driver/subsciption.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/assign_preferred_driver%20copy.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/load_data.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_current_shipments.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_load_request.dart';
import 'package:ootms/presentation/screens/role/user/home/user_support.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_terms_conditions.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_privacy_policy.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_settings.dart';

Widget userCustomDrawer(BuildContext context) {
  return Drawer(
    child: Padding(
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
                animetedNavigationPush(LoadDataScreen(), context);
              },
            ),
            DrawerMenuItem(
              iconPath: 'assets/icons/arrow_up.png',
              text: 'My Load Request',
              onTap: () {
                Navigator.pop(context);
                animetedNavigationPush(
                    const UserLoadRequestPage(
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
                Navigator.pop(context);
                animetedNavigationPush(const AddPreferredDriverPage2(), context);
              },
            ),

            DrawerMenuItem(
              iconPath: 'assets/icons/settings.png',
              text: 'Settings',
              onTap: () {
                Navigator.pop(context);
                animetedNavigationPush(const UserSettingsPage(), context);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            // About and support section at the bottom
            DrawerMenuItem(
              icon: const Icon(Icons.info_outline),
              text: 'About Us',
              onTap: () {},
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
                animetedNavigationPush(const UserPrivacyPolicyPage(), context);
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
              onTap: () {},
            ),
          ],
        ),
      ),
    ),
  );
}
