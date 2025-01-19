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

class LoadNodificationDetails extends StatefulWidget {

  LoadNodificationDetails({super.key});

  static String loadId = "";

  @override
  State<LoadNodificationDetails> createState() => _LoadNodificationDetailsState();
}

class _LoadNodificationDetailsState extends State<LoadNodificationDetails> {

  LoadDetailsController loadDetailsController = Get.find<LoadDetailsController>();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDetailsController.getLoadDetails(loadId: LoadNodificationDetails.loadId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: commonText("Load Request", size: 21, isBold: true),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: GetBuilder<LoadDetailsController>(builder: (controller) {
        var loadItems = controller.loadDetailsModel.attributes.query;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shipper's Information
              commonText("Shipper's Information", isBold: true, size: 18),
              const Divider(),
              const SizedBox(height: 10),
              _buildInfoRow("Shipper Name", " ${loadItems.shipperName}",
                  "Shipper Phone", loadItems.shipperPhoneNumber),
              const SizedBox(height: 10),
              _buildInfoRow("Shipper Email", loadItems.shipperEmail, "Shipper Address", loadItems.shippingAddress),

              const SizedBox(height: 20),

              // Load Information Section
              commonText("Load Information", isBold: true, size: 18),
              const Divider(),
              const SizedBox(height: 10),
              _buildLoadInfoSection(loadItems),

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
                    _buildInfoRow("Receiver Name", loadItems.receiverName, "Receiver Phone",
                        loadItems.receiverPhoneNumber),
                    const SizedBox(height: 10),
                    _buildInfoRow("Receiver Email", loadItems.receiverEmail,
                        "Receiver Address", loadItems.receivingAddress),

                    const SizedBox(height: 10),

                    // Delivery Instructions
                    commonText("Description", isBold: true, size: 16),
                    const SizedBox(height: 5),
                    commonText(loadItems.description),

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
      },),
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

  Widget _buildLoadInfoSection(Query loadInfo) {
    return Padding(
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
                    commonText(loadInfo.loadType, size: 14),
                    const SizedBox(height: 10),
                    commonText("Pickup", size: 14, isBold: true),
                    commonText(OtherHelper.getDate(serverDate: loadInfo.pickupDate.toString()), size: 14),
                    commonText("Address: ${loadInfo.receivingAddress}",
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("Weight", size: 14, isBold: true),
                    commonText(loadInfo.weight.toString(), size: 14),
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
                    commonText("Trailer size", size: 14, isBold: true),
                    commonText(loadInfo.trailerSize.toString(), size: 14),
                    const SizedBox(height: 10),
                    commonText("Delivery", size: 14, isBold: true),
                    commonText(OtherHelper.getDate(serverDate: loadInfo.deliveryDate.toString()), size: 14),
                    commonText("Address: ${loadInfo.shippingAddress}",
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("HazMat", size: 14, isBold: true),
                    Row(
                      children: List.generate(
                          loadInfo.hazmat.length,
                        (index) {
                          return commonText(loadInfo.hazmat[index], size: 14);
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
          commonText("Delivery Instructions", isBold: true, size: 16),
          const SizedBox(height: 5),
          commonText(loadInfo.description),
        ],
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