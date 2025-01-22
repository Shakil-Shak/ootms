// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_find_load_controller.dart';
import 'package:ootms/presentation/api/controllers/common/load_details_controller.dart';
import 'package:ootms/presentation/api/models/load_details_model.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../api/controllers/Driver/load_request_controller/load_request_controller.dart';
import '../../../../api/models/driver_model/load_request_model.dart';

class MapLoadDetails extends StatelessWidget {
  MapLoadDetails({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: commonText("Load Request", size: 21, isBold: true),
        centerTitle: true,
        backgroundColor: AppColor.white,
      ),
      body: GetBuilder<DriverLoadRequest>(
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
                _buildInfoRow("Shipper Name", " $shipperName", "Shipper Phone",
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
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: hazmat.length,
                                          itemBuilder: (context, index) {
                                            return commonText(
                                                "${hazmat[index]}",
                                                maxLines: hazmat.length,
                                                size: 14);
                                          })
                                    ]),
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
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      _launchDialer(shipperPhone);
                    },
                    child: Container(
                      width: 300,
                      height: 54,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 73, vertical: 10),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF3F3F3),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1.50, color: Color(0xFFA8A8A8)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 6,
                            offset: Offset(0, 1),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(AppIcons.call)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Cancel and Assign Load Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: commonButton(onTap: () {
                        Get.back();
                      }, "Cancel",
                          borderRadious: 10,
                          color: const Color(0xFFDDDDDD),
                          textColor: AppColor.black),
                    ),
                    const SizedBox(width: 16),
                    Expanded(child: Obx(() {
                      return commonButton(
                        isLoading: DriverFindLoadController
                            .instance.isRequestLoad.value,
                        "Request Load",
                        borderRadious: 10,
                        textColor: Colors.white,
                        onTap: () async {
                          print(
                              "===================================loadId$loadId");
                          await DriverFindLoadController.instance
                              .loadRequest(loadId: loadReqId, context: context);
                          Get.back();
                        },
                      );
                    })),
                  ],
                )
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
                  // Visibility(
                  //   visible: title1 == "Shipper Name",
                  //   // child: const Icon(
                  //   //   Icons.star,
                  //   //   size: 15,
                  //   //   color: Colors.yellow,
                  //   // ),
                  // ),
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
