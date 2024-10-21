// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';

class DriverReAssignShipmentPage extends StatelessWidget {
  String phone = "123-456-789",
      name = "NR Shakib",
      email = "example@gmail.com",
      address = "Rupatoli, Barishal";

  DriverReAssignShipmentPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: commonText("Re-Assign Shipment", size: 21, isBold: true),
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
                        commonText(name),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Driver Phone", isBold: true),
                        commonText(phone),
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
                        commonText(email),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Driver Address", isBold: true),
                        commonText(address),
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
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText("Trailer size", isBold: true),
                        commonText("48-foot trailer."),
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
                        commonText("24 pallets."),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          "Dry Load",
                          size: 14,
                        ),
                        const SizedBox(height: 10),
                        commonText(
                          "Pickup",
                          size: 14,
                          isBold: true,
                        ),
                        commonText(
                          "12-12-2024",
                          size: 14,
                        ),
                        commonText("Address: Rupatoli, Barishal",
                            size: 14, fontWeight: FontWeight.w500),
                        const SizedBox(height: 10),
                        commonText(
                          "Weight",
                          size: 14,
                          isBold: true,
                        ),
                        commonText(
                          "120 kg",
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
                          "48-foot trailer—24 pallets",
                          size: 14,
                        ),
                        const SizedBox(height: 10),
                        commonText(
                          "Delivery",
                          size: 14,
                          isBold: true,
                        ),
                        commonText(
                          "13-12-2024",
                          size: 14,
                        ),
                        commonText("Address: Banasree, Dhaka",
                            size: 14, fontWeight: FontWeight.w500),
                        const SizedBox(height: 10),
                        commonText(
                          "HazMat",
                          size: 14,
                          isBold: true,
                        ),
                        commonText(
                          "Flammable Gas 2,\nCorrosive, Danger.",
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              commonText(
                "Current Location of Driver",
                size: 18,
                isBold: true,
              ),

              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: commonText("Padma Bridge, Mawa Ghat.",
                    size: 14, isBold: true),
              ),

              const SizedBox(height: 20),
              // Assign Load Buttons
              commonButton(
                borderRadious: 10,
                "Re-Assign",
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
