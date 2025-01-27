

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/presentation/screens/role/user/create_load/create_load_map_screen.dart';

class CreateLoadMapController extends GetxController {

  static CreateLoadMapController get instance => Get.find<CreateLoadMapController>();

  var currentLocation = LatLng(0.0, 0.0).obs;
  var selectedLocation = LatLng(0.0, 0.0).obs;

  var selectedAddress = "".obs;
  var shipperLatitude =  0.0;
  var shipperLongitude =  0.0;

  var receiverLatitude =  0.0;
  var receiverLongitude =  0.0;
  String city = "";
  String state = "";
  String zip = "";

  List<Marker> marker = <Marker>[].obs;

  late GoogleMapController googleMapController;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {

    log("Current location is called.");

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

    selectedAddress.value = await getAddress(latitude: position.latitude, longitude: position.longitude);

    if(!CreateLoadMapScreen.isReceiver){
      shipperLatitude = position.latitude;
      shipperLongitude = position.longitude;
    }else{
      receiverLatitude = position.latitude;
      receiverLongitude = position.longitude;
    }
    selectedLocation.value = LatLng(position.latitude, position.longitude);
    addMarker(currentLocation.value);
  }

  void addMarker(LatLng position) {
    marker.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: position,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: 'Your Location',
          snippet: '${position.latitude}, ${position.longitude}',
        ),
      ),
    );
  }


  void updateLocation(double lat, double lng) {
    googleMapController.animateCamera(
      CameraUpdate.newLatLng(LatLng(lat, lng)),
    );
    if(!CreateLoadMapScreen.isReceiver){
      shipperLatitude = lat;
      shipperLongitude = lng;
    }else{
      receiverLatitude = lat;
      receiverLongitude = lng;
    }
    selectedLocation.value = LatLng(lat, lng);
    setMyLocationMarker(LatLng(lat, lng), "Selected Location");
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
    if(!CreateLoadMapScreen.isReceiver){
      shipperLatitude = tappedLocation.latitude;
      shipperLongitude = tappedLocation.longitude;
    }else{
      receiverLatitude = tappedLocation.latitude;
      receiverLongitude = tappedLocation.longitude;
    }

    // Animate the camera to the tapped location
    googleMapController.animateCamera(
      CameraUpdate.newLatLng(tappedLocation),
    );

    setMyLocationMarker(LatLng(selectedLocation.value.latitude, selectedLocation.value.longitude), "Selected location");
    selectedAddress.value = await getAddress(latitude: tappedLocation.latitude, longitude: tappedLocation.longitude);

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

  Future<String>getAddress({required double latitude, required double longitude}) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude, longitude);

      log("=====>>>> $placemarks <<<<===========");
      if (placemarks.isNotEmpty) {
        city = placemarks.first.locality ?? "";
        state = placemarks.first.country ?? "";
        city = placemarks.first.postalCode ?? "";
        return "${placemarks.first.street}, ${placemarks.first.subLocality}";
      } else {
        return "Unknown address";
      }
    } catch (e) {
      return "Error fetching address.";
    }
  }

}
