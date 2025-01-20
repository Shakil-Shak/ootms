
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/common/bottom_nav_controller.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/home/user_home_page.dart';

class AssignLoadController extends GetxController{

  RxBool isLoading = false.obs;
  final BottomNavController navController = Get.put(BottomNavController());

  Future<void> assignLoadDriver({context, String loadId = "",String driverId = ""}) async {
    isLoading.value = true;

    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];

    List<Map<String, String>> data = [
      {"load": loadId, "driver": driverId}
    ];

    var headers = {'Authorization': 'Bearer $token', 'Content-Type': 'application/json'};
    debugPrint("===============data $data");

    try {
      final response = await ApiClient.postData(
          ApiPaths.assignDriver, jsonEncode(data), headers: headers);
      debugPrint("Assign Load============response${response.statusCode}");
      if (response.statusCode == 201) {

        showCommonSnackbar(context, "New Load Request Created Successfully", isError: false);
        navController.valueIncrease(value: 0);
        animetedNavigationPush(UserHomePage(), context);

      }else {
        showCommonSnackbar(context, "No Truck found for this driver please assign another driver", isError: true);
      }
    } catch (e) {
      showCommonSnackbar(context, "Assign Driver Failed",
          isError: true);
      debugPrint("failed =-==================$e");
    } finally {
      isLoading.value = false;
    }
  }
}