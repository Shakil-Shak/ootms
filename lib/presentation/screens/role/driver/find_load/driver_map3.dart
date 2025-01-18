// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverMap3Page extends StatefulWidget {
  const DriverMap3Page({super.key});

  @override
  State<DriverMap3Page> createState() => _DriverMap3PageState();
}

class _DriverMap3PageState extends State<DriverMap3Page> {

  CustomMapController mapController = Get.find<CustomMapController>();
  TextEditingController searchController = TextEditingController();
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
            onCameraMove: (CameraPosition position){
              log("Camera position is moving: ${position.target.latitude}, ${position.target.longitude}################");
              mapController.updateLocation(
                  position.target.latitude, position.target.longitude
              );
            },
            onTap: (LatLng latlng) async{
              mapController.isTapped.value = true;
              mapController.setTargetLocation(latlng.latitude, latlng.longitude);
              mapController.placeAddress = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);

              mapController.list.add(
                  Marker(
                    markerId: MarkerId('tapped place'),
                    position: LatLng(latlng.latitude, latlng.longitude),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                    infoWindow: InfoWindow(
                        title: "${mapController.placeAddress.first.subLocality}: ${latlng.latitude}, ${latlng.longitude}"
                    ),
                  )
              );
              final GoogleMapController controller = await mapController.googleMapController.future;
              await controller.animateCamera(CameraUpdate.newCameraPosition(mapController.kRandom));
              log("==============Map Tapped Here: ${mapController.placeAddress} ====================");
              mapController.isTapped.value = false;
            },

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
            top: 30,
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
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5
                    )
                  ]
                ),
                padding: EdgeInsets.all(8.0),
                child: Center(
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
