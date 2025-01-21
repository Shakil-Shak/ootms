import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/Driver/equipment_controller/equipment_controller.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/models/driver_model/equipment_model.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/find_load/driver_find_load.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_drawer.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_set_location.dart';
import 'package:ootms/presentation/screens/role/driver/notification/driver_all_notifications.dart';
import 'package:ootms/presentation/screens/role/driver/profile/driver_profile.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_shipping_history.dart';
import 'package:ootms/presentation/screens/role/user/chat/user_chat_list.dart';

import '../../../../components/common_button.dart';
import '../../../../components/common_textfield.dart';
import '../../user/home/user_support.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  CustomMapController customMapController = Get.find<CustomMapController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EquipmentController equipmentController =
      Get.find<EquipmentController>();

  bool switchValue = false;
  String duty = "On-Duty";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() {
      customMapController.getCurrentLocation();
    },);
  }

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
                          image: AssetImage('assets/images/userHomePagebg.png'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black38, BlendMode.multiply)),
                    ),
                  ),
                  Obx(() => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
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
                                commonText(duty, color: Colors.white, size: 16),
                                const SizedBox(width: 10),
                                Switch(
                                  value: switchValue,
                                  onChanged: (value) {
                                    if (switchValue == false) {
                                      equipmentController.getEquipmentData();
                                      showOnDutyDialog(context);
                                    }

                                    // setState(() {
                                    //   switchValue = value;
                                    //   switchValue == true
                                    //       ? duty = "On-Duty"
                                    //       : duty = "Off-Duty";
                                    // });
                                  },
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
                                        Expanded(
                                          child: commonText(
                                              customMapController
                                                  .userCurrentLocation.value,
                                              size: 16,
                                              color: AppColor.white),
                                        )
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
                        ],
                      ))
                ],
              ),
            ),

            // const SizedBox(height: 4), // For spacing after the header

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
                      // animetedNavigationPush(DriverSupportPage(), context);

                      animetedNavigationPush(UserSupportPage(), context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: commonText("Shipping History", isBold: true, size: 16),
            ),
            // Recently Tracking Section
            trakingDesign(number: "123-456-789", address: "Banasree, Dhaka"),
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

  //=============================================================on duty dialog
  void showOnDutyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          content: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     IconButton(
                //       icon: const Icon(Icons.close),
                //       onPressed: () {
                //         Navigator.of(context).pop();
                //       },
                //     ),
                //   ],
                // ),
                Center(
                  child: commonText(
                      'Select your Truck and Trailer before you start the ride',
                      size: 16,
                      isBold: true),
                ),
                const SizedBox(height: 16),
                commonTextfieldWithTitle(
                  readOnly: true,
                  "Truck Id",
                  TextEditingController(),
                  suffinxIcon: truckIdDropdown(context),
                  hintText: "Select Truck Id",
                ),
                const SizedBox(height: 10),
                commonTextfieldWithTitle(
                  readOnly: true,
                  "Trailer Id",
                  TextEditingController(),
                  suffinxIcon: trailerIdDropdown(context),
                  hintText: "Select Trailer Id",
                ),
                const SizedBox(height: 10),
                commonButton(
                  "Start",
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
//=====================================================================truck details popup
Widget truckIdDropdown(BuildContext parentContext) {
  String truckId = ""; // Variable to store the selected truck ID
  // List of items to display in the menu
  List<PopupMenuEntry<String>> truckIdList = [];

  for (var i = 0; i < equipmentController.truckList.length; i++) {
    var truckData = equipmentController.equipmentData.truck[i];
    truckIdList.add(
      PopupMenuItem<String>(
        value: truckData.id, // Assign truckId as the value
        child: Container(
          width: 300,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(truckData.truckNumber),
              Text(truckData.id),
            ],
          ),
        ),
      ),
    );
  }
  return GestureDetector(
    onTap: () {
      RenderBox renderBox = parentContext.findRenderObject() as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      Size size = renderBox.size;

      double availableHeight = MediaQuery.of(parentContext).size.height;

      double iconPositionTop = offset.dy;
      double iconPositionBottom = availableHeight - (offset.dy + size.height);

      double topPosition = iconPositionBottom > 200
          ? offset.dy + size.height
          : offset.dy - 200;

      double bottomPosition = iconPositionBottom > 200
          ? -offset.dy - size.height
          : availableHeight - offset.dy;

      // Show a ListView in a Dialog
      showMenu<String>(
        context: parentContext,
        position: RelativeRect.fromLTRB(
            offset.dx + size.width, topPosition, 0, bottomPosition),
        items: truckIdList,
        elevation: 8.0,
      ).then((value) {
        if (value != null) {
          truckId = value;
          print("Selected Truck ID:==================================== $truckId"); // Debugging
        }
      });
    },
    child: const Icon(Icons.keyboard_arrow_down),
  );
}

//=====================================================================trailer details popup
Widget trailerIdDropdown(BuildContext parentContext) {
  String trailerId = "";
  List<PopupMenuEntry<String>> trailerIdList = [];

  for (var i = 0; i < equipmentController.trailerList.length; i++) {
    var trailerData = equipmentController.equipmentData.trailer[i];
    trailerIdList.add(
      PopupMenuItem<String>(
        value: trailerData.id, 
        child: Container(
          width: 300,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${trailerData.trailerSize.toString()}-Foot Trailer, ${trailerData.palletSpace.toString()}-Pallets"),
              Text(trailerData.id),
            ],
          ),
        ),
      ),
    );
  }
  return GestureDetector(
    onTap: () {
      RenderBox renderBox = parentContext.findRenderObject() as RenderBox;
      Offset offset = renderBox.localToGlobal(Offset.zero);
      Size size = renderBox.size;

      double availableHeight = MediaQuery.of(parentContext).size.height;

      double iconPositionTop = offset.dy;
      double iconPositionBottom = availableHeight - (offset.dy + size.height);

      double topPosition = iconPositionBottom > 200
          ? offset.dy + size.height
          : offset.dy - 200;

      double bottomPosition = iconPositionBottom > 200
          ? -offset.dy - size.height
          : availableHeight - offset.dy;

      // Show a ListView in a Dialog
      showMenu<String>(
        context: parentContext,
        position: RelativeRect.fromLTRB(
            offset.dx + size.width, topPosition, 0, bottomPosition),
        items: trailerIdList,
        elevation: 8.0,
      ).then((value) {
        if (value != null) {
          trailerId = value;
        }
      });
    },
    child: const Icon(Icons.keyboard_arrow_down),
  );
}



}
