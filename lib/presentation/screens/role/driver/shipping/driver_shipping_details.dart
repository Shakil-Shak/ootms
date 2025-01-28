import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/models/driver_model/driver_shiphistory_model.dart';
import 'package:ootms/presentation/components/common_text.dart';

import '../../../../api/models/user_model/shiping_model/shipping_history_model.dart';

class DriverShippingDetailsPage extends StatelessWidget {
  DriverShipHistoryModel data;
  DriverShippingDetailsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        centerTitle: true,
        title: commonText("Shipping Details", size: 21, isBold: true),
        backgroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipping ID with copy button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText("Shipping ID\n${data.shippingId}",
                      size: 16, isBold: true),
                  // IconButton(
                  //   icon: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [const Icon(Icons.copy), commonText("Copy")],
                  //   ),
                  //   onPressed: () {
                  //     // Copy to clipboard
                  //   },
                  // ),
                ],
              ),
            ),
            const Divider(thickness: 6),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Trip Info", size: 16, isBold: true),
                  const SizedBox(height: 16),
                  commonText(
                    OtherHelper.getDate(
                        serverDate: data.load.deliveryDate.toString()),
                    size: 14,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/arrow_up.png"),
                      const SizedBox(width: 4),
                      Expanded(child: commonText(data.load.shippingAddress)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/arrow_up.png"),
                      const SizedBox(width: 4),
                      Expanded(child: commonText(data.load.receivingAddress)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(thickness: 6),
            // Driver Info

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Receiver Info", isBold: true, size: 18),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Receiver Name", isBold: true),
                            commonText(data.load.receiverName),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Receiver Phone", isBold: true),
                            commonText(data.load.receiverPhoneNumber),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Receiver Email", isBold: true),
                            commonText(data.load.receiverEmail),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Receiver Address", isBold: true),
                            commonText(data.load.receivingAddress),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const Divider(thickness: 6),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Shipper’s Info", isBold: true, size: 18),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Shipper Name", isBold: true),
                            commonText(data.load.shipperName),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Shipper Phone", isBold: true),
                            commonText(data.load.shipperPhoneNumber),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Shipper Email", isBold: true),
                            commonText(data.load.shipperEmail),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Shipper Address", isBold: true),
                            commonText(data.load.shippingAddress),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const Divider(thickness: 6),
            // Load Information
            loadInfo(),
            const SizedBox(height: 16),
            const Divider(thickness: 6, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget loadInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonText(
            "Load Information",
            size: 18,
            isBold: true,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(
                      "Load Type",
                      size: 14,
                      isBold: true,
                    ),
                    commonText(
                      data.load.loadType,
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
                          serverDate: data.load.pickupDate.toString()),
                      size: 14,
                    ),
                    commonText("Address: ${data.load.shippingAddress}",
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText(
                      "Weight",
                      size: 14,
                      isBold: true,
                    ),
                    commonText(
                      data.load.weight.toString(),
                      size: 14,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(
                      "Trailer size",
                      size: 14,
                      isBold: true,
                    ),
                    commonText(
                      "${data.load.trailerSize}-foot trailer—${data.load.palletSpace} pallets",
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
                          serverDate: data.load.deliveryDate.toString()),
                      size: 14,
                    ),
                    commonText(data.load.receivingAddress,
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText(
                      "HazMat",
                      size: 14,
                      isBold: true,
                    ),
                    ListView.builder(
                      itemCount: data.load.hazmat.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return commonText("${data.load.hazmat[index]},",
                            size: 14);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
