import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_map2.dart';
import 'package:provider/provider.dart';

import '../../user/chat/user_chat.dart';

class DriverCurrentShipmentDetailsPage extends StatelessWidget {
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
  List<String>? hazmat;
  String pallets;

  DriverCurrentShipmentDetailsPage({
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
    required this.pickupDate,
    required this.deliveryDate,
    required this.weight,
    required this.hazmat,
    required this.pallets,
  });

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildInfoRow("Shipper Name", "$shipperName", "Shipper Phone",
                    shipperPhone),
                const SizedBox(height: 10),
                _buildInfoRow("Shipper Email", shipperEmail, "Shipper Address",
                    shipperAddress),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            commonIconButton(onTap: () {
              animetedNavigationPush(
                  ChangeNotifierProvider(
                      create: (context) => UserChatProvider(),
                      child: const UserChatPage()),
                  context);
            },
                "Chat with Shipper",
                Image.asset(
                  "assets/icons/user home page/massage.png",
                  color: AppColor.white,
                )),
            SizedBox(
              height: 20,
            ),

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
                  SizedBox(
                    height: 20,
                  ),
                  commonIconButton(onTap: () {
                    animetedNavigationPush(
                        ChangeNotifierProvider(
                            create: (context) => UserChatProvider(),
                            child: const UserChatPage()),
                        context);
                  },
                      "Chat with Receiver",
                      Image.asset(
                        "assets/icons/user home page/massage.png",
                        color: AppColor.white,
                      )),

                  const SizedBox(height: 30),

                  // Load Information Section
                  commonText("Load Information", isBold: true, size: 18),
                  const Divider(),
                  const SizedBox(height: 10),
                  _buildLoadInfoSection(),

                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            // Buttons at the bottom
            commonButton(
              "Go To The Map",
              borderRadious: 10,
              onTap: () {
                animetedNavigationPush(const DriverMap2Page(), context);
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
                    commonText(loadType, size: 14),
                    const SizedBox(height: 10),
                    commonText("Pickup", size: 14, isBold: true),
                    commonText(pickupDate, size: 14),
                    commonText(shipperAddress,
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("Weight", size: 14, isBold: true),
                    commonText(weight, size: 14),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText("Trailer size", size: 14, isBold: true),
                    commonText("$trailerSize-foot trailer—$pallets pallets", size: 14),
                    const SizedBox(height: 10),
                    commonText("Delivery", size: 14, isBold: true),
                    commonText(deliveryDate, size: 14),
                    commonText(reciverAddress,
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("HazMat", size: 14, isBold: true),
                    ListView.builder(itemCount: hazmat!.length,physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder:(context, index) {
                      return commonText("${hazmat![index]},", size: 14);
                    },)
                    
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
          commonText(description),
        ],
      ),
    );
  }
}
