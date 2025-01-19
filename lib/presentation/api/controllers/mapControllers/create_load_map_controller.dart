

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';

class CreateLoadMapController extends GetxController {

  static CreateLoadMapController get instance => Get.find<CreateLoadMapController>();

  var currentLocation = LatLng(0.0, 0.0).obs;
  var selectedLocation = LatLng(0.0, 0.0).obs;
  var selectedAddress = "".obs;
  List<Marker> marker = <Marker>[].obs;

  late GoogleMapController googleMapController;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          "Location permissions are permanently denied, we cannot request permissions.");
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLocation.value = LatLng(position.latitude, position.longitude);
  }

  void setGoogleMapController(GoogleMapController controller) {
    googleMapController = controller;

    // Move camera to current location if available
    if (currentLocation.value.latitude != 0.0 || currentLocation.value.longitude != 0.0 ) {
      googleMapController.animateCamera(
        CameraUpdate.newLatLng(currentLocation.value),
      );
    }
  }

  Future<String> onMapTapped(LatLng tappedLocation) async {
    selectedLocation.value = tappedLocation;

    // Animate the camera to the tapped location
    googleMapController.animateCamera(
      CameraUpdate.newLatLng(tappedLocation),
    );

    setMyLocationMarker(LatLng(selectedLocation.value.latitude, selectedLocation.value.longitude), "Selected location");
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          tappedLocation.latitude, tappedLocation.longitude);
      if (placemarks.isNotEmpty) {
        selectedAddress.value = "${placemarks.first.street}, ${placemarks.first.locality}";
        return selectedAddress.value;
      } else {
        selectedAddress.value = "Unknown address";
      }
    } catch (e) {
      selectedAddress.value = "Error fetching address.";
    }

    return selectedAddress.value;
  }

  setMyLocationMarker(LatLng latLng, String placeId,) async {
    final BitmapDescriptor customMarker = await _loadTruckIcon(Get.context!);
    Marker newMarker = Marker(
      onTap: () {
      },
      infoWindow: InfoWindow(title: placeId),
      icon: customMarker,
      markerId: MarkerId(placeId), // Use a unique MarkerId for each marker
      position: LatLng(latLng.latitude, latLng.longitude),
      // rotation: calculateBearing(LatLng(latLng.latitude, latLng.longitude), LatLng(23.776176, 90.425674)),
    );

    marker.add(newMarker);
  }

  Future<BitmapDescriptor> _loadTruckIcon(BuildContext context) async {
    return await BitmapDescriptor.asset(
        ImageConfiguration(devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
        AppIcons.locationMarker,
        height: 50, width: 40
    );
  }

}
