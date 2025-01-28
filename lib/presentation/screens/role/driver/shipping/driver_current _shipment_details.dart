import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_currentshiping_controller/technical_issue_controller.dart';
import 'package:ootms/presentation/api/controllers/common/chat_controller.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/models/driver_model/currentship_model.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/current_shiping_model.dart';
import 'package:ootms/presentation/api/service/socket_service.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_map2.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_map_with_poliline.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map_with_polyline.dart';
import 'package:provider/provider.dart';

import '../../user/chat/user_chat.dart';

class DriverCurrentShipmentDetailsPage extends StatelessWidget {
  CurrentShippingModel shipmentDetails;
  ChatController chatController = Get.find<ChatController>();
  TechnicalIssueController techIssueCtl = Get.find<TechnicalIssueController>();

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
                _buildInfoRow("Shipper Name", shipmentDetails.load.shipperName,
                    "Shipper Phone", shipmentDetails.load.shipperPhoneNumber),
                const SizedBox(height: 10),
                _buildInfoRow(
                    "Shipper Email",
                    shipmentDetails.load.shipperEmail,
                    "Shipper Address",
                    shipmentDetails.load.shippingAddress),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            ///<<<==========>>>> Chat with Shipper <<<=============>>>>
            Obx(
              () => commonIconButton(isLoading: chatController.isLoading.value,
                  onTap: () {
                chatController.getChatList(context,
                    chatId: shipmentDetails.load.shipperToDriverChatId);
                animetedNavigationPush(
                    ChangeNotifierProvider(
                        create: (context) => UserChatProvider(),
                        child: UserChatPage(
                          chatId: shipmentDetails.load.shipperToDriverChatId,
                          senderId: shipmentDetails.user.id,
                        )),
                    context);
              },
                  "Chat with Shipper",
                  Image.asset(
                    "assets/icons/user home page/massage.png",
                    color: AppColor.white,
                  )),
            ),
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
                  _buildInfoRow(
                      "Receiver Name",
                      shipmentDetails.load.receiverName,
                      "Receiver Phone",
                      shipmentDetails.load.receiverPhoneNumber),
                  const SizedBox(height: 10),
                  _buildInfoRow(
                      "Receiver Email",
                      shipmentDetails.load.receiverEmail,
                      "Receiver Address",
                      shipmentDetails.load.receivingAddress),

                  const SizedBox(height: 10),

                  // Delivery Instructions
                  commonText("Delivery Instructions", isBold: true, size: 16),
                  const SizedBox(height: 5),
                  commonText(shipmentDetails.load.deliveryInstruction),
                  const SizedBox(
                    height: 20,
                  ),

                  /// =========Chat with receiver=====
                  Obx(
                    () => commonIconButton(
                        isLoading: chatController.isLoading.value, onTap: () {
                      chatController.getChatList(context,
                          chatId: shipmentDetails.load.shipperToReceiverChatId);
                      animetedNavigationPush(
                          ChangeNotifierProvider(
                              create: (context) => UserChatProvider(),
                              child: UserChatPage(
                                chatId: shipmentDetails
                                    .load.shipperToReceiverChatId,
                                senderId: shipmentDetails.user.id,
                              )),
                          context);
                    },
                        "Chat with Receiver",
                        Image.asset(
                          "assets/icons/user home page/massage.png",
                          color: AppColor.white,
                        )),
                  ),

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
                callForLiveLocation();
                // animetedNavigationPush(DriverMap2Page(shiperId: shipmentDetails.user.id,), context);
              },
            ),
            const SizedBox(height: 16),
            //==========================================================================technical issue,
            Obx(() {
              return commonButton(
                isLoading: techIssueCtl.isLoading.value,
                onTap: () {
                  techIssueCtl.technicalIssue(
                      loadId: shipmentDetails.load.id,
                      loadReqId: shipmentDetails.id,
                      context: context);
                },
                "Technical Issue",
                borderRadious: 10,
                color: AppColor.primaryColorLight.withOpacity(0.7),
                textColor: Colors.black,
              );
            }),
          ],
        ),
      ),
    );
  }

  callForLiveLocation() async {
    LatLng? driverLiveLocation =
        await SocketServices.getLocation(userId: shipmentDetails.driver.id);
    LatLng driverLocation = LatLng(
        shipmentDetails.driver.location.coordinates.last.toDouble(),
        shipmentDetails.driver.location.coordinates.first.toDouble());

    Timer.periodic(const Duration(seconds: 03), (timer) async {
      CustomMapController.instance.marker.clear();

      CustomMapController.instance.setMarker(
          LatLng(
              shipmentDetails.load.shipperLocation.coordinates.last.toDouble(),
              shipmentDetails.load.shipperLocation.coordinates.first
                  .toDouble()),
          "Load Location",
          AppIcons.locationMarker);

      if (driverLiveLocation != null) {
        CustomMapController.instance.updateLocation(
            driverLiveLocation.latitude.toDouble(),
            driverLiveLocation.longitude.toDouble());
      } else {
        CustomMapController.instance.updateLocation(
            driverLocation.latitude.toDouble(),
            driverLocation.longitude.toDouble());
      }

      await CustomMapController.instance.getRoute(
          origin: (driverLiveLocation != null)
              ? driverLiveLocation
              : driverLocation,
          destination: LatLng(
              shipmentDetails.load.shipperLocation.coordinates.last.toDouble(),
              shipmentDetails.load.shipperLocation.coordinates.first
                  .toDouble()));
      log("Marker Length: ${CustomMapController.instance.marker.length}, ${CustomMapController.instance.marker}");
    });

    log("CustomMapController.instance.marker ${CustomMapController.instance.marker.length}");
    animetedNavigationPush(
        DriverMapWithPoliline(
          shipmentDetails: shipmentDetails,
        ),
        Get.context!);
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
                    commonText(
                        OtherHelper.getDate(
                            serverDate:
                                shipmentDetails.load.pickupDate.toString()),
                        size: 14),
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
                    commonText(
                        "${shipmentDetails.load.trailerSize}-foot trailer— ${shipmentDetails.load.palletSpace} pallets",
                        size: 14),
                    const SizedBox(height: 10),
                    commonText("Delivery", size: 14, isBold: true),
                    commonText(
                        OtherHelper.getDate(
                            serverDate:
                                shipmentDetails.load.deliveryDate.toString()),
                        size: 14),
                    commonText(shipmentDetails.load.receivingAddress,
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("HazMat", size: 14, isBold: true),
                    ListView.builder(
                      itemCount: shipmentDetails.load.hazmat.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return commonText(
                            "${shipmentDetails.load.hazmat[index]},",
                            size: 14);
                      },
                    )
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
