import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/driver_model/load_request_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';



class DriverLoadRequest extends GetxController {
  static DriverLoadRequest get instance => Get.put(DriverLoadRequest());

  bool isLoading = false;
  bool isMoreLoading = false;
  DriverLoadModel driverLoadModel = DriverLoadModel();
  List loadRequestData = [];
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
    await getDriverLoadReg();
    isMoreLoading = false;
    update();
  }

  Future<void> getDriverLoadReg() async {
    if (page == 1) {
      isLoading = true;
      update();
    } else {
      isMoreLoading = true;
      update();
    }

    try {
      final response =
          await ApiClient.getData("${ApiPaths.driverLoadRequest}$page");
      log("Full Response: ${response.statusCode}");
      log("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final responseData =
            response.body['data']?['attributes']?['loadRequests'];

        if (responseData == null) {
          return;
        }

        if (responseData is List) {
          if (page == 1) {
            loadRequestData.clear();
            loadRequestData = responseData
                .map((item) => DriverLoadModel.fromJson(item))
                .toList();
            update();
          } else {
            loadRequestData.addAll(responseData
                .map((item) => DriverLoadModel.fromJson(item))
                .toList());
            update();
          }
          log("Pending shipment list: $loadRequestData");
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
