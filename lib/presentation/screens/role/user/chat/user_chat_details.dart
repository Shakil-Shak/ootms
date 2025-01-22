import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/common/chat_controller.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/current_shiping_model.dart';
import 'package:ootms/presentation/api/service/socket_service.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/chat/user_chat.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map_with_polyline.dart';
import 'package:provider/provider.dart';

class UserChatDetailsScreen extends StatelessWidget {
  CurrentShippingModel shipmentDetails;

  UserChatDetailsScreen({super.key, required this.shipmentDetails});

  ChatController chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {
    log(shipmentDetails.load.shippingAddress);
    log(shipmentDetails.load.shipperToDriverChatId);
    log(shipmentDetails.load.shipperToReceiverChatId);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              driverInfo(),

              ///<<<==========>>>> Chat with Driver <<<=============>>>>
              Obx(
                () => commonIconButton(
                  isLoading: chatController.isLoading.value,
                    onTap: () {
                  chatController.getChatList(context, chatId: shipmentDetails.load.shipperToDriverChatId);
                  animetedNavigationPush(
                      ChangeNotifierProvider(
                          create: (context) => UserChatProvider(),
                          child: UserChatPage(chatId: shipmentDetails.load.shipperToDriverChatId , senderId: shipmentDetails.user.id,)),
                      context);
                },
                    "Chat with Driver",
                    Image.asset(
                      "assets/icons/user home page/massage.png",
                      color: AppColor.white,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              reciverInfo(),

              Obx(() =>
                  commonIconButton(
                      isLoading: chatController.isLoading.value,
                      onTap: () {
                    chatController.getChatList(context, chatId: shipmentDetails.load.shipperToReceiverChatId);
                    animetedNavigationPush(
                        ChangeNotifierProvider(
                            create: (context) => UserChatProvider(),
                            child: UserChatPage(chatId: shipmentDetails.load.shipperToReceiverChatId , senderId: shipmentDetails.user.id,)),
                        context);
                  },
                      "Chat with Receiver",
                      Image.asset(
                        "assets/icons/user home page/massage.png",
                        color: AppColor.white,
                      )),
              ),
              const SizedBox(
                height: 10,
              ),
              loadInfo()
            ],
          ),
        ),
      ),
    );
  }

  Widget driverInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonText(
          "Driver's Information",
          size: 16,
          isBold: true,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            _buildInfoRow(
                "Driver Name",
                "${shipmentDetails.driver.ratings} ${shipmentDetails.driver.fullName}",
                "Driver Phone",
                shipmentDetails.driver.phoneNumber),
            const SizedBox(height: 10),
            _buildInfoRow("Driver Email", shipmentDetails.driver.email,
                "Driver Address", shipmentDetails.driver.address),
            const SizedBox(
              height: 10,
            )
          ]),
        ),
      ],
    );
  }

  Widget loadInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonText(
          "Load Information",
          size: 16,
          isBold: true,
        ),
        const Divider(),
        _buildLoadInfoSection(),
      ],
    );
  }

  Widget reciverInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonText(
          "Receiver Information",
          size: 16,
          isBold: true,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow("Receiver Name", shipmentDetails.load.receiverName,
                  "Receiver Phone", shipmentDetails.load.receiverPhoneNumber),
              const SizedBox(height: 10),
              _buildInfoRow(
                  "Receiver Email",
                  shipmentDetails.load.receiverEmail,
                  "Receiver Address",
                  shipmentDetails.load.receivingAddress),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
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
                    visible: title1 == "driver Name",
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
                    commonText(
                        "Address: ${shipmentDetails.load.shippingAddress}",
                        size: 14,
                        fontWeight: FontWeight.w500),
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
                        "${shipmentDetails.load.trailerSize} -foot trailer— ${shipmentDetails.load.palletSpace} pallets",
                        size: 14),
                    const SizedBox(height: 10),
                    commonText("Delivery", size: 14, isBold: true),
                    commonText(
                        OtherHelper.getDate(
                            serverDate:
                                shipmentDetails.load.deliveryDate.toString()),
                        size: 14),
                    commonText(
                        "Address: ${shipmentDetails.load.receivingAddress}",
                        size: 14,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("HazMat", size: 14, isBold: true),
                    Wrap(
                      children: List.generate(
                        shipmentDetails.load.hazmat.length,
                        (index) {
                          return commonText(
                            "${shipmentDetails.load.hazmat[index]}, ",
                            size: 14,
                          );
                        },
                      ),
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
          commonText("Description", isBold: true, size: 16),
          const SizedBox(height: 5),
          commonText(shipmentDetails.load.description, maxLines: 10),
          const SizedBox(
            height: 15,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: commonButton(
                  onTap: () async {
                     callForLiveLocation();
                  },
                    "Track On Map",
                    borderRadious: 10,
                    color: AppColor.primaryColorLight,
                    textColor: AppColor.black),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: commonButton(
                  borderRadious: 10,
                  "Re-Assign",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  callForLiveLocation() async {
    LatLng? driverLiveLocation = await SocketServices.getLocation(userId: shipmentDetails.driver.id);
    LatLng driverLocation = LatLng(
        shipmentDetails.driver.location.coordinates.last.toDouble(),
        shipmentDetails.driver.location.coordinates.first.toDouble());

    Timer.periodic(const Duration(seconds: 03), (timer) async {
      CustomMapController.instance.marker.clear();

      CustomMapController.instance.setMarker(
          LatLng(shipmentDetails.load.shipperLocation.coordinates.last.toDouble(),
              shipmentDetails.load.shipperLocation.coordinates.first.toDouble()),
          "Load Location",
          AppIcons.locationMarker);

      if(driverLiveLocation != null){
        CustomMapController.instance.updateLocation(driverLiveLocation.latitude.toDouble(), driverLiveLocation.longitude.toDouble());
      }else{
        CustomMapController.instance.updateLocation(driverLocation.latitude.toDouble(), driverLocation.longitude.toDouble());
      }

      await CustomMapController.instance.getRoute(
          origin: (driverLiveLocation != null)
              ? driverLiveLocation
              : driverLocation,
          destination: LatLng(
              shipmentDetails.load.shipperLocation.coordinates.last.toDouble(),
              shipmentDetails.load.shipperLocation.coordinates.first.toDouble()));
      log("Marker Length: ${CustomMapController.instance.marker.length}, ${CustomMapController.instance.marker}");
    });

    log("CustomMapController.instance.marker ${CustomMapController.instance.marker.length}");
    animetedNavigationPush(const UserMapWithPolyline(), Get.context!);
  }
}
