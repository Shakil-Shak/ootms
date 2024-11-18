import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/chat/driver_chat_list.dart';
import 'package:ootms/presentation/screens/role/driver/find_load/driver_find_load.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_drawer.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_set_location.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_support.dart';
import 'package:ootms/presentation/screens/role/driver/notification/driver_all_notifications.dart';
import 'package:ootms/presentation/screens/role/driver/profile/driver_profile.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_shipping_history.dart';
import 'package:ootms/presentation/screens/role/user/chat/user_chat_list.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: driverCustomDrawer(context),
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
              child: Stack(
                children: [
                  // Background image
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/userHomePagebg.png'), // Replace with your image asset
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black38, BlendMode.multiply)),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: IconButton(
                                icon: const Icon(Icons.menu,
                                    size: 28, color: Colors.black),
                                onPressed: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                },
                              ),
                            ),
                            const Spacer(),
                            // Notification bell
                            // Image.asset(
                            //     "assets/icons/user home page/notify.png"),
                            Switch(
                              value: true,
                              onChanged: (value) {},
                              activeTrackColor: Colors.green[300],
                              activeColor: Colors.white,
                              inactiveTrackColor: Colors.grey[300],
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () {
                                animetedNavigationPush(
                                    DriverAllNotificationsPage(), context);
                              },
                              child: const FaIcon(
                                FontAwesomeIcons.solidBell,
                                color: Color.fromRGBO(255, 206, 49, 1),
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Profile avatar
                            InkWell(
                              onTap: () {
                                animetedNavigationPush(
                                    const DriverProfile(), context);
                              },
                              child: const CircleAvatar(
                                backgroundColor: AppColor.black,
                                backgroundImage: AssetImage(
                                    'assets/icons/profile_icon_2.png'),
                                radius: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: InkWell(
                          onTap: () {
                            animetedNavigationPush(
                                const DriverSetLocationPage(), context);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: AppColor.white,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    commonText(
                                        "36 East 8th Street, New York,\nNY 10003, United States.",
                                        size: 16,
                                        color: AppColor.white)
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppColor.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: commonText("Track Your Shipment",
                            size: 22, isBold: true, color: AppColor.white),
                      ),
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        padding: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Truck icon
                            const Icon(Icons.local_shipping,
                                color: Colors.blue),
                            const SizedBox(width: 10),

                            // Input field
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter bill of lading number',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: FittedBox(
                                child: commonButton(
                                  "Track",
                                  width: 120,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 40), // For spacing after the header

            // Action Cards Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1.3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildActionCard(
                    imagePath: "assets/icons/user home page/picup2.png",
                    label: 'Search for Load',
                    description: 'Take your loads with us in just few steps.',
                    onTap: () {
                      animetedNavigationPush(
                          const DriverFindLoadPage(), context);
                    },
                  ),
                  buildActionCard(
                    imagePath: "assets/icons/user home page/history.png",
                    label: 'Shipping History',
                    description: 'Check your previous shipping history.',
                    onTap: () {
                      animetedNavigationPush(
                          DriverShippingHistoryPage(), context);
                    },
                  ),
                  buildActionCard(
                    imagePath: "assets/icons/user home page/massage.png",
                    label: 'Chat',
                    description: 'Easily chat with the driver.',
                    onTap: () {
                      animetedNavigationPush(UserChatListPage(), context);
                    },
                  ),
                  buildActionCard(
                    imagePath: "assets/icons/user home page/support.png",
                    label: 'Support',
                    description: 'Take direct support from here.',
                    onTap: () {
                      animetedNavigationPush(
                          const DriverSupportPage(), context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Recently Tracking Section
            trakingDesign(number: "123-456-789", address: "Banasree, Dhaka"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildActionCard({
    required String imagePath,
    required String label,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColor.primaryColorLight,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        imagePath,
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                    child: commonText(
                      label,
                      isBold: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: commonText(description, overflow: TextOverflow.clip)),
            ],
          ),
        ),
      ),
    );
  }

  Widget trakingDesign({required String number, required String address}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.primaryColor, // Dark background color
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset("assets/icons/user home page/pickup.png"),
                const SizedBox(width: 10),
                commonText(
                  'Your load is being shipped',
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColor
                      .primaryColorLight, // Light background color for details section
                  borderRadius: BorderRadius.circular(16)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      commonText(
                        'BOL Number',
                        isBold: true,
                        size: 14,
                        color: Colors.black,
                      ),
                      commonText(
                        number,
                        size: 14,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      commonText(
                        'Address',
                        isBold: true,
                        size: 14,
                        color: Colors.black,
                      ),
                      commonText(
                        address,
                        size: 14,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
