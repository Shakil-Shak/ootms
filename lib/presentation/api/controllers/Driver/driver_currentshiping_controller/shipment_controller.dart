import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/pending_shipping_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class ShipmentController extends GetxController{

  static ShipmentController get instance => Get.put(ShipmentController());

  bool isLoading = false;
  bool isMoreLoading = false;
  PendingShipmentModel pendingShipmentModel = PendingShipmentModel();
  List currentShipmentData = [];
  final ScrollController scrollController = ScrollController();
  int page = 1;
  String loadId = "";

  handleScrollController(){
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
    await getPendingShipment();
    isMoreLoading = false;
    update();
  }


  Future<void> getPendingShipment()async {
    isLoading = true;
    update();

    try {
      final response = await ApiClient.getData("${ApiPaths.pendingShipment}$page");
      log("Full Response: ${response.statusCode}");

      if (response.statusCode == int.parse("200")) {
        log("================================================successful");
        var responseData = response.body['data']['attributes']['loadRequests'];
        log("responseData: $responseData");
        if(page == 1){
          currentShipmentData = responseData.map((items) => PendingShipmentModel.fromJson(items)).toList();
        }else{
          currentShipmentData.addAll(responseData.map((items) => PendingShipmentModel.fromJson(items)).toList());
        }
        log("pending shipment list: $currentShipmentData");
        update();

      } else {
        log("Error: statusCode is not 200 or response is null");
      }
    } catch (e) {
      log("$e");
    } finally {
      isLoading = false;
      update();
    }
  }
}