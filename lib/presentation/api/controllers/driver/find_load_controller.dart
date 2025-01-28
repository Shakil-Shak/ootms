import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/models/driver_model/nearest_load_model.dart';
import 'package:ootms/presentation/api/models/truck_info_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class FindLoadController extends GetxController {
  static FindLoadController get instance => Get.put(FindLoadController());

  NearestLoadModel nearestLoadModel = NearestLoadModel();
  List nearestLoadList = [];
  List truckInfoList = [];

  RxBool isLoading = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController trailercontroller = TextEditingController();
  TextEditingController palletSpacesController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController availabilityController = TextEditingController();

  Future<void> findNearestLoad() async {
    nearestLoadList.clear();
    isLoading.value = true;

    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];

    Map<String, dynamic> body = {
      // "driverName": "",
      "truckNumber": numberController.text,
      "trailerSize": int.parse(trailercontroller.text),
      "palletSpace": int.parse(palletSpacesController.text),
      "shipperLocation": [
        CustomMapController.instance.currentLongitude.value,
        CustomMapController.instance.currentLatitude.value
      ]
    };

    var mainHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      final response = await ApiClient.postData(
          ApiPaths.nearestLoad, jsonEncode(body),
          headers: mainHeaders);

      var responseBody = response.body;

      if (response.statusCode == 200) {
        CustomMapController.instance.marker.clear();
        log("Response Type: ${responseBody.runtimeType}");
        log("Response Body: ${responseBody["data"].length}");

        final List data = responseBody['data']["result"];
        final List truckInfo = responseBody['data']['truckInfo'];

        // nearestLoadList = List<NearestLoadModel>.from(data.map((toElement)=> NearestLoadModel.fromJson(toElement)));
        nearestLoadList = data
            .map((item) =>
                NearestLoadModel.fromJson(item as Map<String, dynamic>))
            .toList();

        truckInfoList = truckInfo
            .map(
                (item) => TruckInfoModel.fromJson(item as Map<String, dynamic>))
            .toList();

        int count = 1;
        for (NearestLoadModel loadItems in nearestLoadList) {
          log("Set Marker${loadItems.shipperLocation.coordinates.first}, ${loadItems.shipperLocation.coordinates.last}");

          CustomMapController.instance.setLoadLocationMarker(
              loadItems.shipperLocation.coordinates.last.toDouble(),
              loadItems.shipperLocation.coordinates.first.toDouble(),
              'Load_${count++}',
              "assets/icons/findLoadIcon.png",
              loadItems);

          log("CustomMapController.instance.marker ${CustomMapController.instance.marker.length}");
        }
      } else {
        Get.snackbar("Error:", "Something went wrong, try again!");
      }
    } catch (e, s) {
      log("Catch Error: $e");
      log("Catch Error: $s");
    } finally {
      isLoading.value = false;
    }
  }


}
