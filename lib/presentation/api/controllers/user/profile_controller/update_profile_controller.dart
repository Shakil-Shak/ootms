import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../sharePrefarences/local_storage_save.dart';

class UpdateProfileController extends GetxController {
  RxBool isLoading = false.obs;
  List<String>? userDetails;
  String? image;
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
      debugPrint("=======================================================body $body");
      debugPrint("=======================================================header $header");
    if (response.statusCode == 200) {
      var responseData = response.body is String
          ? jsonDecode(response.body)["data"]
          : response.body["data"];

      Get.snackbar("Update Profile", "Update Profile Successfull");
      isLoading.value = false;
    } else {
      Get.snackbar("Update Profile", "Update Profile Faild");

      isLoading.value = false;
    }
  }
}
