

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/main.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/feedback_screen.dart';
import 'package:ootms/presentation/screens/role/driver/home/equipment.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_current_shipments.dart';
import 'package:provider/provider.dart';
import '../../../../api/controllers/user/profile_controller/profile_controller.dart';
import '../../../../api/url_paths.dart';
import '../../../../components/common_image.dart';
import '../../user/home/user_support.dart';
import '../../user/profile/user_edit_profile.dart';
import '../../user/profile/user_profile.dart';
import '../../user/settings/user_settings.dart';
import '../../user/shipping/user_load_request.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
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
              // Scrollable content
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      controller.profileData.image?.isNotEmpty ?? false
                          ? CommonImage(
                              imageSrc: ApiPaths.baseUrl +
                                  controller.profileData.image,
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
                      const SizedBox(height: 10),
                      commonText(controller.profileData.fullName,
                          size: 18, isBold: true),
                      commonText(controller.profileData.email),
                      const SizedBox(height: 10),
                      // Profile Menu Options
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(width: 1),
                        ),
                        child: Column(
                          children: _buildProfileMenuItems(controller),
                        ),
                      ),
                      const SizedBox(height: 20),
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
              // Loading indicator
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

  List<Widget> _buildProfileMenuItems(ProfileController controller) {
    return [
      ProfileMenuItem(
        iconPath: "assets/icons/edit-profile.png",
        text: "Edit Profile",
        onTap: () {
          animetedNavigationPush(
              UserEditProfile(
                imagePath: controller.profileData.image,
                title: controller.profileData.fullName,
                email: controller.profileData.email,
                contact: "134165415",
                address: "Dhaka",
                country: "Bangladesh",
              ),
              context);
        },
      ),
      ProfileMenuItem(
        iconPath: "assets/icons/shipment.png",
        text: "Current Shipments",
        onTap: () {
          controller.getCurrentShipData(context: context);
          animetedNavigationPush( DriverCurrentShipmentsPage(), context);
        },
      ),
      ProfileMenuItem(
        iconPath: "assets/icons/arrow_up.png",
        text: "Load Request",
        onTap: () {
          controller
              .getLoadRequestData(context: context)
              .then((value) => animetedNavigationPush(
                  const UserLoadRequestPage(), context));
        },
      ),
      ProfileMenuItem(
        iconPath: AppIcons.equipment,
        text: "Equipment",
        onTap: () {
          controller
              .getEquipmentData()
              .then((value) => 
                animetedNavigationPush(MyEquipmentPage(), context));
        },
      ),
      ProfileMenuItem(
        iconPath: AppIcons.feedback,
        text: "Feedback",
        onTap: () {
          animetedNavigationPush(FeedbackScreen(), context);
        },
      ),
      ProfileMenuItem(
        iconPath: "assets/icons/settings.png",
        text: "Settings",
        onTap: () {
          animetedNavigationPush(const UserSettingsPage(), context);
        },
      ),
      ProfileMenuItem(
        iconPath: "assets/icons/shild.png",
        text: "Support",
        onTap: () {
          animetedNavigationPush(UserSupportPage(), context);
        },
      ),
    ];
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
                        child: commonButton("Cancel", borderRadious: 10,
                            onTap: () {
                      Navigator.pop(context);
                    },
                            color: const Color(0xFFDDDDDD),
                            textColor: AppColor.black)),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: commonButton("Logout", onTap: () {
                      deleteUserAccessDetails(context: context);
                      main();
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
