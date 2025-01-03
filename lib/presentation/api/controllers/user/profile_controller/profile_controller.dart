import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/api_services.dart';
import 'package:ootms/presentation/api/models/user_model/profile_model/get_profile_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../models/user_model/shiping_model/current_shiping_model.dart';

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

//====================================================current shiping method
  CurrentShippingModel? currentShipData;
  bool isCurrentShip = false;

  // Future<void> getCurrentShipData() async {
  //   try {
  //     isCurrentShip = true;
  //     notifyListeners();

  //     final response = await _apiService.getRequest(ApiPaths.currentShiping);
  //     if (response is Map<String, dynamic>) {
  //       log("================================================successfull");
  //       if (response['statusCode'] == 200) {
  //         print(response['data']);
  //         final responseData = response['data'];
  //         if (responseData != null && responseData is Map<String, dynamic>) {
  //           currentShipData = CurrentShippingModel.fromJson(responseData);
  //           print("=========================================currentdata $currentShipData");
  //         }
  //       } else {
  //         isCurrentShip = false;
  //         notifyListeners();
  //       }
  //     } else {
  //       log("Error: Response is not a Map<String, dynamic>");
  //     }
  //   } catch (e) {
  //     isCurrentShip = false;
  //     notifyListeners();
  //     log("================================================fail");
  //     log("Error during profile data fetch: $e");
  //   } finally {
  //     isCurrentShip = false;
  //     notifyListeners();
  //   }
  // }

  Future<void> getCurrentShipData() async {
    try {
      isCurrentShip = true;
      notifyListeners();

      final response = await _apiService.getRequest(ApiPaths.currentShiping);
      log("Full Response: $response");

      if (response is Map<String, dynamic>) {
        log("================================================successfull");

        if (response['statusCode'] == 200) {
          final responseData = response['data'];
          if (responseData != null && responseData is Map<String, dynamic>) {
            currentShipData = CurrentShippingModel.fromJson(responseData);
          } else {
            isCurrentShip = false;
            notifyListeners();
            log("Error: Response data is null or not a Map<String, dynamic>");
          }
        } else {
          log("Error: statusCode is not 200, received ${response['statusCode']}");
          isCurrentShip = false;
          notifyListeners();
        }
      } else {
        log("Error: Response is not a Map<String, dynamic>");
      }
    } catch (e) {
      isCurrentShip = false;
      notifyListeners();
      log("================================================fail");
      log("Error during profile data fetch: $e");
    } finally {
      isCurrentShip = false;
      notifyListeners();
    }
  }
}
