
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/create_load_map_controller.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/live_tracking_controller.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_image.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map2.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map_with_polyline.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/create_load.dart';
import 'package:ootms/presentation/screens/role/user/notification/user_all_notifications.dart';
import 'package:ootms/presentation/screens/role/user/chat/user_chat_list.dart';
import 'package:ootms/presentation/screens/role/user/create_load/user_create_load.dart';
import 'package:ootms/presentation/screens/role/user/home/user_drawer.dart';
import 'package:ootms/presentation/screens/role/user/home/user_set_location.dart';
import 'package:ootms/presentation/screens/role/user/home/user_support.dart';
import 'package:provider/provider.dart';

import '../../../../api/controllers/common/bottom_nav_controller.dart';
import '../../../../api/controllers/user/shipping_controller/shipping_history_controller.dart';
import '../shipping/user_shipping_history.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  static LocationPermission? permission;

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final BottomNavController navController = Get.put(BottomNavController());

  CreateLoadMapController createLoadMapController = Get.find<CreateLoadMapController>();
  LiveTrackingController liveTrackingController = Get.find<LiveTrackingController>();

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      animetedNavigationPush(
                          const UserCreateLoadPage(), context);
                    },
                    child: commonText("Create Load from Form", isBold: true)),
                const Divider(),
                InkWell(
                    onTap: () {
                      animetedNavigationPush(const Create_load_XL(), context);
                    },
                    child: commonText("Create Load from Excel Sheet",
                        isBold: true)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileController>(context, listen: false)
          .getLoadRequestData(context: context, callFromHome: true);
      Provider.of<ProfileController>(context, listen: false)
          .getCurrentLocation();
      Provider.of<ProfileController>(context, listen: false)
          .getLoadRequestData(context: context, callFromHome: true);
      Provider.of<ShippinfHistoryController>(context, listen: false)
          .getShippingHistoryData(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: userCustomDrawer(context),
      backgroundColor: AppColor.white,
      body: Consumer<ProfileController>(builder: (context, controller, child) {
        return SingleChildScrollView(
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
                            image:
                                AssetImage('assets/images/userHomePagebg.png'),
                            // Replace with your image asset
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
                              // Menu icon
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
                              // InkWell(
                              //   onTap: () {
                              //     animetedNavigationPush(
                              //         UserAllNotificationsPage(), context);
                              //   },
                              //   child: Image.asset(
                              //       "assets/icons/user home page/notify.png"),
                              // ),
                              InkWell(
                                onTap: () {
                                  animetedNavigationPush(
                                      UserAllNotificationsPage(), context);
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
                                  navController.valueIncrease();
                                  // animetedNavigationPush(
                                  //     const UserProfile(), context);
                                },
                                child: const CircleAvatar(
                                  backgroundColor: AppColor.black,
                                  backgroundImage: AssetImage(
                                      'assets/icons/profile_icon_2.png'),
                                  // Replace with your image asset
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
                                  const UserSetLocationPage(), context);
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
                                            controller.currentLocation.isEmpty? "Current Address Loading..." :
                                            controller.currentLocation,
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
                              Expanded(
                                child: TextField(
                                  controller: liveTrackingController.bolTextController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter bill of lading number',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              //========================================================================track
                              Obx(() => Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 8),
                                child: FittedBox(
                                  child: commonButton(
                                    isLoading: liveTrackingController.isLoading.value,
                                    "Track",
                                    width: 120,
                                    onTap: () async {
                                      if(liveTrackingController.bolTextController.text != ""){
                                        await liveTrackingController.findTrackingLoad();
                                        trackBottomSheet();
                                      }else{
                                       showCommonSnackbar(context, "Please enter BOL number", isError: true);
                                      }
                                    },
                                  ),
                                ),
                              ),)
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
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildActionCard(
                      imagePath: "assets/icons/user home page/picup2.png",
                      label: 'Create Load',
                      description:
                          'Send your loads with us in just a few steps.',
                      onTap: () {
                        _showCustomDialog(context);
                      },
                    ),
                    Consumer<ShippinfHistoryController>(
                        builder: (context, controller, _) {
                      return buildActionCard(
                        imagePath: "assets/icons/user home page/history.png",
                        label: 'Shipping History',
                        description: 'Check your previous shipping history.',
                        onTap: () {
                          controller.getShippingHistoryData(context: context);
                          animetedNavigationPush(
                              UserShippingHistoryPage(), context);
                        },
                      );
                    }),
                    //===========================================================chat card
                    buildActionCard(
                      imagePath: "assets/icons/user home page/massage.png",
                      label: 'Chat',
                      description: 'Easily chat with the driver.',
                      onTap: () {
                        controller.getCurrentShipData(
                            context: context);
                        animetedNavigationPush(UserChatListPage(), context);
                      },
                    ),
                    //==========================================================support card
                    buildActionCard(
                      imagePath: "assets/icons/user home page/support.png",
                      label: 'Support',
                      description: 'Take direct support from here.',
                      onTap: () {
                        animetedNavigationPush(UserSupportPage(), context);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: commonText("Recently Tracking", isBold: true, size: 16),
              ),
              // Recently Tracking Section
              Consumer<ShippinfHistoryController>(
                  builder: (context, controller, _) {
                return controller.isLoading? SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                    child: Center(child: CircularProgressIndicator())) : controller.shippingHistoryData.isEmpty? Center(
                      child: Column(
                        children: [
                          SizedBox(height: 40),
                          CommonImage(imageSrc: "assets/images/empty.png", imageType: ImageType.png, height: 60, width: 60,),
                          commonText("No tracking found")
                        ],
                      ),
                    ) : trakingDesign(
                    number: controller.shippingHistoryData.first.load.bolNo, address: controller.shippingHistoryData.first.load.receivingAddress);
              }),
              const SizedBox(height: 20),
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
          ),
        );
      }),
    );
  }

//===============================track modal bottom sheet
  trackBottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          // Full width
          height: 700,
          // 90% of screen height
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText("Shipping Details", size: 16, isBold: true),
                const SizedBox(height: 10),
                loadDetailsCard(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonText("Live tracking", size: 18, isBold: true),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        animetedNavigationPush(const UserMapWithPolyline(), context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1),
                        ),
                        child: commonText("Track on map", color: AppColor.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Card(
                  elevation: 5,
                  color: AppColor.white,
                  clipBehavior: Clip.antiAlias, // Ensure the map is not clipped unnecessarily
                  child: SizedBox(
                    height: 240,
                    child: Obx(
                          () => Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CustomMapController.instance.initialCameraPosition,
                            compassEnabled: true,
                            myLocationEnabled: true,
                            myLocationButtonEnabled: true,
                            zoomControlsEnabled: true,
                            scrollGesturesEnabled: true,
                            zoomGesturesEnabled: true,
                            rotateGesturesEnabled: true,
                            markers: Set<Marker>.from(CustomMapController.instance.marker),
                            onMapCreated: (GoogleMapController controller) {
                              CustomMapController.instance.googleMapController.complete(controller);
                            },
                            polylines: Set<Polyline>.from(CustomMapController.instance.polyLines),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget loadDetailsCard() {
    return Card(
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Load details and status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText("", size: 16, isBold: true),
                const SizedBox(height: 4),
                commonText(
                  '7421477-475645',
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
            const Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText(
                              'From',
                              color: Colors.grey,
                            ),
                            commonText('Rupatoli, Barishal',
                                size: 12, isBold: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText(
                              'To',
                              color: Colors.grey,
                            ),
                            commonText('Banasree, Dhaka',
                                size: 12, isBold: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: commonText(
                'In transit',
                size: 14,
                isBold: true,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 10),

            // Shipment progress

            shipmentStep(
              title: 'Dispatched',
              location: 'London',
              dateTime: '2024-07-15 | 02:30 PM',
            ),
            shipmentStep(
              title: 'In transit at sorting center',
              location: 'Dhaka',
              dateTime: '2024-07-16 | 08:00 AM',
            ),
            shipmentStep(
              title: 'Picked up',
              location: 'Barishal',
              dateTime: '2024-07-14 | 10:00 AM',
            ),
          ],
        ),
      ),
    );
  }

  Widget shipmentStep(
      {required String title,
      required String location,
      required String dateTime}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.red, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText(title, size: 14, isBold: true),
                const SizedBox(height: 4),
                Row(
                  children: [
                    commonText(
                      location,
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 5),
                    commonText(
                      '|',
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 5),
                    commonText(
                      dateTime,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
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
              const SizedBox(height: 5),
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
                  color: AppColor.primaryColorLight,
                  // Light background color for details section
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