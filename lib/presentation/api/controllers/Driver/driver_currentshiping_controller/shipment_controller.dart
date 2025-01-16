import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/pending_shipping_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../models/driver_model/currentship_model.dart';

class DriverShipmentController extends GetxController {
  static DriverShipmentController get instance =>
      Get.put(DriverShipmentController());

  bool isLoading = false;
  bool isMoreLoading = false;
  PendingShipmentModel pendingShipmentModel = PendingShipmentModel();
  List currentShipmentData = [];
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
    await getDriverShipment();
    isMoreLoading = false;
    update();
  }

  Future<void> getDriverShipment() async {
    if (page == 1) {
      isLoading = true;
      update();
    } else {
      isMoreLoading = true;
      update();
    }

    try {
      final response =
          await ApiClient.getData("${ApiPaths.drivercurrentShiping}$page");
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
            currentShipmentData.clear();
            currentShipmentData = responseData
                .map((item) => DriverCurrentshipModel.fromJson(item))
                .toList();
          } else {
            currentShipmentData.addAll(responseData
                .map((item) => DriverCurrentshipModel.fromJson(item))
                .toList());
            update();
          }
          log("Pending shipment list: $currentShipmentData");
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

  // Future<void> getDriverShipment() async {
  //   isLoading = true;
  //   update();

  //   try {
  //     final response =
  //         await ApiClient.getData("${ApiPaths.currentShiping}$page");
  //     log("Full Response: ${response.statusCode}");

  //     if (response.statusCode == 200) {
  //       var responseData = response.body['data']['attributes']['loadRequests'];
  //       print("==================================page $page");
  //       if (page == 1) {
  //         log("================================================successful");
  //         currentShipmentData = responseData
  //             .map((items) => DriverCurrentshipModel.fromJson(items))
  //             .toList();

  //         log("pending shipment list: $currentShipmentData");
  //       } else {
  //         currentShipmentData.addAll(responseData
  //             .map((items) => DriverCurrentshipModel.fromJson(items))
  //             .toList());
  //       }
  //       update();
  //     } else {
  //       log("Error: statusCode is not 200 or response is null");
  //     }
  //   } catch (e) {
  //     log("$e");
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  // }
}
