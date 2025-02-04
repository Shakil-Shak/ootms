import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';

import '../../../sharePrefarences/local_storage_save.dart';

class OnduityController extends GetxController {
  static OnduityController get instance => Get.find<OnduityController>();
  Rx<TextEditingController> truckIdController = TextEditingController().obs;
  Rx<TextEditingController> trailerIdController = TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxBool isOffDuityLoad = false.obs;
  RxBool isONDuity = false.obs;

  //=======================================onduity
  onDuity({lat, lan, context}) async {
    isLoading.value = true;
    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];

    Map<String, String> header = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };
    print("==========================================topu");
    Map<String, dynamic> body = {
      "isOnDuty": true,
      "location": {
        "type": "Point",
        "coordinates": [lan, lat]
      },
      "truckId": truckIdController.value.text,
      "trailerId": trailerIdController.value.text,
    };
    print("=========================================body${jsonEncode(body)}");
    try {
      var response = await ApiClient.patchData(
          ApiPaths.onDuity, jsonEncode(body),
          headers: header);

      if (response.statusCode == 200) {
        isLoading.value = false;
        isONDuity.value = true;
        showCommonSnackbar(context, "The Driver is ON-Duity");
        CustomMapController.instance
            .getCurrentLocation(isOnDuty: isONDuity.value);

        print(
            "=========================================bodytopu${response.statusCode.runtimeType}}");
      } else {
        showCommonSnackbar(context, "The Driver is ON-Duity Failed",
            isError: true);
      }
    } catch (e) {
      debugPrint("==================================================error$e");
      isLoading.value = false;
    }
  }

  //=======================================onduity
  offDuity({context}) async {
    isOffDuityLoad.value = true;
    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];

    Map<String, String> header = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };
    print("==========================================topu");
    Map<String, dynamic> body = {
      "isOnDuty": false,
    };
    try {
      var response = await ApiClient.patchData(
          ApiPaths.onDuity, jsonEncode(body),
          headers: header);
      if (response.statusCode == 200) {
        isONDuity.value = false;

        CustomMapController.instance
            .getCurrentLocation(isOnDuty: false);
        showCommonSnackbar(context, "The Driver is Off-Duity");

        print(
            "=========================================bodytopu${response.statusCode.runtimeType}}");
      } else {
        showCommonSnackbar(context, "The Driver is Off-Duity Failed",
            isError: true);
      }
    } catch (e) {
      isOffDuityLoad.value = false;
      debugPrint("==================================================error$e");
    }
  }
}
