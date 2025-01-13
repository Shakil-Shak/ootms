import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/current_shiping_model.dart';
import 'package:ootms/presentation/api/models/user_registration.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';

class UserCurrentShipmentDetailsPage extends StatelessWidget {
  var shipmentDetails;


  UserCurrentShipmentDetailsPage({super.key, required this.shipmentDetails});
  @override
  Widget build(BuildContext context) {
    print(
        "===========================================details $shipmentDetails");
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: commonText("Current Shipment", size: 21, isBold: true),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Driver's Information Section
              commonText("Driver's Information", isBold: true, size: 18),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Driver Name", isBold: true),
                        commonText(shipmentDetails.driver.fullName),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Driver Phone", isBold: true),
                        commonText(shipmentDetails.driver.phoneNumber),
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
                        commonText("Driver Email", isBold: true),
                        commonText(shipmentDetails.driver.email),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Driver Address", isBold: true),
                        commonText(shipmentDetails.load.shippingAddress),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Truck Information Section
              commonText("Truck Information", isBold: true, size: 18),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Truck Number", isBold: true),
                        commonText("DHK METRO HA 64-8549"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Trailer size", isBold: true),
                        commonText(
                            "${shipmentDetails.load.trailerSize}-foot trailer."),
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
                        commonText("Pallet Spaces", isBold: true),
                        commonText(
                            "${shipmentDetails.load.palletSpace} pallets."),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Availability", isBold: true),
                        commonText("Fully Available."),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              commonText(
                "Load Information",
                size: 18,
                isBold: true,
              ),

              const Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              shipmentDetails.load.loadType,
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
                                  serverDate: shipmentDetails.load.pickupDate
                                      .toString()),
                              size: 14,
                            ),
                            commonText(
                                "Address: ${shipmentDetails.load.shippingAddress}",
                                size: 14,
                                fontWeight: FontWeight.w500),
                            const SizedBox(height: 10),
                            commonText(
                              "Weight",
                              size: 14,
                              isBold: true,
                            ),
                            commonText(
                              "${shipmentDetails.load.weight.toString()} Kg",
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
                              "${shipmentDetails.load.trailerSize}-foot trailer—24 pallets",
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
                                  serverDate: shipmentDetails.load.deliveryDate
                                      .toString()),
                              size: 14,
                            ),
                            commonText(
                                "Address: ${shipmentDetails.load.receivingAddress}",
                                size: 14,
                                fontWeight: FontWeight.w500),
                            const SizedBox(height: 10),
                            commonText(
                              "HazMat",
                              size: 14,
                              isBold: true,
                            ),
                            Wrap(
                              children: List.generate(shipmentDetails.load.hazmat.length, (index) {
                                return commonText(
                                  "${shipmentDetails.load.hazmat[index]}, ",
                                  size: 14,
                                );
                              },),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Cancel and Assign Load Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: commonButton("Track On Map",
                        borderRadious: 10,
                        color: AppColor.primaryColorLight,
                        textColor: AppColor.black),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonButton(
                      borderRadious: 10,
                      "Re-Assign",
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
