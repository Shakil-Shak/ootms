import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/user_model/prefered_driver_model.dart/prefered_driver_model.dart';
import 'package:ootms/presentation/api/models/user_model/prefered_driver_model.dart/search_prefered_driver_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class PreferedDriverController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  static PreferedDriverController get instance => Get.put(PreferedDriverController());
  bool isLoading = false;

  List<SearchPreferredDriverModel> preferredDriverList = [];

  getPreferedDriver() async {
    isLoading = true;
    update();
    try {
      var response = await ApiClient.getData(
          ApiPaths.getPreferedDriver(searchController.text));
      if (response.statusCode == 200) {

        final Map<String, dynamic> responseBody = response.body;

        final List<dynamic> results = responseBody["data"]["attributes"]["results"];

        preferredDriverList.clear();
        preferredDriverList = results
            .map((result) => SearchPreferredDriverModel.fromJson(result))
            .toList();
 
        update();

        isLoading = false;
        update();
      } else {
        debugPrint(
            "Failed to fetch preferred drivers. Status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("An error occurred while fetching preferred drivers: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
