

import 'dart:developer';

import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/load_details_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class LoadDetailsController extends GetxController{

  static LoadDetailsController get instance => Get.put(LoadDetailsController());

  bool isLoading = false;
  LoadDetailsModel loadDetailsModel = LoadDetailsModel();

  Future<void>  getLoadDetails({required String loadId})async {
      isLoading = true;
      update();

    try {
      final response = await ApiClient.getData("${ApiPaths.loadsDetails}$loadId");
      log("Full Response-=-=-=-=-=-=->>>>: ${response.body}");
      log("Full Response: ${response.statusCode}");

      if (response.statusCode == int.parse("200")) {
        log("================================================successful");
        var responseData = response.body['data'];
        log("responseData: $responseData");
        loadDetailsModel = LoadDetailsModel.fromJson(responseData);
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