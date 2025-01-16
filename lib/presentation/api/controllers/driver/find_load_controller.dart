
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/presentation/api/controllers/driver/google_map_controller.dart';
import 'package:ootms/presentation/api/models/driver_model/nearest_load_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class FindLoadController extends GetxController{

  static FindLoadController get instance => Get.put(FindLoadController());

  NearestLoadModel nearestLoadModel = NearestLoadModel();
  List nearestLoadList = [];
  RxBool isLoading = false.obs;

  Future<void> findNearestLoad() async {
    nearestLoadList.clear();
    isLoading.value = true;

    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];

    Map<String, dynamic> body = {
      // "driverName": "",
      // "truckNumber": "",
      "trailerSize": 50,
      "palletSpace": 30,
      "location": [
        90.42394897253224, // longitute
        23.769075184598087 // lattitute
      ]
    };

    var mainHeaders = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      final response = await ApiClient.postData(ApiPaths.nearestLoad, jsonEncode(body), headers: mainHeaders);

      var responseBody = response.body;

      if (response.statusCode == 200) {
        log("Response Type: ${responseBody.runtimeType}");
        log("Response Body: ${responseBody["data"].length}");
        // log("Response Body: $responseBody");

          final List data = responseBody['data'];

        // nearestLoadList = List<NearestLoadModel>.from(data.map((toElement)=> NearestLoadModel.fromJson(toElement)));
        nearestLoadList = data.map((item) => NearestLoadModel.fromJson(item as Map<String, dynamic>)).toList();

        int count = 0;
        for(NearestLoadModel loadItems in nearestLoadList){

          log("Parsed nearestLoadList: ${loadItems.location.type}");

          log("Set Marker${loadItems.location.coordinates.first}, ${loadItems.location.coordinates.last}");
          count ++;
          CustomMapController.instance.marker.add(
              Marker(
                markerId: MarkerId('tapped place - $count'),
                position: LatLng(loadItems.location.coordinates.first.toDouble(), loadItems.location.coordinates.last.toDouble()),
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                infoWindow: InfoWindow(
                    title: "${loadItems.location.coordinates.first}, ${loadItems.location.coordinates.last}"
                ),
              )
          );
          log("CustomMapController.instance.marker ${CustomMapController.instance.marker.length}");
        }
      } else {
        Get.snackbar("Error:", "Something went wrong, try again!");
      }
    } catch (e, s) {
      log("Catch Error: $e");
      log("Catch Error: $s");
    }finally{
      isLoading.value = false;
    }
  }

}