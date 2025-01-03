
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/api_services.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/current_shiping_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';


class ShipingController extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool isLoading = false;
  CurrentShippingModel? currentShipData;
  


Future<void> getCurrentShipData() async {
  try {
    isLoading = true;
    notifyListeners();

    final response = await _apiService.getRequest(ApiPaths.currentShiping);

    if (response is Map<String, dynamic>) {
      log("================================================current shiping successfull");
      if (response['statusCode'] == "200") {
        final responseData = response['data'];
        if (responseData != null && responseData is Map<String, dynamic>) {
          currentShipData = CurrentShippingModel.fromJson(responseData['attributes']);
          
      log("================================================current shiping successfull${currentShipData.toString()}");
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
