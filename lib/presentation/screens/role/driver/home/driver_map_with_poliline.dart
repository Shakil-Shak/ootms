import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_currentshiping_controller/shipment_start_controller.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';

import '../../../../api/models/user_model/shiping_model/current_shiping_model.dart';

class DriverMapWithPoliline extends StatefulWidget {
  CurrentShippingModel? shipmentDetails;
  DriverMapWithPoliline({super.key, this.shipmentDetails});

  @override
  State<DriverMapWithPoliline> createState() => _DriverMapWithPolilineState();
}

class _DriverMapWithPolilineState extends State<DriverMapWithPoliline> {
  final CustomMapController customMapController =
      Get.find<CustomMapController>();

  final ShipmentStartController shipmentAction =
      Get.find<ShipmentStartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                initialCameraPosition:
                    customMapController.initialCameraPosition,
                compassEnabled: true,
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                markers: Set<Marker>.of(customMapController.marker),
                onMapCreated: (GoogleMapController controller) {
                  customMapController.googleMapController.complete(controller);
                },
                onCameraMove: (CameraPosition position) {
                  print(
                      "Camera position is moving: ${position.target.latitude}, ${position.target.longitude}################");
                  customMapController.updateLocation(
                      position.target.latitude, position.target.longitude);
                },
                polylines: customMapController.polyLines,
              )),

          // Back button
          Positioned(
            top: 60,
            left: 16,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26, spreadRadius: 2, blurRadius: 5)
                    ]),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
          width: 250,
          child: commonButton(onTap: () {
            if (widget.shipmentDetails!.status == "Accepted") {
              showStartShipmentDialog(context: context);
            }
          },
              widget.shipmentDetails!.status == "Accepted"
                  ? "Start Shipment"
                  : "Delivered The Load")),
    );
  }

  //==============================================================================dialog box
  void showStartShipmentDialog(
      {required BuildContext context, VoidCallback? delete}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      pageBuilder: (context, animation, secondaryAnimation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: commonText(
                      "Are you sure?",
                      size: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: 120,
                          height: 50,
                          child: commonButton(
                            onTap: () {
                              Get.back();
                            },
                            "Cancel",
                            textSize: 12,
                            isBold: true,
                            textColor: AppColor.white,
                          )),
                      SizedBox(
                          width: 120,
                          height: 50,
                          child: Obx(() {
                            return commonButton(
                              isLoading: shipmentAction.isLoading.value,
                              onTap: () {
                                shipmentAction.startShipment(
                                    loadReqId: widget.shipmentDetails!.id,action: "picked");
                              },
                              "Start",
                              textSize: 12,
                              isBold: true,
                              textColor: AppColor.white,
                            );
                          })),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 500), // Slow motion
    );
  }
}
