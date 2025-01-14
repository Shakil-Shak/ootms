import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/shipping_history_model.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/api/models/user_model/load_request_model/load_request_model.dart';
import 'package:ootms/presentation/api/models/user_model/profile_model/get_profile_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_shipping_history.dart';


import '../../../../components/common_snackbar.dart';
import '../../../../navigation/animeted_navigation.dart';
import '../../../../screens/role/user/shipping/user_current_shipments.dart';
import '../../../models/user_model/shiping_model/current_shiping_model.dart';

class ProfileController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool isLoading = false;
  ProfileModel profileData = ProfileModel();
  bool isSupportFieldClear = false;
  Future<void> postSupport(
      {required String title, required String content,required context}) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> data = {
      "title": title,
      "content": content,
    };

    final response =
        await _apiService.otherPostRequest(ApiPaths.userSupport, data);

    if (response is Map<String, dynamic>) {
      if (response['statusCode'] == "201") {
        showCommonSnackbar(context, "Submited successful!");
        isSupportFieldClear = true;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
      }
    } else {
      isLoading = false;
      notifyListeners();
      log("Error: Response is not a Map<String, dynamic>");
    }
  }

  //===================================================get profile data

  Future<void> getProfileData() async {
    isLoading = true;
    notifyListeners();

    final response = await _apiService.getRequest(ApiPaths.profileUrl);

    if (response is Map<String, dynamic>) {
      log("================================================successfull");
      if (response['statusCode'] == 200) {
        final responseData = response['data'];
        if (responseData != null && responseData is Map<String, dynamic>) {
          profileData = ProfileModel.fromJson(responseData['attributes']);
          isLoading = false;
          notifyListeners();
        }
      } else {
        isLoading = false;
        notifyListeners();
        log("================================================fail");
        log("Error: Unexpected status code ${response['statusCode']}");
      }
    } else {
      isLoading = false;
      notifyListeners();
      log("Error: Response is not a Map<String, dynamic>");
    }
  }

//====================================================current shiping method

  List<CurrentShippingModel> currentShipData = [];
  bool isCurrentShip = false;

  Future<void> getCurrentShipData({required context}) async {
    isLoading = true;
    notifyListeners();

    final response = await _apiService.getRequest(ApiPaths.currentShiping);
    log("Full Response: $response");

    if (response is Map<String, dynamic>) {
      log("================================================successfull");

      if (response['statusCode'] == 200) {
        final responseData = response['data'];
        log("responseData: $responseData");
        if (responseData != null && responseData is Map<String, dynamic>) {
          List responseData =
              response['data']?["attributes"]?["loadRequests"] ?? [];
          currentShipData = responseData
              .map((items) => CurrentShippingModel.fromJson(items))
              .toList();
          animetedNavigationPush(UserCurrentShipmentsPage(), context);
          print("success");
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
          log("Error: Response data is null or not a Map<String, dynamic>");
        }
      } else {
        log("Error: statusCode is not 200, received ${response['statusCode']}");
        isLoading = false;
        notifyListeners();
      }
    } else {
      isLoading = false;
      notifyListeners();
      log("Error: Response is not a Map<String, dynamic>");
    }
  }

  //================ shipping histopry data

  List<ShippingHistoryModel> shippingHistoryData = [];

  Future<void> getShippingHistoryData({required context}) async {
    isLoading = true;
    notifyListeners();

    final response = await _apiService.getRequest(ApiPaths.shippingHistory);
    log("Full Response: $response");

    if (response is Map<String, dynamic>) {
      log("================================================successfull");

      if (response['statusCode'] == 200) {
        final responseData = response['data'];
        log("responseData: $responseData");
        if (responseData != null && responseData is Map<String, dynamic>) {
          List responseData =
              response['data']?["attributes"]?["loadRequests"] ?? [];
          shippingHistoryData = responseData
              .map((items) => ShippingHistoryModel.fromJson(items))
              .toList();
          animetedNavigationPush(UserShippingHistoryPage(), context);
          print("success");
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
          log("Error: Response data is null or not a Map<String, dynamic>");
        }
      } else {
        log("Error: statusCode is not 200, received ${response['statusCode']}");
        isLoading = false;
        notifyListeners();
      }
    } else {
      isLoading = false;
      notifyListeners();
      log("Error: Response is not a Map<String, dynamic>");
    }
  }

  //==================================================get load request data
  List<LoadRequestModel> loadRequestData = [];

  Future<void> getLoadRequestData({required context, bool requestType = false, bool callFromHome = false}) async {
    isLoading = true;
    if(!callFromHome){
      notifyListeners();
    }
    try {
      final response = await _apiService.getRequest(ApiPaths.userLoadRequest(requestType: requestType));
      log("Full Response: $response");

      if (response != null &&
          response['statusCode'] != null &&
          response['statusCode'] == "200") {
        log("================================================successfull");
        List responseData =
            response['data']?["attributes"]?["loadRequests"] ?? [];
        log("responseData: $responseData");

        loadRequestData = responseData
            .map((items) => LoadRequestModel.fromJson(items))
            .toList();
      } else {
        log("Error: statusCode is not 200 or response is null");
      }
    } catch (e) {
      log("$e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
