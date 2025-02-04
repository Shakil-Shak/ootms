// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/user/load_controller/assign_load_controller.dart';
import 'package:ootms/presentation/api/models/user_model/nearest_driver_model.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:url_launcher/url_launcher.dart';

class UserAssignLoadPage extends StatelessWidget {

  static NearestDriverModel loadDetails = NearestDriverModel();
  static String createdLoadId = "";
  AssignLoadController assignLoadController = Get.find<AssignLoadController>();

  UserAssignLoadPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText("Assign Load", size: 21, isBold: true),
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
                      commonText(loadDetails.fullName),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("Driver Phone", isBold: true),
                      commonText(loadDetails.phoneNumber),
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
                      commonText(loadDetails.email),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("Driver Address", isBold: true),
                      commonText(loadDetails.address),
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
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                _launchDialer(loadDetails.phoneNumber);
              },
              child: Container(
                width: Get.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                    color: AppColor.white,
                    border: Border.all(width: 1, color: Colors.black26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 3
                    )
                  ]
                ),
                child: const Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
              ),
            ),
            // Message Input with Call Button
            const SizedBox(height: 20),

            // Cancel and Assign Load Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: commonButton("Cancel",
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadious: 10,
                      color: const Color(0xFFDDDDDD),
                      textColor: AppColor.black),
                ),
                const SizedBox(width: 16),
                Obx(() =>
                    Expanded(
                      child: commonButton(
                        isLoading: assignLoadController.isLoading.value,
                        onTap: () {
                          assignLoadController.assignLoadDriver(context: context, driverId: loadDetails.id, loadId: createdLoadId);
                        },
                        borderRadious: 10,
                        "Assign Load",
                        textColor: Colors.white,
                      ),
                    )
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
