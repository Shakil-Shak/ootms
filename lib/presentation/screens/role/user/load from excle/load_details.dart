import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/user/nearest_driver_controller/find_nearest_driver_controller.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/pending_shipping_model.dart';
import 'package:ootms/presentation/components/common_button.dart';
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
              SizedBox(height: 20,),
              commonButton(
                "Assign Load",
                // isLoading: value.isLoading,
                onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) {
                          return Padding(
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
                              ],
                            ),
                          );
                        },
                      );
                  // animetedNavigationPush(const UserMap3Page(), context);
                },
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(
                      "Load Type",
                      size: 14,
                      isBold: true,
                    ),
                    commonText(
                      "${shippingItems?.loadType}",
                      size: 14,
                    ),
                    const SizedBox(height: 10),
                    commonText(
                      "Pickup",
                      size: 14,
                      isBold: true,
                    ),
                    commonText(
                      OtherHelper.getDate(
                          serverDate: "${shippingItems?.pickupDate.toString()}"),
                      size: 14,
                    ),
                    commonText("Address: ${shippingItems?.shippingAddress}",
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText(
                      "Weight",
                      size: 14,
                      isBold: true,
                    ),
                    commonText(
                      "${shippingItems?.weight.toString()}",
                      size: 14,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(
                      "Trailer size",
                      size: 14,
                      isBold: true,
                    ),
                    commonText(
                      "${shippingItems?.trailerSize}-foot trailer—${shippingItems?.palletSpace} pallets",
                      size: 14,
                    ),
                    const SizedBox(height: 10),
                    commonText(
                      "Delivery",
                      size: 14,
                      isBold: true,
                    ),
                    commonText(
                      OtherHelper.getDate(
                          serverDate: "${shippingItems?.deliveryDate.toString()}"
                      ),
                      size: 14,
                    ),
                    commonText("${shippingItems?.receivingAddress}",
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText(
                      "HazMat",
                      size: 14,
                      isBold: true,
                    ),
                    // ListView.builder(
                    //   itemCount: shippingItems?.hazmat.length,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   shrinkWrap: true,
                    //   itemBuilder: (context, index) {
                    //     return commonText("${shippingItems?.hazmat[index]},",
                    //         size: 14);
                    //   },
                    // )
                  ],
                ),
              ),
            ],
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          //           commonText("Load Type", size: 14, isBold: true),
          //           commonText("${shippingItems?.loadType}", size: 14),
          //           const SizedBox(height: 10),
          //           commonText("Pickup", size: 14, isBold: true),
          //           commonText("${shippingItems?.loadType}", size: 14),
          //           commonText("Address: ${shippingItems?.shippingAddress}",
          //               size: 14, fontWeight: FontWeight.w500),
          //           const SizedBox(height: 10),
          //           commonText("Weight", size: 14, isBold: true),
          //           commonText("120 kg", size: 14),
          //         ],
          //       ),
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           commonText("Trailer size", size: 14, isBold: true),
          //           commonText("48-foot trailer—24 pallets", size: 14),
          //           const SizedBox(height: 10),
          //           commonText("Delivery", size: 14, isBold: true),
          //           commonText("13-12-2024", size: 14),
          //           commonText("Address: Banasree, Dhaka",
          //               size: 14, fontWeight: FontWeight.w500),
          //           const SizedBox(height: 10),
          //           commonText("HazMat", size: 14, isBold: true),
          //           commonText("Flammable Gas 2, Corrosive, Danger.", size: 14),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(
            height: 8,
          ),
          // Delivery Instructions
          commonText("Delivery Instructions", isBold: true, size: 16),
          const SizedBox(height: 5),
          commonText("${shippingItems?.deliveryInstruction}"),
        ],
      ),
    );
  }
}
