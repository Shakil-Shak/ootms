// ignore_for_file: must_be_immutable

import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool isMyLoad;


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
    required this.isMyLoad
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
            InkWell(
              onTap: () {
                _launchDialer(driverPhone);
              },
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3,
                      spreadRadius: 2
                    )],
                    border: Border.all(width: 1, color: Colors.black38)),
                child: const Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Cancel and Assign Load Buttons
            !isMyLoad? Row(
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
            ) : const SizedBox.shrink(),
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
