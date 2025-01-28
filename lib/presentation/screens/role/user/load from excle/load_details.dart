import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/user/nearest_driver_controller/find_nearest_driver_controller.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/pending_shipping_model.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map2.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/assign_preferred_driver.dart';

class LoadDetailsScreen extends StatelessWidget {
  LoadDetailsScreen({super.key});

  static PendingShipmentModel? shippingItems;
  FindNearestDriverController nearestDriverController = Get.find<FindNearestDriverController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: commonText(
          'Load Details',
          size: 21,
          isBold: true,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionTile(
                enabled: true,
                title: commonText(
                  "Shipper's Information",
                  size: 16,
                  isBold: true,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: shipperInfo(),
                  ),
                ],
              ),
              ExpansionTile(
                title: commonText(
                  "Load Information",
                  size: 16,
                  isBold: true,
                ),
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: loadInfo()),
                ],
              ),
              ExpansionTile(
                title: commonText(
                  "Receiver Information",
                  size: 16,
                  isBold: true,
                ),
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: reciverInfo()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    commonText(
                      'Do you have preferred Driver?',
                      size: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // "No" Button
                        TextButton(
                          onPressed: () async {
                            await nearestDriverController
                                .findNearestDriver(
                                createdLoadId: "value.loadId");
                            animetedNavigationPush(
                                const UserMap2Page(), context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: commonText(
                            'No',
                            size: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 36),
                        // "Yes" Button
                        TextButton(
                          onPressed: () {
                            animetedNavigationPush(
                                AssignPreferredDriver(), context);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blueGrey.shade800,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: commonText(
                            'Yes',
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     commonText(
                    //       "Don't want to assign Driver now? ",
                    //       size: 14,
                    //     ),
                    //     GestureDetector(
                    //         onTap: () {
                    //           navController.currentIndex = 0;
                    //           slideNavigationPushAndRemoveUntil(const UserRootPage(), context);
                    //         },
                    //         child: commonText("Tap here", decoration: TextDecoration.underline, size: 14, fontWeight: FontWeight.bold, color: AppColor.primaryColor))
                    //   ],
                    // ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget shipperInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        
        const SizedBox(height: 10),
        _buildInfoRow("Shipper Name", " ${shippingItems?.shipperName}",
            "Shipper Phone", "${shippingItems?.shipperPhoneNumber}"),
        const SizedBox(height: 10),
        _buildInfoRow(
            "Shipper Email", "${shippingItems?.shipperEmail}", "Shipper Address", "${shippingItems?.shippingAddress}"),
        const SizedBox(
          height: 10,
        )
      ]),
    );
  }

  Widget loadInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        const SizedBox(height: 10),
        _buildLoadInfoSection(),
      ],
    );
  }

  Widget reciverInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(height: 10),
          _buildInfoRow(
              "Receiver Name", "${shippingItems?.receiverName}", "Receiver Phone", "${shippingItems?.receiverPhoneNumber}"),
          const SizedBox(height: 10),
          _buildInfoRow("Receiver Email", "${shippingItems?.receiverEmail}", "Receiver Address",
              "${shippingItems?.receivingAddress}"),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      String title1, String data1, String title2, String data2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText(title1, isBold: true),
              Row(
                children: [
                  Visibility(
                    visible: title1 == "Shipper Name",
                    child: const Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.yellow,
                    ),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: commonText(data1))),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText(title2, isBold: true),
              commonText(data2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText("Load Type", size: 14, isBold: true),
                    commonText("Dry Load", size: 14),
                    const SizedBox(height: 10),
                    commonText("Pickup", size: 14, isBold: true),
                    commonText("12-12-2024", size: 14),
                    commonText("Address: Rupatoli, Barishal",
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("Weight", size: 14, isBold: true),
                    commonText("120 kg", size: 14),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText("Trailer size", size: 14, isBold: true),
                    commonText("48-foot trailer—24 pallets", size: 14),
                    const SizedBox(height: 10),
                    commonText("Delivery", size: 14, isBold: true),
                    commonText("13-12-2024", size: 14),
                    commonText("Address: Banasree, Dhaka",
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("HazMat", size: 14, isBold: true),
                    commonText("Flammable Gas 2, Corrosive, Danger.", size: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // Delivery Instructions
          commonText("Delivery Instructions", isBold: true, size: 16),
          const SizedBox(height: 5),
          commonText("${shippingItems?.description}"),
        ],
      ),
    );
  }
}
