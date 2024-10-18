// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/shipping/current_shipments.dart';
import 'package:ootms/presentation/screens/role/shipping/load_request.dart';
import 'package:ootms/presentation/screens/role/user/home/support.dart';
import 'package:ootms/presentation/screens/role/user/settings/TermsConditions.dart';
import 'package:ootms/presentation/screens/role/user/settings/privacyPolicy.dart';
import 'package:ootms/presentation/screens/role/user/settings/settings.dart';

class DrawerMenuItem extends StatelessWidget {
  final String? iconPath;
  Widget? icon;
  final String text;
  final VoidCallback onTap;

  DrawerMenuItem({
    super.key,
    this.icon,
    this.iconPath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      leading: (iconPath != null)
          ? Image.asset(
              iconPath!,
              width: 24, // Adjust size according to your design
              height: 24,
            )
          : icon!,
      title: commonText(text, size: 14),
      onTap: onTap,
    );
  }
}

Widget customDrawer(BuildContext context) {
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
              SizedBox(width: 16),
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
          Spacer(),
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
              animetedNavigationPush(CurrentShipmentsPage(), context);
            },
          ),
          DrawerMenuItem(
            iconPath: 'assets/icons/arrow_up.png',
            text: 'Load Request',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(LoadRequestPage(), context);
            },
          ),

          DrawerMenuItem(
            iconPath: 'assets/icons/settings.png',
            text: 'Settings',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(SettingsPage(), context);
            },
          ),
          Spacer(
            flex: 3,
          ),
          // About and support section at the bottom
          DrawerMenuItem(
            icon: Icon(Icons.info_outline),
            text: 'About Us',
            onTap: () {},
          ),
          DrawerMenuItem(
            iconPath: 'assets/icons/shild.png',
            text: 'Support',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(SupportPage(), context);
            },
          ),
          DrawerMenuItem(
            iconPath: 'assets/icons/privacy.png',
            text: 'Privacy Policy',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(PrivacyPolicyPage(), context);
            },
          ),
          DrawerMenuItem(
            iconPath: 'assets/icons/terms_and_condition.png',
            text: 'Terms and Conditions',
            onTap: () {
              Navigator.pop(context);
              animetedNavigationPush(TermsconditionsPage(), context);
            },
          ),
          Spacer(
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
