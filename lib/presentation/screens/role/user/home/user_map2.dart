import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';

class UserMap2Page extends StatefulWidget {
  const UserMap2Page({super.key});

  @override
  State<UserMap2Page> createState() => _UserMap2PageState();
}

class _UserMap2PageState extends State<UserMap2Page> {
  // final String apiKey = 'AIzaSyAJrp3VvbO4E4jo7HRgqsk7EP8mPIZStxQ';
  // MapController mapController = MapController();
  // final LatLng _markerPosition = const LatLng(23.627556, 90.5212385);

  CustomMapController mapController = Get.find<CustomMapController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Map with marker
          // ColorFiltered(
          //   colorFilter:
          //       const ColorFilter.mode(Colors.white, BlendMode.colorBurn),
          //   child: FlutterMap(
          //     mapController: mapController,
          //     options: MapOptions(
          //       onTap: (tapPosition, point) {},
          //       initialCenter: _markerPosition,
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
          //             point: _markerPosition,
          //             child: InkWell(
          //               onTap: () {
          //                 mapController.move(_markerPosition, 11);
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
                        color: Colors.black26,
                        spreadRadius: 2,
                        blurRadius: 5
                      )
                    ]
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
