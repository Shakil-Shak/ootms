// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

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
              color: AppColor.black,
            )
          : icon!,
      title: commonText(text, size: 14),
      onTap: onTap,
    );
  }
}
