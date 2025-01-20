
import 'dart:developer';

import 'package:get/get.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/models/user_model/nearest_driver_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class FindNearestDriverController extends GetxController{

  static FindNearestDriverController get instance => Get.find<FindNearestDriverController>();

  NearestDriverModel nearestDriverModel = NearestDriverModel();
  List nearestDriverList = [];
  RxBool isLoading = false.obs;

  Future<void> findNearestDriver({required String createdLoadId}) async {
    nearestDriverList.clear();
    isLoading.value = true;

    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];


    var mainHeaders = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await ApiClient.getData(
          // "${ApiPaths.nearestDriver}$createdLoadId",
          "${ApiPaths.nearestDriver}678cde18204e2a0eb328f4ad",
          headers: mainHeaders);

      var responseBody = response.body;

      if (response.statusCode == 200) {
        CustomMapController.instance.marker.clear();
        final List data = responseBody['data']["driverInfo"];

        // nearestLoadList = List<NearestLoadModel>.from(data.map((toElement)=> NearestLoadModel.fromJson(toElement)));

        nearestDriverList = data
            .map((item) =>
            NearestDriverModel.fromJson(item as Map<String, dynamic>))
            .toList();

        int count = 0;
        for (NearestDriverModel loadItems in nearestDriverList) {
          log("Set Marker${loadItems.location.coordinates.first}, ${loadItems.location.coordinates.last}");

          CustomMapController.instance.setDriverLocationMarker(
              loadItems.location.coordinates.last.toDouble(),
              loadItems.location.coordinates.first.toDouble(),
              'marker_${count++}',
              AppIcons.greenTruck,
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