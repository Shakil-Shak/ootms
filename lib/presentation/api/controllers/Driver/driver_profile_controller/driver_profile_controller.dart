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
  DriverProfileModel profileData =DriverProfileModel();
//====================================================================driver get profile
  Future<void> getProfileData() async {
    isLoading = true;

    log("================================================api heeted");
    final response = await apiService.getRequest(ApiPaths.profileUrl);

    log("================================================succesdfsdfsdfsdfss${response['statusCode']}");
    try {
      if (response is Map<String, dynamic>) {
        if (response['statusCode'] == 200) {
          final responseData = response['data']["attributes"];
          if (responseData != null && responseData is Map<String, dynamic>) {
            profileData = DriverProfileModel.fromJson(responseData);
            isLoading = false;
            log("================================================success${response['statusCode']}");
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

  driverFeedback(
      {required num ratting, required String messege, context}) async {
    print("topu");
    isLoading = true;
    update();
    String userId = await PrefsHelper.getString("userRole");

    Map<String, dynamic> body = {"comment": messege, "rating": ratting};

    try {
      var response = await apiService.otherPostRequest(
          ApiPaths.serviceFeedback(userId), jsonEncode(body));
      if (response["statusCode"] == "201") {
        showCommonSnackbar(context, "Feedback Added", isError: false);
        isSuccess = true;
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
