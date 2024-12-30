// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/common/country_model.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_support.dart';
import 'package:ootms/presentation/screens/role/driver/profile/driver_edit_profile.dart';
import 'package:ootms/presentation/screens/role/driver/settings/driver_settings.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_current_shipments.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_load_request.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
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
        title: commonText("Profile", size: 21, isBold: true),
        centerTitle: true,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 1, color: AppColor.primaryColor)),
              child: Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(40),
                        image: const DecorationImage(
                            image:
                                AssetImage("assets/icons/profile_icon_2.png"),
                            fit: BoxFit.cover)),
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            commonText("MostainAhmed", size: 18, isBold: true),
            commonText("example@gmail.com"),
            const SizedBox(
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
                    onTap: () {
                      animetedNavigationPush(
                          const DriverEditProfile(), context);
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: "assets/icons/shipment.png",
                    text: "Current Shipments",
                    onTap: () {
                      animetedNavigationPush(
                          DriverCurrentShipmentsPage(), context);
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: "assets/icons/arrow_up.png",
                    text: "Load Request",
                    onTap: () {
                      animetedNavigationPush(DriverLoadRequestPage(), context);
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: "assets/icons/settings.png",
                    text: "Settings",
                    onTap: () {
                      animetedNavigationPush(DriverSettingsPage(), context);
                    },
                  ),
                  ProfileMenuItem(
                    iconPath: "assets/icons/shild.png",
                    text: "Support",
                    onTap: () {
                      animetedNavigationPush(DriverSupportPage(), context);
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
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
                    },
                            color: const Color(0xFFDDDDDD),
                            textColor: AppColor.black)),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: commonButton("Logout", onTap: () {
                      Navigator.pop(context);
                    }, borderRadious: 10, color: const Color(0xFFCE0000)))
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
