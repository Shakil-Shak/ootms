import 'dart:convert';
import 'dart:developer';
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
    required String cdlNumber,
    required String truckNumber,
    required String trailerSize,
    required String palletSpaces,
    required bool user,
    required context,
  }) async {
    isLoading.value = true;

    userDetails = await getUserAcessDetails();
    String accesstoken = userDetails![0] ?? "";

    // Data fields
    Map<String, String> driverBody = {
      "phoneNumber": phone,
      "taxid": taxId,
      "address": address,
      "palletSpace": palletSpaces,
      "trailerSize": trailerSize,
      "truckNumber": truckNumber,
      "cdlNumber": cdlNumber,
    };
    Map<String, String> userBody = {
      "phoneNumber": phone,
      "taxid": taxId,
      "address": address,
    };
    Map<String, String> header = {"Authorization": "Bearer $accesstoken"};

    List<MultipartBody> multipartBody = [];
    // Check if image is not null before adding to multipart
    if (image != null && image!.isNotEmpty) {
      multipartBody.add(MultipartBody("profileImage", File(image!)));
      debugPrint("=======================================imagePath: $image");
    } else {
      debugPrint("No image selected for upload");
      Get.snackbar("Profile Image Required",
          "Please select an image to complete your profile.");
      isLoading.value = false;
      return; // Exit early if no image is provided but required
    }

    try {
      var response = await ApiClient.postMultipartData(
          ApiPaths.completeProfile, user ? userBody : driverBody,
          multipartBody: multipartBody, headers: header);
      log("=======================================================header $header");
      if (response.statusCode == 201) {
        if (user) {
          animetedNavigationPush(const UserRootPage(), context);
        } else {
          animetedNavigationPush(const DriverRootPage(), context);
        }
        Get.snackbar("Complete Profile", "Complete Profile Successful");
      } else {
        Get.snackbar("Complete Profile",
            "Complete Profile Failed: ${response.body["message"]}");
      }
    } catch (e) {
      Get.snackbar("Complete Profile", "Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }
}
