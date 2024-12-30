import 'dart:convert';
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

      if (response.statusCode == 200) {
        debugPrint(
            "================================================successfull");
        final responseData = jsonDecode(response.body);
        if (responseData != null && responseData is Map<String, dynamic>) {
          profileData = ProfileModel.fromJson(responseData['data']);
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        debugPrint("================================================fail");
        debugPrint("Error: Unexpected status code ${response.statusCode}");
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint("================================================fail");
      debugPrint("Error during profile data fetch: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
