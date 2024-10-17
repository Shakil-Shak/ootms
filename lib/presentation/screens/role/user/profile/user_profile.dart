// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/screens/role/user/country_model.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final List<Country> countries = [
    Country('United States', '+1', 'assets/images/usaflag.png'),
    Country('Canada', '+1', 'assets/images/usaflag.png'),
    Country('United Kingdom', '+44', 'assets/images/usaflag.png'),
    Country('Australia', '+61', 'assets/images/usaflag.png'),
    // Add more countries as needed
  ];

  Country? selectedCountry;

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: commonText("Edit Profile", size: 21, isBold: true),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1, color: AppColor.primaryColor)),
              child: Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(40),
                        image: const DecorationImage(
                            image:
                                AssetImage("assets/icons/profile_icon_2.png"),
                            fit: BoxFit.cover)),
                  ),
                  const Positioned(
                    bottom: 5,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 12,
                      child: Icon(Icons.mode_edit_outline_outlined,
                          size: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            commonText("MostainAhmed", size: 18, isBold: true),
            commonText("example@gmail.com"),
            SizedBox(
              height: 10,
            ),
            // Profile Menu Options
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 1),
              ),
              child: Column(
                children: [
                  ProfileMenuItem(
                    iconPath: "assets/icons/edit-profile.png",
                    text: "Edit Profile",
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    iconPath: "assets/icons/shipment.png",
                    text: "Current Shipments",
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    iconPath: "assets/icons/arrow_up.png",
                    text: "Load Request",
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    iconPath: "assets/icons/settings.png",
                    text: "Settings",
                    onTap: () {},
                  ),
                  ProfileMenuItem(
                    iconPath: "assets/icons/shild.png",
                    text: "Support",
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 1),
              ),
              child: ProfileMenuItem(
                iconPath: "assets/icons/logout.png",
                text: "Logout",
                onTap: () {
                  _showDeleteAccountDialog(context);
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
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
                child: commonText('Do you want to Logout?',
                    size: 16, isBold: true),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: Row(
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
                        child: commonButton("Logout", onTap: () {
                      Navigator.pop(context);
                    }, borderRadious: 10, color: Color(0xFFCE0000)))
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
}

class ProfileMenuItem extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.iconPath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.transparent,
      leading: Image.asset(
        iconPath,
      ),
      title: commonText(
        text,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}
