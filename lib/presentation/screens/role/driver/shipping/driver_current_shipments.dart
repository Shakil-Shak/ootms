import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_current%20_shipment_details.dart';
import 'package:provider/provider.dart';

import '../../../../api/controllers/Driver/driver_currentshiping_controller/shipment_controller.dart';
import '../../../../api/models/driver_model/currentship_model.dart';

class DriverCurrentShipmentsPage extends StatefulWidget {
  DriverCurrentShipmentsPage({super.key});

  @override
  State<DriverCurrentShipmentsPage> createState() =>
      _DriverCurrentShipmentsPageState();
}

class _DriverCurrentShipmentsPageState
    extends State<DriverCurrentShipmentsPage> {
  DriverShipmentController currentShip = Get.find<DriverShipmentController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () {
        currentShip.handleScrollController();
        currentShip.getDriverShipment();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText('Current Shipments', size: 21, isBold: true),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<ProfileController>(
        builder: (context, value, child) {
          return GetBuilder<DriverShipmentController>(
            builder: (currentShip) {
              return Stack(
                children: [
                  currentShip.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        )
                      : currentShip.currentShipmentData.isEmpty
                          ? Center(child: commonText("Current Shipment Empty"))
                          : ListView.separated(
                              controller: currentShip.scrollController,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                              padding: const EdgeInsets.all(16.0),
                              itemCount: currentShip.currentShipmentData.length,
                              itemBuilder: (context, index) {
                                DriverCurrentshipModel data =
                                    currentShip.currentShipmentData[index];

                                return InkWell(
                                  onTap: () {
                                    animetedNavigationPush(
                                        DriverCurrentShipmentDetailsPage(
                                          shipperPhone:
                                              data.load!.shipperPhoneNumber!,
                                          shipperName: data.load!.shipperName!,
                                          shipperRating:
                                              data.load!.shipperPhoneNumber!,
                                          shipperEmail:
                                              data.load!.shipperEmail!,
                                          shipperAddress:
                                              data.load!.shippingAddress!,
                                          reciverName: data.load!.receiverName!,
                                          reciverPhone:
                                              data.load!.receiverPhoneNumber!,
                                          reciverEmail:
                                              data.load!.receiverEmail!,
                                          reciverAddress:
                                              data.load!.receivingAddress!,
                                          description:
                                              data.load!.deliveryInstruction!,
                                          deliveryInstructions:
                                              data.load!.deliveryInstruction!,
                                          loadType: data.load!.loadType!,
                                          trailerSize: data.load!.trailerSize!
                                              .toString(),
                                          pickupDate: OtherHelper.getDate(
                                              serverDate: data.load!.pickupDate!
                                                  .toString()),
                                          deliveryDate: OtherHelper.getDate(
                                              serverDate: data
                                                  .load!.deliveryDate!
                                                  .toString()),
                                          weight: data.load!.weight!.toString(),
                                          hazmat: data.load!.hazmat,
                                          pallets: data.load!.palletSpace!.toString(),
                                        ),
                                        context);
                                  },
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            ApiPaths.baseUrl +
                                                data.driver!.image!),
                                        radius: 24,
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            commonText(data.driver!.fullName!,
                                                size: 16, isBold: true),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            commonText(
                                                "${data.truck!.trailerSize}-foot trailer—${data.load!.palletSpace} pallets.",
                                                size: 14),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Image.asset(
                                                        "assets/icons/arrow_up.png",
                                                      ),
                                                      const SizedBox(width: 4),
                                                      SizedBox(
                                                          width: 100,
                                                          child: commonText(
                                                            maxLines: 1,
                                                            data.load!
                                                                .shippingAddress!,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Transform.rotate(
                                                          angle: pi,
                                                          child: Image.asset(
                                                              "assets/icons/arrow_up.png")),
                                                      const SizedBox(width: 4),
                                                      SizedBox(
                                                          width: 100,
                                                          child: commonText(
                                                            maxLines: 1,
                                                            data.load!
                                                                .receivingAddress!,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                  // Circular Progress Indicator at the bottom
                  if (currentShip.isMoreLoading) ...[
                    const Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ]
                ],
              );
            },
          );
        },
      ),
    );
  }
}
