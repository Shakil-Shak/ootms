
// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/common/load_details_controller.dart';
import 'package:ootms/presentation/api/models/load_details_model.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:url_launcher/url_launcher.dart';

class NotiLoadRequestDetails extends StatelessWidget {
  NotiLoadRequestDetails({
    super.key,
    required this.shipperPhone,
    required this.shipperName,
    required this.shipperRating,
    required this.shipperEmail,
    required this.shipperAddress,
    required this.reciverName,
    required this.reciverPhone,
    required this.reciverEmail,
    required this.reciverAddress,
    required this.description,
    required this.deliveryInstructions,
    required this.loadType,
    required this.trailerSize,
    required this.weight,
    required this.hazmat,
    required this.pickupDate,
    required this.deliveryDate,
    required this.rating,
    required this.loadReqId,
    required this.index,
  });

  static String loadId = "";

  LoadDetailsController loadDetailsController =
      Get.find<LoadDetailsController>();

  String shipperPhone;
  String shipperName;
  String shipperRating;
  String shipperEmail;
  String shipperAddress;
  String reciverName;
  String reciverPhone;
  String reciverEmail;
  String reciverAddress;
  String deliveryInstructions;
  String description;
  String loadType;
  String trailerSize;
  String pickupDate;
  String deliveryDate;
  String weight;
  List hazmat;
  String rating;
  String loadReqId;
  int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: commonText("Load Request", size: 21, isBold: true),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: GetBuilder<LoadDetailsController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Shipper's Information
                commonText("Shipper's Information", isBold: true, size: 18),
                const Divider(),
                const SizedBox(height: 10),
                _buildInfoRow("Shipper Name", " ${rating+" "+shipperName}", "Shipper Phone",
                    shipperPhone),
                const SizedBox(height: 10),
                _buildInfoRow("Shipper Email", shipperEmail, "Shipper Address",
                    shipperAddress),

                const SizedBox(height: 20),

                // Load Information Section
                commonText("Load Information", isBold: true, size: 18),
                const Divider(),
                const SizedBox(height: 10),
                //==================================================================load information
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonText("Load Type", size: 14, isBold: true),
                                commonText(loadType, size: 14),
                                const SizedBox(height: 10),
                                commonText("Pickup", size: 14, isBold: true),
                                commonText(pickupDate, size: 14),
                                commonText("Address: $reciverAddress",
                                    size: 14, fontWeight: FontWeight.w500),
                                const SizedBox(height: 10),
                                commonText("Weight", size: 14, isBold: true),
                                commonText(weight.toString(), size: 14),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                commonText("Trailer size",
                                    size: 14, isBold: true),
                                commonText(trailerSize, size: 14),
                                const SizedBox(height: 10),
                                commonText("Delivery", size: 14, isBold: true),
                                commonText(deliveryDate, size: 14),
                                commonText("Address: $shipperAddress",
                                    size: 14, fontWeight: FontWeight.w500),
                                const SizedBox(height: 10),
                                commonText("HazMat", size: 14, isBold: true),
                                Row(
                                  children: List.generate(
                                    hazmat.length,
                                    (index) {
                                      return commonText(hazmat[index],
                                          size: 14);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // Delivery Instructions
                      commonText("Delivery Instructions",
                          isBold: true, size: 16),
                      const SizedBox(height: 5),
                      commonText(deliveryInstructions),
                    ],
                  ),
                ),

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
                      _buildInfoRow("Receiver Name", reciverName,
                          "Receiver Phone", reciverPhone),
                      const SizedBox(height: 10),
                      _buildInfoRow("Receiver Email", reciverEmail,
                          "Receiver Address", reciverAddress),

                      const SizedBox(height: 10),

                      // Delivery Instructions
                      commonText("Description", isBold: true, size: 16),
                      const SizedBox(height: 5),
                      commonText(description),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),

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
                        _launchDialer(shipperPhone);
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
                        onTap: () {
              
                        },
                        borderRadious: 10,
                        "Accept Load",
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
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

  // Widget _buildLoadInfoSection(Query loadInfo) {
  //   return ;
  // }

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
