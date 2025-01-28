import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/user_model/prefered_driver_model.dart/prefered_driver_model.dart';
import 'package:ootms/presentation/api/models/user_model/prefered_driver_model.dart/search_prefered_driver_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';

class PreferedDriverController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  static PreferedDriverController get instance => Get.put(PreferedDriverController());
  bool isLoading = false;
  bool isAdding = false;
  bool isMyDriverLoading = false;

  List<SearchPreferredDriverModel> searchPreferredDriverList = [];
  List<PreferredDriverModel> myPreferredDriverList = [];

  ///====================== Get  Preferred Driver ============================

  getPreferredDriver() async {
    searchPreferredDriverList.clear();
    isLoading = true;
    update();
    try {
      var response = await ApiClient.getData(
          ApiPaths.getPreferedDriver(searchController.text));
      if (response.statusCode == 200) {

        final Map<String, dynamic> responseBody = response.body;

        log("===================================================");

        final List<dynamic> results = responseBody["data"]["attributes"]["results"];
        searchPreferredDriverList = results.map((result) => SearchPreferredDriverModel.fromJson(result)).toList();
 
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

  ///====================== Get My Preferred Driver ============================

  getMyPreferredDriver() async {
    myPreferredDriverList.clear();
    isMyDriverLoading = true;
    update();
    try {
      var response = await ApiClient.getData(ApiPaths.getMyPreferredDriver);
      if (response.statusCode == 200) {

        final Map<String, dynamic> responseBody = response.body;

        log("===================================================");

        final List<dynamic> results = responseBody["data"]["attributes"]["results"];
        myPreferredDriverList = results.map((result) => PreferredDriverModel.fromJson(result)).toList();

        update();

        isMyDriverLoading = false;
        update();
      } else {
        debugPrint(
            "Failed to fetch preferred drivers. Status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("An error occurred while fetching preferred drivers: $e");
    } finally {
      isMyDriverLoading = false;
      update();
    }
  }

  addPreferredDriver(context, {required String driverId}) async {
    isAdding = true;
    update();

    Map<String, String> body ={
      // "driver": "6795b5616d044a8b0580c1f5",
      "driver": driverId,
    };
    try {
      var response = await ApiClient.postData(ApiPaths.addPreferredDriver, body);
      if (response.statusCode == 201) {

        final Map<String, dynamic> responseBody = response.body;

        log("Response Body ======>>>> $responseBody}");

        final List<dynamic> results = responseBody["data"]["attributes"]["results"];
        myPreferredDriverList.addAll(results.map((result) => PreferredDriverModel.fromJson(result)).toList());

        update();

        isAdding = false;
        update();
      } else {
        showCommonSnackbar(context, "Preferred Driver already exists", isError: true);
        debugPrint(
            "Failed to fetch preferred drivers. Status: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("An error occurred while fetching preferred drivers: $e");
      showCommonSnackbar(context, "$e", isError: true);
    } finally {
      isAdding = false;
      update();
    }
  }
}
