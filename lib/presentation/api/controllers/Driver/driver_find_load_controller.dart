import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../helpers/prefs_helper.dart';
import '../../../components/common_snackbar.dart';

class DriverFindLoadController extends GetxController {
  //===============================================driver load request
  bool isRequestLoad = false;
  loadRequest({required String loadId, context}) async {
    isRequestLoad = true;
    update();
    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];
    String truckId = await PrefsHelper.getString("truckId");
    debugPrint("truckId===$truckId");
    List<Map<String, dynamic>> body = [
      {"load": loadId, "truck": "678f762f01593b753eb13d8d"}
    ];
    Map<String, String> header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await ApiClient.postData(
          ApiPaths.loadRequestFromDriver, jsonEncode(body),
          headers: header);
      print(
          "==============================================statuscode${response.statusCode}");
      if (response.statusCode == 200) {
        isRequestLoad = false;
        update();
        showCommonSnackbar(context, "Load Request Successfull");
        Get.back();
      } else {
        showCommonSnackbar(context, "Load Request Failed");

        isRequestLoad = false;
        update();
      }
    } catch (e) {
      showCommonSnackbar(context, "Error : $e");

      isRequestLoad = false;
      update();
    }
  }
}
