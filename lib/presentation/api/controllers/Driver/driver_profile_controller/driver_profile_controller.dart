import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/helpers/prefs_helper.dart';
import 'package:ootms/presentation/api/models/driver_model/driver_profile_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../components/common_snackbar.dart';
import '../../../service/api_services.dart';

class DriverProfileController extends GetxController {
  List<String>? userDetails;
  static DriverProfileController get instance =>
      Get.put(DriverProfileController());
  final ApiService apiService = ApiService();
  bool isLoading = false;
  bool isSuccess = false;
  DriverProfileModel profileData = DriverProfileModel();
//====================================================================driver get profile
  Future<void> getProfileData() async {
    isLoading = true;

    final response = await apiService.getRequest(ApiPaths.profileUrl);
    try {
      if (response is Map<String, dynamic>) {
        if (response['statusCode'] == 200) {
          final responseData = response['data']["attributes"];
          print(
              "========================================================data $responseData");
          if (responseData != null && responseData is Map<String, dynamic>) {
            profileData = DriverProfileModel.fromJson(responseData);
            isLoading = false;
            log("================================================success$profileData");
          }
        } else {
          isLoading = false;

          log("================================================fail");
          log("Error: Unexpected status code ${response['statusCode']}");
        }
      } else {
        log("Error: Response is not a Map<String, dynamic>");
      }
    } catch (e) {
      debugPrint("===================================================error $e");
    } finally {
      isLoading = false;
    }
  }

  //==========================================================================driver feedback
  bool isFeedbackComplete = false;

  driverAppFeedback(
      {required num ratting, required String messege, context}) async {
    print("topu");
    isLoading = true;
    update();
    String userId = await PrefsHelper.getString("userId");

    Map<String, dynamic> body = {"comment": messege, "rating": ratting};

    try {
      var response = await apiService.otherPostRequest(
          ApiPaths.appFeedback, jsonEncode(body));
      if (response["statusCode"] == "201") {
        showCommonSnackbar(context, "Feedback Added", isError: false);
        isSuccess = true;
        update();
        isLoading = false;
        update();
      } else {
        print("error");
        showCommonSnackbar(context, "Feedback Added Failed", isError: true);
      }
    } catch (e) {
      print("error$e");
      showCommonSnackbar(context, "Something went wrong", isError: true);
    } finally {
      isLoading = false;
      update();
    }
  }
}
