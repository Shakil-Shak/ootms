
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';


class UserMapWithPolyline extends StatefulWidget {
  const UserMapWithPolyline({super.key});

  @override
  State<UserMapWithPolyline> createState() => _UserMapWithPolylineState();
}

class _UserMapWithPolylineState extends State<UserMapWithPolyline> {

  final CustomMapController customMapController = Get.find<CustomMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => GoogleMap(
            initialCameraPosition: customMapController.initialCameraPosition,
            compassEnabled: true,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            markers: Set<Marker>.of(customMapController.marker),
            onMapCreated: (GoogleMapController controller) {
              customMapController.googleMapController.complete(controller);
            },
            onCameraMove: (CameraPosition position){
              print("Camera position is moving: ${position.target.latitude}, ${position.target.longitude}################");
              customMapController.updateLocation(
                  position.target.latitude, position.target.longitude
              );
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
                customMapController.stopLocationUpdates();
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

