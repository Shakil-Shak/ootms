// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_map2.dart';

class DriverCurrentShipmentDetailsPage extends StatelessWidget {
  String shipperPhone = "123-456-789",
      shipperName = "NR Shakib",
      shipperRating = "4.5",
      shipperEmail = "example@gmail.com",
      shipperAddress = "Rupatoli, Barishal",
      reciverName = "MD. Shihabul Islam",
      reciverPhone = "123-456-789",
      reciverEmail = "example@gmail.com",
      reciverAddress = "Banasree, Dhaka",
      deliveryInstructions =
          "Lorem ipsum dolor sit amet consectetur. Blandit auctor sit scelerisque ultricies.",
      description =
          "Lorem ipsum dolor sit amet consectetur. Blandit auctor sit scelerisque ultricies.";

  DriverCurrentShipmentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: commonText("Current Shipment", size: 21, isBold: true),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipper's Information
            commonText("Shipper's Information", isBold: true, size: 18),
            const Divider(),
            const SizedBox(height: 10),
            _buildInfoRow("Shipper Name", " ${shipperRating} ${shipperName}",
                "Shipper Phone", shipperPhone),
            const SizedBox(height: 10),
            _buildInfoRow("Shipper Email", shipperEmail, "Shipper Address",
                shipperAddress),

            const SizedBox(height: 20),

            // Load Information Section
            commonText("Load Information", isBold: true, size: 18),
            const Divider(),
            const SizedBox(height: 10),
            _buildLoadInfoSection(),

            const SizedBox(height: 20),

            // Receiver's Information Section
            commonText("Receiver's Information", isBold: true, size: 18),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildInfoRow("Receiver Name", reciverName, "Receiver Phone",
                      reciverPhone),
                  const SizedBox(height: 10),
                  _buildInfoRow("Receiver Email", reciverEmail,
                      "Receiver Address", reciverAddress),

                  const SizedBox(height: 10),

                  // Delivery Instructions
                  commonText("Delivery Instructions", isBold: true, size: 16),
                  const SizedBox(height: 5),
                  commonText(deliveryInstructions),

                  const SizedBox(height: 30),
                ],
              ),
            ),

            // Buttons at the bottom
            commonButton(
              "Go To The Map",
              borderRadious: 10,
              onTap: () {
                animetedNavigationPush(DriverMap2Page(), context);
              },
            ),
            const SizedBox(height: 16),
            commonButton(
              "Technical Issue",
              borderRadious: 10,
              color: AppColor.primaryColorLight.withOpacity(0.7),
              textColor: Colors.black,
            ),
          ],
        ),
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
                    child: Icon(
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
              SizedBox(
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
          SizedBox(
            height: 8,
          ),
          // Delivery Instructions
          commonText("Delivery Instructions", isBold: true, size: 16),
          const SizedBox(height: 5),
          commonText(description),
        ],
      ),
    );
  }
}
