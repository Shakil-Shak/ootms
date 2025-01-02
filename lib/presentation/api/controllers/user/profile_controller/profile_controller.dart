import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/api_services.dart';
import 'package:ootms/presentation/api/models/profile_model/get_profile_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../../helpers/other_helper.dart';

class ProfileController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool isLoading = false;
  ProfileModel? profileData;
  
  String? image;
  getProfileImage() async {
    image = await OtherHelper.openGallery();
    notifyListeners();
  }

Future<void> getProfileData() async {
  try {
    isLoading = true;
    notifyListeners();

    final response = await _apiService.getRequest(ApiPaths.profileUrl);

    if (response is Map<String, dynamic>) {
      log("================================================successfull");
      if (response['statusCode'] == "200") {
        final responseData = response['data'];
        if (responseData != null && responseData is Map<String, dynamic>) {
          profileData = ProfileModel.fromJson(responseData['attributes']);
          log(profileData.toString());
        }
      } else {
        log("================================================fail");
        log("Error: Unexpected status code ${response['statusCode']}");
      }
    } else {
      log("Error: Response is not a Map<String, dynamic>");
    }
  } catch (e) {
    log("================================================fail");
    log("Error during profile data fetch: $e");
  } finally {
    isLoading = false;
    notifyListeners();
  }
}

}
