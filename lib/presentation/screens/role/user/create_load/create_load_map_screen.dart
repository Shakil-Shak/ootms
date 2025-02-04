
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/create_load_map_controller.dart';
import 'package:ootms/presentation/api/controllers/user/load_controller/load_controller.dart';

class CreateLoadMapScreen extends StatelessWidget {

  CreateLoadMapController createLoadMapController =
      Get.find<CreateLoadMapController>();
  final LoadController loadController = LoadController();

  static bool isReceiver = false;
  final String googleApiKey = "AIzaSyCZ6YIiEkZnGVCQUyFIKsu3RdOJ49GVeLU";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: createLoadMapController.currentLocation.value,
                zoom: 14.0,
              ),
              onMapCreated: createLoadMapController.setGoogleMapController,
              myLocationEnabled: true,
              onTap: (argument) async {
                loadController.updateAddresses(argument.latitude, argument.longitude);
              },
              markers: Set<Marker>.of(createLoadMapController.marker),
            );
          }),

          Positioned(
            bottom: 20,
            left: 20,
            child: Obx(() {
              return Container(
                height: 120,
                width: 200,
                padding: EdgeInsets.only(left: 16, top: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                    boxShadow: const [
                    BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2,
                    blurRadius: 5
                )
                  ]
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Selected Address:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(createLoadMapController.selectedAddress.value),
                      const SizedBox(height: 10),
                      Text(
                        "Latitude: ${createLoadMapController.selectedLocation.value.latitude.toStringAsFixed(6)}",
                      ),
                      Text(
                        "Longitude: ${createLoadMapController.selectedLocation.value.longitude.toStringAsFixed(6)}",
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),

          Positioned(
              top: 60,
              left: 20,
              right: 20,
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        String data = createLoadMapController.selectedAddress.value;
                        debugPrint("Data:======>>> $data");
                        Navigator.pop(context, data);
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
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
                      )
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 2,
                                blurRadius: 3
                            )
                          ],
                        borderRadius: BorderRadius.circular(12)

                      ),
                      child: GooglePlaceAutoCompleteTextField(
                        textEditingController: TextEditingController(),
                        googleAPIKey: googleApiKey,
                        inputDecoration: InputDecoration(
                          hintText: "Search location",
                          border: InputBorder.none,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8)
                        ),
                        debounceTime: 800, // Delay for API calls
                        countries: ["us", "bd"], // Country codes
                        isLatLngRequired: true,
                        getPlaceDetailWithLatLng: (prediction) {
                          createLoadMapController.updateLocation(double.parse("${prediction.lat}"), double.parse("${prediction.lng}"));
                        },
                        itemClick: (prediction) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          createLoadMapController. selectedAddress.value = prediction.description!;
                        },
                      ),
                    ),
                  )
                ],
              ),
          ),
        ],
      ),
    );
  }
}
