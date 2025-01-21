
import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/models/user_model/bol_tracking_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/service/socket_service.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/screens/role/user/home/user_home_page.dart';

class LiveTrackingController extends GetxController{

  RxBool isLoading =  false.obs;
  BOLTrackingModel bolTrackingModel = BOLTrackingModel();
  List trackingItemsList = [];

  TextEditingController bolTextController = TextEditingController();

  Future<void> findTrackingLoad() async {
    isLoading.value = true;

    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];


    var mainHeaders = {
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await ApiClient.getData(
          "${ApiPaths.findByBOL}${bolTextController.text}",
          headers: mainHeaders);

      var responseBody = response.body;

      if (response.statusCode == 200) {
        
        CustomMapController.instance.marker.clear();
        final List trackingLoadInfo = responseBody['data'];

        trackingItemsList = trackingLoadInfo.map((item) => BOLTrackingModel.fromJson(item as Map<String, dynamic>)).toList();

        int count = 0;
        for (BOLTrackingModel loadItems in trackingItemsList) {
          LatLng? driverLiveLocation = await SocketServices.getLocation(userId: loadItems.user);
          LatLng driverLocation = LatLng(loadItems.driver.location.coordinates.last.toDouble(), loadItems.driver.location.coordinates.first.toDouble());

          Timer.periodic(const Duration(seconds: 01), (timer) async {
            CustomMapController.instance.updateLocation(loadItems.driver.location.coordinates.last.toDouble(), loadItems.driver.location.coordinates.first.toDouble());

            CustomMapController.instance.setDriverLocationTrackingMarker(
              (driverLiveLocation != null)? driverLiveLocation : driverLocation,
              LatLng(loadItems.location.coordinates.last.toDouble(), loadItems.location.coordinates.first.toDouble()),
              'marker_${count++}',
              AppIcons.redTruck,
              loadItems,
            );
          });

          CustomMapController.instance.setMarker(LatLng(loadItems.location.coordinates.last, loadItems.location.coordinates.first), "Load Location", AppIcons.locationMarker);

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