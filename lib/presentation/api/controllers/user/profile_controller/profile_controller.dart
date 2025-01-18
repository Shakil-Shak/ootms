import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/presentation/api/models/driver_model/equipment_model.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/shipping_history_model.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/api/models/user_model/load_request_model/load_request_model.dart';
import 'package:ootms/presentation/api/models/user_model/profile_model/get_profile_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/screens/role/user/home/user_home_page.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_shipping_history.dart';

import '../../../../components/common_snackbar.dart';
import '../../../../navigation/animeted_navigation.dart';
import '../../../models/user_model/shiping_model/current_shiping_model.dart';

class ProfileController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool isLoading = false;
  bool isSupportLoad = false;

  ProfileModel profileData = ProfileModel();
  bool isSupportFieldClear = false;

  ///=============>>> Find current location<<<==================
  String currentLocation = "";
  LatLng currentLatLng = const LatLng(0.0, 0.0);

  Future<String> getCurrentLocation() async {
    bool serviceEnabled;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "Location services are disabled.";
    }

    // Check and request permissions
    if (UserHomePage.permission == LocationPermission.denied) {
      UserHomePage.permission = await Geolocator.requestPermission();
      if (UserHomePage.permission == LocationPermission.denied) {
        return "Location permissions are denied.";
      }
    }

    if (UserHomePage.permission == LocationPermission.deniedForever) {
      return "Location permissions are permanently denied. Enable them in settings.";
    }

    Timer.periodic(const Duration(seconds: 10), (timer) async {
    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);


    // Log or process the location
    log("Location: ${position.latitude}, ${position.longitude}");
    currentLatLng = LatLng(position.latitude, position.longitude);

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    log("${placemarks.first.street},${placemarks.first.administrativeArea},${placemarks.first.locality},${placemarks.first.country}");

    currentLocation = "${placemarks.first.street},${placemarks.first.administrativeArea},${placemarks.first.locality},${placemarks.first.country}";
    notifyListeners();

      // Optionally, communicate with the app via the service
      // service.invoke("update", {
      //   "latitude": position.latitude,
      //   "longitude": position.longitude,
      // });
    });

    return currentLocation;
  }

  Future<void> postSupport(
      {required String title,
      required String content,
      required context}) async {
    isSupportLoad = true;
    notifyListeners();
    Map<String, dynamic> data = {
      "title": title,
      "content": content,
    };

    final response =
        await _apiService.otherPostRequest(ApiPaths.userSupport, data);

    if (response is Map<String, dynamic>) {
      if (response['statusCode'] == "201") {
        showCommonSnackbar(context, "Submited successful!");
        isSupportFieldClear = true;
        notifyListeners();
        isSupportLoad = false;
        notifyListeners();
      } else {
        isSupportLoad = false;
        notifyListeners();
      }
    } else {
      isSupportLoad = false;
      notifyListeners();
      log("Error: Response is not a Map<String, dynamic>");
    }
  }

  //===================================================get profile data

  Future<void> getProfileData() async {
    log("================================================successfull");
    isLoading = true;
    notifyListeners();

    final response = await _apiService.getRequest(ApiPaths.profileUrl);

    log("Response: $response");

    if (response is Map<String, dynamic>) {
      if (response['statusCode'] == 200) {
        final responseData = response['data'];
        if (responseData != null && responseData is Map<String, dynamic>) {
          profileData = ProfileModel.fromJson(responseData['attributes']);
          isLoading = false;
          notifyListeners();
        }
      } else {
        isLoading = false;
        notifyListeners();
        log("================================================fail");
        log("Error: Unexpected status code ${response['statusCode']}");
      }
    } else {
      isLoading = false;
      notifyListeners();
      log("Error: Response is not a Map<String, dynamic>");
    }
  }

//====================================================current shiping method

  List<CurrentShippingModel> currentShipData = [];
  bool isCurrentShip = false;

  Future<void> getCurrentShipData({required context}) async {
    isCurrentShip = true;
    notifyListeners();

    final response = await _apiService.getRequest(ApiPaths.currentShiping);
    log("Full Response: $response");

    if (response is Map<String, dynamic>) {
      log("================================================successfull");

      if (response['statusCode'] == 200) {
        final responseData = response['data'];
        log("responseData: $responseData");
        if (responseData != null && responseData is Map<String, dynamic>) {
          List responseData = response['data']["attributes"]["loadRequests"];

          currentShipData = responseData
              .map((items) => CurrentShippingModel.fromJson(items))
              .toList();

          print("success");
          isCurrentShip = false;
          notifyListeners();
        } else {
          isCurrentShip = false;
          notifyListeners();
          log("Error: Response data is null or not a Map<String, dynamic>");
        }
      } else {
        log("Error: statusCode is not 200, received ${response['statusCode']}");
        isCurrentShip = false;
        notifyListeners();
      }
    } else {
      isCurrentShip = false;
      notifyListeners();
      log("Error: Response is not a Map<String, dynamic>");
    }
  }

  //================ shipping histopry data

  List<ShippingHistoryModel> shippingHistoryData = [];

  Future<void> getShippingHistoryData({required context}) async {
    isLoading = true;
    notifyListeners();

    final response = await _apiService.getRequest(ApiPaths.shippingHistory);
    log("Full Response: $response");

    if (response is Map<String, dynamic>) {
      log("================================================successfull");

      if (response['statusCode'] == 200) {
        final responseData = response['data'];
        log("responseData: $responseData");
        if (responseData != null && responseData is Map<String, dynamic>) {
          List responseData =
              response['data']?["attributes"]?["loadRequests"] ?? [];
          shippingHistoryData = responseData
              .map((items) => ShippingHistoryModel.fromJson(items))
              .toList();
          animetedNavigationPush(UserShippingHistoryPage(), context);
          print("success");
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
          log("Error: Response data is null or not a Map<String, dynamic>");
        }
      } else {
        log("Error: statusCode is not 200, received ${response['statusCode']}");
        isLoading = false;
        notifyListeners();
      }
    } else {
      isLoading = false;
      notifyListeners();
      log("Error: Response is not a Map<String, dynamic>");
    }
  }

  //==================================================get load request data
  List<LoadRequestModel> loadRequestData = [];
  bool isLoadRequest = false;
  bool isMyLoad = false;

  Future<void> getLoadRequestData(
      {required context,
      bool requestType = false,
      bool callFromHome = false}) async {
    isLoadRequest = true;
    if (!callFromHome) {
      notifyListeners();
    }
    try {
      final response = await _apiService
          .getRequest(ApiPaths.userLoadRequest(requestType: requestType));

      isMyLoad = requestType;

      if (response != null &&
          response['statusCode'] != null &&
          response['statusCode'] == 200) {
        List responseData =
            response['data']?["attributes"]?["loadRequests"] ?? [];
        log("responseData: $responseData");
        loadRequestData = responseData
            .map((items) => LoadRequestModel.fromJson(items))
            .toList();
        log("===========================================================loadRequestData: $loadRequestData");
      } else {
        log("Error: statusCode is not 200 or response is null");
      }
    } catch (e) {
      log("$e");
    } finally {
      isLoadRequest = false;
      notifyListeners();
    }
  }

  //===========================================================================load request status
  loadRequestStatus() {}
  //===============================================================================get equipment data
  List<EquipmentModel> equipmentData = [];
  getEquipmentData() async {
    print(
        "topu================================================================");
    isLoading = true;
    notifyListeners();

    try {
      print("=======================================ressdflksadflksdjfksdjf");
      final response = await _apiService.getRequest(ApiPaths.equipment);
      print("=======================================response$response");

      if (response != null &&
          response['statusCode'] != null &&
          response['statusCode'] == "201") {
        log("================================================successfull");
        List responseData = response['data']["attributes"] ?? [];
        log("responseData: $responseData");
        equipmentData = responseData
            .map((items) => EquipmentModel.fromJson(items))
            .toList();
        log("===========================================================equipmentData: $equipmentData");
      } else {
        log("Error: statusCode is not 200 or response is null");
      }
    } catch (e) {
      log("$e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
