
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/main.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_image.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/home/user_support.dart';
import 'package:ootms/presentation/screens/role/user/profile/user_edit_profile.dart';
import 'package:ootms/presentation/screens/role/user/settings/user_settings.dart';
import 'package:provider/provider.dart';

import '../shipping/user_load_request.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final profileController =
          Provider.of<ProfileController>(context, listen: false);
      profileController.getProfileData();
    });
  }

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
      body: Consumer<ProfileController>(
        builder: (context, controller, child) {
          return Stack(
            children: [
              // Content of the page
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      // Safely checking if profileData and image are not null
                      controller.profileData.image!.isNotEmpty
                          ? CommonImage(
                              imageSrc: ApiPaths.baseUrl +
                                  controller.profileData.image!,
                              imageType: ImageType.network,
                              size: 100,
                              borderRadius: 100,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 1, color: AppColor.primaryColor)),
                              child: Container(
                                width: 80,
                                height: 80,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: AppColor.primaryColor,
                                    borderRadius: BorderRadius.circular(40),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/icons/profile_icon_2.png"),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Safely accessing profileData fields
                      commonText(controller.profileData?.fullName ?? "",
                          size: 18, isBold: true),
                      commonText(controller.profileData?.email ?? ""),
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
                            //=======================edit profile
                            Consumer<ProfileController>(
                                builder: (context, controller, _) {
                              return ProfileMenuItem(
                                iconPath: "assets/icons/edit-profile.png",
                                text: "Edit Profile",
                                onTap: () {
                                  log("controller.profileData.image : ${controller.profileData.image}");
                                  animetedNavigationPush(
                                      UserEditProfile(
                                        imagePath: controller.profileData.image!,
                                        title: controller.profileData.fullName!,
                                        email: controller.profileData.email!,
                                        contact: "134165415",
                                        address: "Dhaka",
                                        country: "Bangladesh",
                                      ),
                                      context);
                                },
                              );
                            }),
                            //===================================current shiping
                            Consumer<ProfileController>(
                                builder: (context, controller, _) {
                              return ProfileMenuItem(
                                iconPath: "assets/icons/shipment.png",
                                text: "Current Shipments",
                                onTap: () {
                                  controller.getCurrentShipData(context: context);
                                },
                              );
                            }),
                            Consumer<ProfileController>(
                                builder: (context, controller, _) {
                              return ProfileMenuItem(
                                iconPath: "assets/icons/arrow_up.png",
                                text: "Load Request",
                                onTap: () {
                                  controller.getLoadRequestData(context: context).then((value) => animetedNavigationPush(const UserLoadRequestPage(), context));
                                },
                              );
                            }),
                            ProfileMenuItem(
                              iconPath: "assets/icons/settings.png",
                              text: "Settings",
                              onTap: () {
                                animetedNavigationPush(
                                    const UserSettingsPage(), context);
                              },
                            ),
                            ProfileMenuItem(
                              iconPath: "assets/icons/shild.png",
                              text: "Support",
                              onTap: () {
                                animetedNavigationPush(
                                    UserSupportPage(), context);
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
              ),
              //==============================================common loading
              // Display CircularProgressIndicator when loading
              if (controller.isLoading)
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                    ),
                  ),
                ),
            ],
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
