import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_image.dart';

import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map2.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_current%20_shipment_details.dart';
import 'package:provider/provider.dart';

class UserCurrentShipmentsPage extends StatelessWidget {
  final List<Map<String, dynamic>> loadRequests = [
    {
      'driverName': 'Ramandeep',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'California, USA',
      'to': 'Banasree, Dhaka',
      'driverImage':
          'https://images.mykhel.com/webp/images/cricket/players/1/13671.jpg',
    },
    {
      'driverName': 'Devid',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'Toronto, Canada',
      'to': 'Banasree, Dhaka',
      'driverImage':
          'https://i1.sndcdn.com/avatars-AXMZovCgD2mPbyQy-jqf2Tw-t240x240.jpg',
    },
  ];

  UserCurrentShipmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  commonText("John Doe's Load", size: 16, isBold: true),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                title: 'In transit at sorting center',
                location: 'Dhaka',
                dateTime: '2024-07-16 | 08:00 AM',
              ),
              shipmentStep(
                title: 'Dispatched',
                location: 'London',
                dateTime: '2024-07-15 | 02:30 PM',
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

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: commonText('Current Shipments', size: 21, isBold: true),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Consumer<ProfileController>(
          builder: (context, controller, child) {
            return Stack(
              children: [
                controller.isCurrentShip == false &&
                        controller.currentShipData.isEmpty
                    ? SizedBox(
                        height: Get.height,
                        child: Center(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/empty.png",
                              height: 80,
                              width: 80,
                            ),
                            commonText("No Current Shipment Found",
                                color: AppColor.black, size: 12),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        )),
                      )
                    : Column(
                        children: [
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: FittedBox(
                                    child: commonButton(
                                      "Track",
                                      width: 120,
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(20)),
                                          ),
                                          builder: (context) {
                                            return DraggableScrollableSheet(
                                              initialChildSize: 0.8,
                                              expand: false,
                                              builder:
                                                  (context, scrollController) {
                                                return Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width, // Full width
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.9, // 70% of screen height
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20)),
                                                  ),
                                                  child: SingleChildScrollView(
                                                    controller:
                                                        scrollController,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        commonText(
                                                            "Shipping Details",
                                                            size: 16,
                                                            isBold: true),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        loadDetailsCard(),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            commonText(
                                                                "Live tracking",
                                                                size: 18,
                                                                isBold: true),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                                animetedNavigationPush(
                                                                    const UserMap2Page(),
                                                                    context);
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8),
                                                                    border: Border.all(
                                                                        width:
                                                                            1)),
                                                                child: commonText(
                                                                    "Track on map",
                                                                    color: AppColor
                                                                        .black),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Card(
                                                          elevation: 5,
                                                          color: AppColor.white,
                                                          child: SizedBox(
                                                            height: 240,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                commonText(
                                                                    "Map",
                                                                    size: 24,
                                                                    isBold:
                                                                        true),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                              padding: const EdgeInsets.all(16.0),
                              itemCount: controller.currentShipData.length,
                              itemBuilder: (context, index) {
                                var data = controller.currentShipData[index];

                                return InkWell(
                                  onTap: () {
                                    animetedNavigationPush(
                                        UserCurrentShipmentDetailsPage(
                                          shipmentDetails: data,
                                        ),
                                        context);
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                          height: 60,
                                          width: 60,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                          child: CommonImage(
                                            imageSrc: ApiPaths.baseUrl +
                                                data.driver.image,
                                            imageType: ImageType.network,
                                            fill: BoxFit.cover,
                                            size: 40,
                                            borderRadius: 100,
                                          )),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            commonText(data.driver.fullName,
                                                size: 16, isBold: true),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            commonText(
                                                "${data.load.trailerSize} foot trailer - ${data.load.palletSpace} Pallets.",
                                                size: 14),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/arrow_up.png",
                                                      ),
                                                      const SizedBox(width: 4),
                                                      SizedBox(
                                                          width: 100,
                                                          child: commonText(
                                                            maxLines: 1,
                                                            data.load
                                                                .shippingAddress,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Transform.rotate(
                                                          angle: pi,
                                                          child: Image.asset(
                                                              "assets/icons/arrow_up.png")),
                                                      const SizedBox(width: 4),
                                                      SizedBox(
                                                          width: 100,
                                                          child: commonText(
                                                            maxLines: 1,
                                                            data.load
                                                                .receivingAddress,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                // Loading overlay
                if (controller.isCurrentShip)
                  const Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.primaryColor),
                      ),
                    ),
                  ),
              ],
            );
          },
        ));
  }
}
