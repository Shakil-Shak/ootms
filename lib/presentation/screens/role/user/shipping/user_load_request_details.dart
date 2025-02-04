// ignore_for_file: must_be_immutable

import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:url_launcher/url_launcher.dart';

class UserLoadRequestDetailsPage extends StatelessWidget {
  String driverName;
  String driverPhone;
  String driverEmail;
  String driverAddress;
  String truckNumber;
  String trailerSize;
  String palletSpaces;
  String availability;


  UserLoadRequestDetailsPage({
    super.key,
    required this.driverName,
    required this.driverPhone,
    required this.driverAddress,
    required this.driverEmail,
    required this.truckNumber,
    required this.trailerSize,
    required this.palletSpaces,
    required this.availability,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText("Load Request", size: 21, isBold: true),
        centerTitle: true,
      ),
      body: Padding(
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
                      commonText(driverName),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("Driver Phone", isBold: true),
                      commonText(driverPhone),
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
                      commonText(driverEmail),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("Driver Address", isBold: true),
                      commonText(driverAddress),
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
                      commonText(truckNumber),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("Trailer size", isBold: true),
                      commonText(trailerSize),
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
                      commonText("$palletSpaces pallets."),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("Availability", isBold: true),
                      commonText(availability),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Message Input with Call Button
            Row(
              children: [
                // Message input field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(
                            Icons.message,
                            color: AppColor.black,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Send a message",
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Phone icon button
                InkWell(
                  onTap: () {
                    _launchDialer(driverPhone);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        shape: BoxShape.circle,
                        border: Border.all(width: 1)),
                    child: const Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Cancel and Assign Load Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: commonButton("Cancel",
                      borderRadious: 10,
                      color: const Color(0xFFDDDDDD),
                      textColor: AppColor.black),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: commonButton(
                    borderRadious: 10,
                    "Assign Load",
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
