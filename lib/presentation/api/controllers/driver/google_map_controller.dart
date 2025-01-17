

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/presentation/api/models/driver_model/nearest_load_model.dart';
import 'package:ootms/presentation/screens/role/driver/find_load/find_load_method/find_load_modal_sheet.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CustomMapController extends GetxController {

  static CustomMapController get instance => Get.find<CustomMapController>();

  final Completer<GoogleMapController> googleMapController = Completer();
  CustomInfoWindowController infoWindowController = CustomInfoWindowController();

  final searchText = TextEditingController().obs;
  RxBool isSearched = false.obs;
  RxBool isTapped = false.obs;

  RxDouble userLatitude = 23.7814561.obs;
  RxDouble userLongitude = 90.4215143.obs;

  RxDouble targetLatitude = 0.0.obs;
  RxDouble targetLongitude = 0.0.obs;
  RxList<Marker> marker = <Marker>[].obs;
  List<Placemark> placeAddress = [];
  List<Location> locationCoOrdinates = [];

  double _truckBearing = 180; // Example bearing in degrees

  void updateLocation(double lat, double lng) {
    userLatitude.value = lat;
    userLongitude.value = lng;
  }

  void setTargetLocation(double lat, double lng) {
    log("++++++++++ Set Target Location+++++++++");
    targetLatitude.value = lat;
    targetLongitude.value = lng;
    log("${targetLatitude.value}, ${targetLongitude.value}");
  }

  CameraPosition get initialCameraPosition => CameraPosition(
    target: LatLng(userLatitude.value, userLongitude.value),
    zoom: 14.0,
  );

  CameraPosition get kRandom => CameraPosition(
      bearing: 180,
      target: isTapped.value
          ? LatLng(targetLatitude.value, targetLongitude.value)
          : LatLng(userLatitude.value, userLongitude.value),
      tilt: 59.440717697143555,
      zoom: 15);

  final List<Marker> list = [];

  var uuid = const Uuid();
  String sessionToken = '112233';
  RxList placesList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    marker.addAll(list);
    searchText.value.addListener(() {
      onChange();
    });
    super.onInit();
  }

  // double calculateBearing(LatLng start, LatLng end) {
  //   double deltaLongitude = end.longitude - start.longitude;
  //   double y = sin(deltaLongitude) * cos(end.latitude);
  //   double x = cos(start.latitude) * sin(end.latitude) -
  //       sin(start.latitude) * cos(end.latitude) * cos(deltaLongitude);
  //   double initialBearing = atan2(y, x);
  //   return (initialBearing * 180 / pi) % 360;
  // }

// Load custom truck icon

  Future<BitmapDescriptor> _loadTruckIcon(BuildContext context, iconPath) async {
    return await BitmapDescriptor.asset(
        ImageConfiguration(
            devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
        iconPath,
        height: 40, width: 40
    );
  }

  ///==================== Set Marker with Icon =================================
  setLocationMarker(double latitude, double longitude, String placeId, String iconPath, NearestLoadModel loadItems) async {
    final BitmapDescriptor customMarker = await _loadTruckIcon(Get.context!, iconPath);
    Marker newMarker = Marker(
      onTap: () {
        log("place id $placeId");
        showLocationDetails(loadItems: loadItems);
      },
      infoWindow: InfoWindow(title: placeId),
      icon: customMarker,
      markerId: MarkerId(placeId), // Use a unique MarkerId for each marker
      position: LatLng(latitude, longitude),
    );

    marker.add(newMarker);
    update();
  }
  setMarker(LatLng latLng, LatLng endLatLng, String placeId, String iconPath) async {
    final BitmapDescriptor customMarker = await _loadTruckIcon(Get.context!, iconPath);
    Marker newMarker = Marker(
      onTap: () {
      },
      infoWindow: InfoWindow(title: placeId),
      icon: customMarker,
      markerId: MarkerId(placeId), // Use a unique MarkerId for each marker
      position: LatLng(latLng.latitude, latLng.longitude),
      // rotation: calculateBearing(LatLng(latLng.latitude, latLng.longitude), LatLng(endLatLng.latitude, endLatLng.longitude)),
    );

    marker.add(newMarker);
    update();
  }

  customMarker(
      {required String markerId,
        required double latitude,
        required double longitude,
        required String infoTitle,
        String? iconPath,
        double? width,
        double? height}) async {
    Marker(
        markerId: MarkerId(markerId),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(
          title: infoTitle,
        ),
        icon: await MarkerIcon.pictureAsset(
            assetPath: iconPath!, width: width!, height: height!));
  }

  void onChange() {
    sessionToken ??= uuid.v4();
    getSuggestion(searchText.value.text);
  }

  void getSuggestion(String inputText) async {
    String kPlacesApiKey = "AIzaSyDUjNaRwWEUbn__efy3duv9cFQak66jI4o";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$inputText&key=$kPlacesApiKey&sessiontoken= $sessionToken';

    var response = await http.get(Uri.parse(request));

    log(response.body.toString());
    if (response.statusCode == 200) {
      placesList.value = jsonDecode(response.body.toString())['predictions'];
    } else {
      log("--------------------- Error -------------------");
      throw Exception('Failed to load data');
    }
  }

  checkDataDoubleOrString() async {
    isTapped.value = true;
    List searchedCoOrdinates = [];
    List inputDataList = searchText.value.text.split(',');

    double? doubleValue = double.tryParse(inputDataList.first);
    log("+++++++++++++++++++++${searchText.value}++++++++++++++++++++");

    if (doubleValue != null) {
      placeAddress = await placemarkFromCoordinates(
          double.parse(inputDataList.first), double.parse(inputDataList.last));
      searchedCoOrdinates.addAll(inputDataList);
      log("Coordinate to locations:...........................${placeAddress.first}");
    } else {
      locationCoOrdinates = await locationFromAddress(searchText.value.text);
      searchedCoOrdinates.addAll(locationCoOrdinates);
      log("Locations to Coordinates:...............${locationCoOrdinates.first}..............${locationCoOrdinates.last}");
    }
    targetLatitude.value = searchedCoOrdinates.first;
    targetLongitude.value = searchedCoOrdinates.last;
    marker.add(
      Marker(
          markerId: MarkerId("Search Location"),
          position: LatLng(searchedCoOrdinates.first, searchedCoOrdinates.last),
          infoWindow: InfoWindow(
              title: "Searched Location"
          )
      ),
    );
    final GoogleMapController controller = await googleMapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(kRandom));
    isSearched.value = false;
    isTapped.value = false;
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      log("Error ${error.toString()}");
    });
    return await Geolocator.getCurrentPosition();
  }

  getCurrentLocation() {
    getUserCurrentLocation().then((value) async {
      updateLocation(value.latitude, value.longitude);
      log("${value.floor}");
      log('My current location');
      log(
          "My Current Location:^^^^^^^^^^^^^^^^^^${value.latitude}, ${value.longitude}");

      List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.longitude);
      log("Placemarks: ============>>>>$placemarks");

      marker.add(Marker(
          markerId: MarkerId("My location"),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'My current location')));
      final GoogleMapController controller = await googleMapController.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(kRandom));
    });
  }
}