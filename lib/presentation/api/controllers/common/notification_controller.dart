
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/notification_model.dart';

import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class NotificationController extends GetxController{

  static NotificationController get instance => Get.find<NotificationController>();

  bool isLoading = false;
  bool isMoreLoading = false;
  NotificationModel notificationModel = NotificationModel();
  List<NotificationModel> notificationList = [];
  final ScrollController scrollController = ScrollController();
  int page = 1;

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
    await getNotificationList();
    isMoreLoading = false;
    update();
  }


  Future<void> getNotificationList()async {
    if(page ==1){
      isLoading = true;
      update();
    }

    try {
      final response = await ApiClient.getData("${ApiPaths.getNotification}$page");
      log("Full Response: ${response.body}");
      log("Full Response: ${response.statusCode}");

      if (response.statusCode == int.parse("200")) {
        log("================================================successful");
        List responseData = response.body['data']["attributes"]["notificationList"];
        log("responseData: $responseData");
        notificationList.addAll(responseData.map((items) => NotificationModel.fromJson(items)).toList());
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


  Future<void> changeNotificationStatus({required String notificationId, required int index})async {

    try {
      final response = await ApiClient.putData("${ApiPaths.notificationStatus}$notificationId", {});
      log("Full Response: ${response.body}");
      log("Full Response: ${response.statusCode}");

      if (response.statusCode == int.parse("200")) {
        log("The notification is set as read");
        notificationList[index].isRead = true;
        update();

      } else {
        log("Error: statusCode is not 200 or response is null");
      }
    } catch (e) {
      log("$e");
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

}