import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/models/driver_model/currentship_model.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/current_shiping_model.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_map2.dart';
import 'package:provider/provider.dart';

import '../../user/chat/user_chat.dart';

class DriverCurrentShipmentDetailsPage extends StatelessWidget {

  CurrentShippingModel shipmentDetails;

  DriverCurrentShipmentDetailsPage({
    super.key,
    required this.shipmentDetails,
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
                _buildInfoRow("Shipper Name", shipmentDetails.load.shipperName, "Shipper Phone",
                    shipmentDetails.load.shipperPhoneNumber),
                const SizedBox(height: 10),
                _buildInfoRow("Shipper Email", shipmentDetails.load.shipperEmail, "Shipper Address",
                    shipmentDetails.load.shippingAddress),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            ///=========>>>> Chat with shipper Button <<<<===================
            commonIconButton(onTap: () {
              animetedNavigationPush(
                  ChangeNotifierProvider(
                      create: (context) => UserChatProvider(),
                      child: UserChatPage(chatId: "", senderId: "",)),
                  context);
            },
                "Chat with Shipper",
                Image.asset(
                  "assets/icons/user home page/massage.png",
                  color: AppColor.white,
                )),
            const SizedBox(
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
                  _buildInfoRow("Receiver Name", shipmentDetails.load.receiverName, "Receiver Phone",
                      shipmentDetails.load.receiverPhoneNumber),
                  const SizedBox(height: 10),
                  _buildInfoRow("Receiver Email", shipmentDetails.load.receiverEmail,
                      "Receiver Address", shipmentDetails.load.receivingAddress),

                  const SizedBox(height: 10),

                  // Delivery Instructions
                  commonText("Delivery Instructions", isBold: true, size: 16),
                  const SizedBox(height: 5),
                  commonText(shipmentDetails.load.deliveryInstruction),
                  const SizedBox(
                    height: 20,
                  ),
                  commonIconButton(onTap: () {
                    animetedNavigationPush(
                        ChangeNotifierProvider(
                            create: (context) => UserChatProvider(),
                            child: UserChatPage(chatId: "", senderId: "",)),
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
            const SizedBox(
              height: 20,
            ),

            /// ==========>>> Map Button <<<==============
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
                    commonText(shipmentDetails.load.loadType, size: 14),
                    const SizedBox(height: 10),
                    commonText("Pickup", size: 14, isBold: true),
                    commonText(OtherHelper.getDate(serverDate: shipmentDetails.load.pickupDate.toString()), size: 14),
                    commonText(shipmentDetails.load.shippingAddress,
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("Weight", size: 14, isBold: true),
                    commonText("${shipmentDetails.load.weight} lb", size: 14),
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
                    commonText("${shipmentDetails.load.trailerSize}-foot trailer— ${shipmentDetails.load.palletSpace} pallets", size: 14),
                    const SizedBox(height: 10),
                    commonText("Delivery", size: 14, isBold: true),
                    commonText(OtherHelper.getDate(serverDate: shipmentDetails.load.deliveryDate.toString()), size: 14),
                    commonText(shipmentDetails.load.receivingAddress,
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("HazMat", size: 14, isBold: true),
                    ListView.builder(itemCount: shipmentDetails.load.hazmat.length,physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemBuilder:(context, index) {
                      return commonText("${shipmentDetails.load.hazmat[index]},", size: 14);
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
          commonText(shipmentDetails.load.description),
        ],
      ),
    );
  }
}
