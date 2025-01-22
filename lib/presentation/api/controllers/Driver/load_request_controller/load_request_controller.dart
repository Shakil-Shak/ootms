import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/driver_model/load_request_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../components/common_snackbar.dart';
import '../../../sharePrefarences/local_storage_save.dart';

class DriverLoadRequest extends GetxController {
  static DriverLoadRequest get instance => Get.put(DriverLoadRequest());

  RxBool isLoading = false.obs;
  bool isMoreLoading = false;
  DriverLoadModel driverLoadModel = DriverLoadModel();
  List<DriverLoadModel> loadRequestData = [];
  final ScrollController scrollController = ScrollController();
  int page = 1;
  String loadId = "";

  // handleScrollController() {
  //   scrollController.addListener(() {
  //     if (scrollController.position.pixels ==
  //         scrollController.position.maxScrollExtent) {
  //       log("Load more data is called: $page");
  //       _loadMoreData();
  //     }
  //   });
  // }

  // Future<void> _loadMoreData() async {
  //   page++;
  //   isMoreLoading = true;
  //   update();
  //   await getDriverLoadReg();
  //   isMoreLoading = false;
  //   update();
  // }

  Future<void> getDriverLoadReg(
      {required context,
      bool requestType = false,
      bool callFromHome = false}) async {
    if (page == 1) {
      isLoading.value = true;
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
      isLoading.value = false;
      isMoreLoading = false;
      update();
    }
  }

  //======================================================================load request accept hendler

  loadRequestAccept(
      {required String loadRequestId, required int index, context}) async {
    loadRequestData[index].isLoading = true;
    loadRequestData[index].isAccept = true;
    update();
    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];
    Map<String, String> body = {"loadReqId": loadRequestId, "action": "accept"};

    Map<String, String> header = {"Authorization": "Bearer $token"};

    try {
      var response = await ApiClient.patchData(ApiPaths.loadRequsetAction, body,
          headers: header);
      if (response.statusCode == 200) {
        print(
            "load accept================================================================");
        // getDriverLoadReg(context: context,);
        showCommonSnackbar(context, "Load Request Accept Successfull",
            isError: false);
        loadRequestData[index].isLoading = false;
        loadRequestData[index].isAccept = false;
        update();
      } else {
        showCommonSnackbar(context, "Load Request Accepted Faild",
            isError: true);
      }
    } catch (e) {
      showCommonSnackbar(context, "Something Went Wrong", isError: true);
    } finally {
      loadRequestData[index].isLoading = false;
      loadRequestData[index].isAccept = true;
      update();
    }
  }

  //======================================================================load request reject hendler

  loadRequestReject(
      {required String loadRequestId, context, required int index}) async {
    loadRequestData[index].isLoading = true;
    update();
    loadRequestData[index].isReject = true;
    update();
    List<String>? userDetails = await getUserAcessDetails();
    String token = userDetails![0];
    Map<String, String> body = {"loadReqId": loadRequestId, "action": "accept"};

    Map<String, String> header = {"Authorization": "Bearer $token"};

    try {
      var response = await ApiClient.patchData(ApiPaths.loadRequsetAction, body,
          headers: header);
      if (response.statusCode == 200) {
        // getDriverLoadReg();
        showCommonSnackbar(context, "Load Request Rejected", isError: false);
        loadRequestData[index].isLoading = false;
        update();
        loadRequestData[index].isReject = false;
        update();
      } else {
        showCommonSnackbar(context, "Load Request Rejected Failed",
            isError: true);
      }
    } catch (e) {
      showCommonSnackbar(context, "Something went wrong", isError: true);
    } finally {
      loadRequestData[index].isLoading = false;
      update();
      loadRequestData[index].isReject = false;
      update();
    }
  }
}
