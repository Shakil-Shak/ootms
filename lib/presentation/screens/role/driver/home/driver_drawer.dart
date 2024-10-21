// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/common/widgets.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_current_shipments.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_load_request.dart';
import 'package:ootms/presentation/screens/role/user/home/user_support.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_terms_conditions.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_privacy_policy.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_settings.dart';

Widget driverCustomDrawer(BuildContext context) {
  return Drawer(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
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
          const Spacer(),
          // Menu items
          DrawerMenuItem(
            iconPath: 'assets/icons/user home page/truck-svgrepo-com 1.png',
            text: 'Track Your Shipment',
            onTap: () {
              // Handle the action
            },
          ),
          DrawerMenuItem(
            iconPath: 'assets/icons/shipment.png', // Change to your icon path
            text: 'Current Shipment',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(UserCurrentShipmentsPage(), context);
            },
          ),
          DrawerMenuItem(
            iconPath: 'assets/icons/arrow_up.png',
            text: 'Load Request',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(UserLoadRequestPage(), context);
            },
          ),

          DrawerMenuItem(
            iconPath: 'assets/icons/settings.png',
            text: 'Settings',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(UserSettingsPage(), context);
            },
          ),
          const Spacer(
            flex: 3,
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
              animetedNavigationPush(const UserSupportPage(), context);
            },
          ),
          DrawerMenuItem(
            iconPath: 'assets/icons/privacy.png',
            text: 'Privacy Policy',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(UserPrivacyPolicyPage(), context);
            },
          ),
          DrawerMenuItem(
            iconPath: 'assets/icons/terms_and_condition.png',
            text: 'Terms and Conditions',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(UserTermsconditionsPage(), context);
            },
          ),
          const Spacer(
            flex: 2,
          ),
          DrawerMenuItem(
            iconPath: 'assets/icons/logout.png',
            text: 'Log Out',
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}
