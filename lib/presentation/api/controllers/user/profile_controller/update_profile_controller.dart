import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../navigation/animeted_navigation.dart';
import '../../../../screens/role/driver/driver_bottom_navigation.dart';
import '../../../../screens/role/user/user_bottom_navigation.dart';
import '../../../sharePrefarences/local_storage_save.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  List<String>? userDetails;
  String? image;
  RxBool isUpdated = false.obs;

  getProfileImage() async {
    image = await OtherHelper.openGallery();
    update();
    debugPrint("==============================image${File(image ?? "")}");
  }
  //===================================================update profile

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String address,
  }) async {
    isLoading.value = true;

    userDetails = await getUserAcessDetails();
    String accesstoken = userDetails![0] ?? "";

    // Data fields
    Map<String, String> body = {
      "fullName": name,
      "email": email,
      "phoneNumber": phone,
      "address": address,
    };
    Map<String, String> header = {"Authorization": "Bearer $accesstoken"};

    List<MultipartBody> multipartBody = [
      MultipartBody("profileImage", File(image!)),
    ];
    debugPrint("=======================================imagePath: $image");
    var response = await ApiClient.putMultipartData(
        method: "PUT",
        ApiPaths.updateProfileUrl,
        body,
        multipartBody: multipartBody,
        headers: header);
    debugPrint(
        "=======================================================body $body");
    debugPrint(
        "=======================================================header $header");
    if (response.statusCode == 200) {
      var responseData = response.body is String
          ? jsonDecode(response.body)["data"]
          : response.body["data"];

      Get.snackbar("Update Profile", "Update Profile Successfull");
      isLoading.value = false;
      isUpdated.value = true;
    } else {
      Get.snackbar("Update Profile", "Update Profile Faild");

      isLoading.value = false;
    }
  }

  //===================================================update profile

  Future<void> completeProfile({
    required String phone,
    required String taxId,
    required String address,
    required bool user,
    required context,
  }) async {
    isLoading.value = true;

    userDetails = await getUserAcessDetails();
    String accesstoken = userDetails![0] ?? "";

    // Data fields
    Map<String, String> body = {
      "phoneNumber": phone,
      "taxid": taxId,
      "address": address,
    };
    Map<String, String> header = {"Authorization": "Bearer $accesstoken"};

    List<MultipartBody> multipartBody = [
      MultipartBody("profileImage", File(image!)),
    ];
    try {
      var response = await ApiClient.putMultipartData(
          method: "PUT",
          ApiPaths.completeProfile,
          body,
          multipartBody: multipartBody,
          headers: header);
      debugPrint(
          "=======================================================body $body");
      debugPrint(
          "=======================================================header $header");
      if (response.statusCode == 201) {
        // var responseData = response.body is String
        //     ? jsonDecode(response.body)["data"]
        //     : response.body["data"];
        if (user == true) {
          animetedNavigationPush(const UserRootPage(), context);
        } else {
          animetedNavigationPush(const DriverRootPage(), context);
        }

        Get.snackbar("Complete Profile", "Complete Profile Successfull");
      } else {
        Get.snackbar("Complete Profile", response.body["message"]);
      }
    } catch (e) {
      Get.snackbar("Complete Profile", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
