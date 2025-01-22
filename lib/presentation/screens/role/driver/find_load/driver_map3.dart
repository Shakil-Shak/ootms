// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../components/common_textfield.dart';

class DriverMap3Page extends StatefulWidget {
  const DriverMap3Page({super.key});

  @override
  State<DriverMap3Page> createState() => _DriverMap3PageState();
}

class _DriverMap3PageState extends State<DriverMap3Page> {
  CustomMapController mapController = Get.find<CustomMapController>();
  TextEditingController searchController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String apiKey =
      'AIzaSyAJrp3VvbO4E4jo7HRgqsk7EP8mPIZStxQ'; // Replace with your Geoapify API key
  LatLng? _markerPosition = const LatLng(23.627556, 90.5212385);

  @override
  void initState() {
    super.initState();
  }

  // Future<void> _onMarkerTap(LatLng position) async {
  //   setState(() {
  //     _markerPosition = position;
  //   });
  //   _showLocationDetails(); // Show bottom sheet on marker tap
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Obx(() => GoogleMap(
                initialCameraPosition: mapController.initialCameraPosition,
                compassEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set<Marker>.of(mapController.marker.toList()),
                onMapCreated: (GoogleMapController controller) {
                  if (!mapController.googleMapController.isCompleted) {
                    mapController.googleMapController.complete(controller);
                  }
                },
                onCameraMove: (CameraPosition position) {
                  log("Camera position is moving: ${position.target.latitude}, ${position.target.longitude}################");
                  mapController.updateLocation(
                      position.target.latitude, position.target.longitude);
                },
                // onTap: (LatLng latlng) async{
                //   mapController.isTapped.value = true;
                //   mapController.setTargetLocation(latlng.latitude, latlng.longitude);
                //   mapController.placeAddress = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
                //
                //   mapController.list.add(
                //       Marker(
                //         markerId: MarkerId('tapped place'),
                //         position: LatLng(latlng.latitude, latlng.longitude),
                //         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                //         infoWindow: InfoWindow(
                //             title: "${mapController.placeAddress.first.subLocality}: ${latlng.latitude}, ${latlng.longitude}"
                //         ),
                //       )
                //   );
                //   final GoogleMapController controller = await mapController.googleMapController.future;
                //   await controller.animateCamera(CameraUpdate.newCameraPosition(mapController.kRandom));
                //   log("==============Map Tapped Here: ${mapController.placeAddress} ====================");
                //   mapController.isTapped.value = false;
                // },

                // polylines: _polylines,
              )),
          //Map with marker
          // ColorFiltered(
          //   colorFilter:
          //       const ColorFilter.mode(Colors.white, BlendMode.colorBurn),
          //   child: FlutterMap(
          //     mapController: mapController,
          //     options: MapOptions(
          //       onTap: (tapPosition, point) {
          //         _onMarkerTap(point); // Trigger bottom sheet on map tap
          //       },
          //       initialCenter: (_markerPosition != null)
          //           ? _markerPosition!
          //           : const LatLng(23.627556, 90.5212385),
          //       maxZoom: 21.0,
          //     ),
          //     children: [
          //       TileLayer(
          //         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          //         additionalOptions: {
          //           'apiKey': apiKey,
          //         },
          //       ),
          //       MarkerLayer(
          //         markers: [
          //           Marker(
          //             width: 25.0,
          //             height: 25.0,
          //             point: (_markerPosition != null)
          //                 ? _markerPosition!
          //                 : const LatLng(23.627556, 90.5212385),
          //             child: InkWell(
          //               onTap: () {
          //                 _onMarkerTap(_markerPosition!);
          //                 mapController.move(_markerPosition!, 11);
          //                 setState(() {});
          //               },
          //               child: Stack(
          //                 alignment: Alignment.center,
          //                 children: [
          //                   Container(
          //                     decoration: BoxDecoration(
          //                         color: const Color.fromRGBO(0, 0, 255, 1),
          //                         shape: BoxShape.circle,
          //                         boxShadow: const [
          //                           BoxShadow(
          //                             blurRadius: 1,
          //                           )
          //                         ],
          //                         border: Border.all(
          //                             width: 5, color: Colors.white)),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          Positioned(
              top: 60,
              right: 20,
              child: InkWell(
                onTap: () {
                  showFilterModal();
                },
                child: Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColor.primaryColor, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    child: SvgPicture.asset(AppIcons.filter)),
              )),

          Positioned(
            top: 60,
            left: 16,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5)
                    ]),
                padding: const EdgeInsets.all(8.0),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //=======================================================================filter modal sheet
  void showFilterModal() {
    showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          builder: (context, scrollController) {
            return Container(
              width: Get.width,
              height: 800,
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.cancel))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonTextfieldWithTitle(
                              readOnly: true,
                              // enable: false,
                              "Source",
                              TextEditingController(),
                              onValidate: (value) =>
                                  OtherHelper.emailValidator(value),
                              hintText: "Input your Source Location",
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            commonTextfieldWithTitle(
                              readOnly: true,
                              // enable: false,
                              "Destinations",
                              TextEditingController(),
                              onValidate: (value) =>
                                  OtherHelper.emailValidator(value),
                              hintText: "Input Your Destination Loacation",
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            commonText("Distance From Source",
                                size: 15, color: AppColor.black),
                          ],
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(() {
                    return Slider(
                        value: mapController.sliderValue.value,
                        min: 0.0,
                        max: 500,
                        onChanged: (value) {
                          mapController.sliderValue.value = value;
                        });
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            commonText("Minimum",size: 15,color: AppColor.black),
                            SizedBox(height: 5,),
                            Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColor.primaryColor)),
                              child: Center(child: commonText("${mapController.minValue} Km")),
                            )
                          ],
                        ),
                        
                        Column(
                          children: [
                            commonText("Maximum",size: 15,color: AppColor.black),
                            SizedBox(height: 5,),
                            Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: AppColor.primaryColor)),
                              child: Center(child: commonText("${mapController.minValue} Km")),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  commonButton(
                    "Apply",
                    onTap: () {
                      if (formKey.currentState!.validate()) {}
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
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
