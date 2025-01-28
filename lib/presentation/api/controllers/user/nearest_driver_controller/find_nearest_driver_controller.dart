
import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/models/user_model/nearest_driver_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/create_load/user_assign_load.dart';

class FindNearestDriverController extends GetxController{

  static FindNearestDriverController get instance => Get.find<FindNearestDriverController>();

  NearestDriverModel nearestDriverModel = NearestDriverModel();
  List nearestDriverList = [];
  LoadLocationModel loadLocationInfo = LoadLocationModel();
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
          "${ApiPaths.nearestDriver}$createdLoadId",
          // "${ApiPaths.nearestDriver}678cde18204e2a0eb328f4ad",
          headers: mainHeaders);

      var responseBody = response.body;

      if (response.statusCode == 200) {
        CustomMapController.instance.marker.clear();
        final List driverInfoData = responseBody['data']["driverInfo"];
        var loadLocationInfoData = responseBody['data']["shipperLocation"];

        // nearestLoadList = List<NearestLoadModel>.from(data.map((toElement)=> NearestLoadModel.fromJson(toElement)));

        nearestDriverList = driverInfoData
            .map((item) =>
            NearestDriverModel.fromJson(item as Map<String, dynamic>))
            .toList();

        loadLocationInfo = LoadLocationModel.fromJson(loadLocationInfoData);

        CustomMapController.instance.setMarker(
          LatLng(loadLocationInfo.coordinates.last.toDouble(),
            loadLocationInfo.coordinates.first.toDouble()),
            'marker_loadLocation',
            AppIcons.locationMarker,
          );

        CustomMapController.instance.updateLocation(loadLocationInfo.coordinates.last.toDouble(), loadLocationInfo.coordinates.first.toDouble());

        int count = 0;
        for (NearestDriverModel loadItems in nearestDriverList) {
          log("Set Marker${loadItems.location.coordinates.first}, ${loadItems.location.coordinates.last}");

          await CustomMapController.instance.setDriverLocationMarker(
              loadItems.location.coordinates.last.toDouble(),
              loadItems.location.coordinates.first.toDouble(),
              'marker_${count++}',
            loadItems.truck.palletSpace == loadItems.truck.availablePalletSpace? AppIcons.greenTruck : loadItems.truck.availablePalletSpace == 0? AppIcons.redTruck : AppIcons.yellowTruck,
              loadItems,
            onTap: () {
              UserAssignLoadPage.loadDetails = loadItems;
              UserAssignLoadPage.createdLoadId = createdLoadId;
              animetedNavigationPush(UserAssignLoadPage(), Get.context!);
            },
          );

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