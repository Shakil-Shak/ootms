import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/shipping_history_model.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';

import '../../../../screens/role/user/shipping/user_shipping_history.dart';

class ShippinfHistoryController extends ChangeNotifier {
  final ApiService apiService = ApiService();
  bool isLoading = false;
  List<ShippingHistoryModel> shippingHistoryData = [];

  Future<void> getShippingHistoryData({required context}) async {
    isLoading = true;
    notifyListeners();

    final response = await apiService.getRequest(ApiPaths.shippingHistory);
    log("Full Response: $response");

    if (response is Map<String, dynamic>) {
      log("================================================successfull");

      if (response['statusCode'] == 200) {
        final responseData = response['data'];
        log("responseData: $responseData");
        if (responseData != null && responseData is Map<String, dynamic>) {
          List responseData =
              response['data']?["attributes"]?["loadRequests"] ?? [];
              print("=======================================response data $responseData");
          shippingHistoryData = responseData
              .map((items) => ShippingHistoryModel.fromJson(items))
              .toList();
              
              print("=======================================shippingHistoryData data $shippingHistoryData");
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
}
