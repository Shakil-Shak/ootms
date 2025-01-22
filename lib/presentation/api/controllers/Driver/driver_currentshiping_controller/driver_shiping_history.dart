import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/driver_model/driver_shiphistory_model.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/shipping_history_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../models/driver_model/currentship_model.dart';

class DriverShipingHistory extends GetxController {
  static DriverShipingHistory get instance => Get.put(DriverShipingHistory());

  bool isLoading = false;
  bool isMoreLoading = false;
  List shipingHistory = [];
  final ScrollController scrollController = ScrollController();
  int page = 1;
  String loadId = "";

  handleScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        log("Load more data is called: $page");
        _loadMoreData();
      }
    });
  }

  Future<void> _loadMoreData() async {
    page++;
    isMoreLoading = true;
    update();
    await getDriverShipingHistory();
    isMoreLoading = false;
    update();
  }

  Future<void> getDriverShipingHistory() async {
    if (page == 1) {
      isLoading = true;
      update();
    } else {
      isMoreLoading = true;
      update();
    }

    try {
      final response = await ApiClient.getData(
          "${ApiPaths.driverShipingHistory(page: page)}");
      log("Full Response: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = response.body['data']['attributes']['loadRequests'];

        if (responseData is List) {
          if (page == 1) {
            shipingHistory.clear();
            shipingHistory = responseData
                .map((item) => DriverShipHistoryModel.fromJson(item))
                .toList();
          } else {
            shipingHistory.addAll(responseData
                .map((item) => DriverShipHistoryModel.fromJson(item))
                .toList());
            update();
          }
          log("Pending shipment list: $shipingHistory");
        } else {
          log("Error: responseData is not a List.");
        }
        update();
      } else {
        log("Error: statusCode is not 200 or response is null");
      }
    } catch (e) {
      log("Exception: $e");
    } finally {
      isLoading = false;
      update();
      isMoreLoading = false;
      update();
    }
  }
}
