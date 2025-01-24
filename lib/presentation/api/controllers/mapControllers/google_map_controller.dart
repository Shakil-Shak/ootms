

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as Math;

import 'package:custom_info_window/custom_info_window.dart';
import 'package:custom_marker/marker_icon.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/presentation/api/models/driver_model/nearest_load_model.dart';
import 'package:ootms/presentation/api/models/user_model/nearest_driver_model.dart';
import 'package:ootms/presentation/api/service/socket_service.dart';
import 'package:ootms/presentation/screens/role/driver/find_load/find_load_method/find_load_modal_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class CustomMapController extends GetxController {

  static CustomMapController get instance => Get.find<CustomMapController>();

  final Completer<GoogleMapController> googleMapController = Completer();
  CustomInfoWindowController infoWindowController = CustomInfoWindowController();
  //========================filter value
  RxDouble sliderValue = 0.0.obs;
  RxDouble minValue = 0.0.obs;
  RxDouble maxValue = 0.0.obs;

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

  RxString userCurrentLocation = "".obs;
  RxDouble currentLatitude = 0.0.obs;
  RxDouble currentLongitude = 0.0.obs;

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
    zoom: 16.0,
  );

  CameraPosition get kRandom => CameraPosition(
      bearing: 180,
      target: isTapped.value
          ? LatLng(targetLatitude.value, targetLongitude.value)
          : LatLng(userLatitude.value, userLongitude.value),
      tilt: 59.440717697143555,
      zoom: 15);


  var uuid = const Uuid();
  String sessionToken = '112233';
  RxList placesList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
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

  Future<BitmapDescriptor> _loadTruckIcon(BuildContext context, iconPath, {double iconHeight = 40}) async {
    return await BitmapDescriptor.asset(
        ImageConfiguration(
            devicePixelRatio: MediaQuery.of(context).devicePixelRatio),
        iconPath,
        height: iconHeight, width: 40
    );
  }

  ///==================== Set Driver Marker For Live Tracking===================

  double calculateBearing(LatLng start, LatLng end) {
    double deltaLongitude = end.longitude - start.longitude;
    double y = Math.sin(deltaLongitude) * Math.cos(end.latitude);
    double x = Math.cos(start.latitude) * Math.sin(end.latitude) -
        Math.sin(start.latitude) * Math.cos(end.latitude) * Math.cos(deltaLongitude);
    double initialBearing = Math.atan2(y, x);
    return (initialBearing * 160 / Math.pi) % 360;
  }

  setDriverLocationTrackingMarker(LatLng driverLatLang, LatLng destinationLatLang, String placeId, String iconPath, {VoidCallback? onTap}) async {
    final BitmapDescriptor customMarker = await _loadTruckIcon(Get.context!, iconPath, iconHeight: 60);
    Marker newMarker = Marker(
      onTap: onTap,
      infoWindow: InfoWindow(title: placeId),
      icon: customMarker,
      markerId: MarkerId(placeId), // Use a unique MarkerId for each marker
      position: LatLng(driverLatLang.latitude, driverLatLang.longitude),
      rotation: calculateBearing(driverLatLang, destinationLatLang)
    );

    marker.add(newMarker);
    update();
  }

  ///==================== Set Driver Marker with Icon ==========================
  setDriverLocationMarker(double latitude, double longitude, String placeId, String iconPath, NearestDriverModel loadItems, {VoidCallback? onTap}) async {
    final BitmapDescriptor customMarker = await _loadTruckIcon(Get.context!, iconPath, iconHeight: 60);
    Marker newMarker = Marker(
      onTap: onTap,
      infoWindow: InfoWindow(title: placeId),
      icon: customMarker,
      markerId: MarkerId(placeId), // Use a unique MarkerId for each marker
      position: LatLng(latitude, longitude),
    );

    marker.add(newMarker);
    update();
  }

  ///==================== Set Load Marker with icon ==========================

  setLoadLocationMarker(double latitude, double longitude, String placeId, String iconPath, NearestLoadModel loadItems) async {
    final BitmapDescriptor customMarker = await _loadTruckIcon(Get.context!, iconPath);
    Marker newMarker = Marker(
      onTap: () {
        log("place id $placeId");
        showLocationDetails(loadItems: loadItems,);
      },
      infoWindow: InfoWindow(title: placeId),
      icon: customMarker,
      markerId: MarkerId(placeId), // Use a unique MarkerId for each marker
      position: LatLng(latitude, longitude),
    );

    marker.add(newMarker);
    update();
  }


  setMarker(LatLng latLng, String placeId, String iconPath, {double iconHeight = 50}) async {
    final BitmapDescriptor customMarker = await _loadTruckIcon(Get.context!, iconPath, iconHeight: iconHeight);
    Marker newMarker = Marker(
      onTap: () {
      },
      infoWindow: const InfoWindow(title: "Load Location"),
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
    PermissionStatus status = await Permission.location.status;
    if (status.isGranted) {
      log("<<<======Permission is granted=====>>>");
    } else {
      await Geolocator.requestPermission()
          .then((value) {})
          .onError((error, stackTrace) {
        log("Error ${error.toString()}");
      });
    }
    return await Geolocator.getCurrentPosition();
  }

  getCurrentLocation({bool isOnDuty = false}) async {
    callSocket() async {
      if(isOnDuty == true){
        debugPrint("===isonduity ==$isOnDuty");
        await SocketServices.sendLocation(latitude: currentLatitude.value, longitude: currentLongitude.value);
        log("======================socket on: emitting location");
      }
    }
    
    Timer.periodic(const Duration(seconds: 03), (timer) async {
     getUserCurrentLocation().then((value) async {
      updateLocation(value.latitude, value.longitude);
      log("My Current Location:^^^^${value.latitude}, ${value.longitude}");
      List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude, value.longitude);
      currentLatitude.value = value.latitude;
      currentLongitude.value = value.longitude;
      userCurrentLocation.value = "${placemarks.first.street}, ${placemarks.first.name}, ${placemarks.first.locality}, ${placemarks.first.country}";
      return userCurrentLocation.value;
    });
     await callSocket();
    });
  }


  ///=================>>>> Polyline Methods <<<<<<==============================

  final RxSet<Polyline> polyLines = <Polyline>{}.obs;
  // LatLng origin = LatLng(23.776176, 90.425674); // San Francisco
  // LatLng destination = LatLng(23.3999373281255, 90.4387651926279); // Los Angeles
  final String apiKey = "AIzaSyCZ6YIiEkZnGVCQUyFIKsu3RdOJ49GVeLU"; // Replace with your API key
  double firstStepEndLat = 0.0;
  double firstStepEndLng = 0.0;



  Future<void> getRoute({required LatLng origin, required LatLng destination}) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&key=$apiKey'));

    log("Get route: ${response.statusCode}");
    // log("Response ========>>>> ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data["routes"].isNotEmpty) {
        final route = data["routes"][0]["overview_polyline"]["points"];
        final points = decodePolyline(route);

        var firstStepEndLocation = data['routes'][0]['legs'][0]['steps'][0]['end_location'];
        firstStepEndLat = firstStepEndLocation['lat'];
        firstStepEndLng = firstStepEndLocation['lng'];

       setDriverLocationTrackingMarker(
          origin,
          LatLng(firstStepEndLat, firstStepEndLng),
          'Loaded Truck',
          AppIcons.redTruck,
        );

        polyLines.add(
          Polyline(
            polylineId: PolylineId("route"),
            points: points,
            color: Colors.red,
            width: 5,
          ),
        );
        polyLines.refresh(); // Notify listeners
      }
    } else {
      log("Failed to fetch route: ${response.body}");
    }
  }


  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

}