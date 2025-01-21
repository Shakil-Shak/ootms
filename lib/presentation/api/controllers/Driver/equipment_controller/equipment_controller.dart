import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';

import '../../../models/driver_model/equipment_model.dart';
import '../../../service/api_services.dart';
import '../../../url_paths.dart';

class EquipmentController extends GetxController {
  TextEditingController truckNumController =
      TextEditingController(text: kDebugMode ? "TRK4089" : "");
  TextEditingController trailerSizeController = TextEditingController();
  TextEditingController palletController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController cdlNumController =
      TextEditingController(text: kDebugMode ? "CDL15345" : "");
  EquipmentModel equipmentData = EquipmentModel();
  List<Truck> truckList = [];
  List<Trailer> trailerList = [];
  String selectText = "Truck";

  bool isLoading = false;
  //================================================update text
  updateText({required String text}) {
    selectText = text;
    update();
  }

//=================================================================================================get equipment

  getEquipmentData() async {
    isLoading = true;
    update();

    try {
      final response = await ApiClient.getData(ApiPaths.equipment);
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        var attributes = response.body['data']['attributes'];
        print("data============ $attributes");
        if (attributes != null) {
          equipmentData = EquipmentModel(
            truck: (attributes['truck'] as List<dynamic>)
                .map((e) => Truck.fromJson(e as Map<String, dynamic>))
                .toList(),
            trailer: (attributes['trailer'] as List<dynamic>)
                .map((e) => Trailer.fromJson(e as Map<String, dynamic>))
                .toList(),
          );
          truckList = equipmentData.truck;
          trailerList = equipmentData.trailer;
        } else {
          log("Error: 'attributes' is null in the response.");
        }
      } else {
        log("Error: statusCode is ${response.statusCode}");
      }
    } catch (e) {
      log("Exception caught: $e");
    } finally {
      isLoading = false;
      update();
    }
  }

  //====================================================================add truck in my equipment
  bool isAddLoading = false;

  final ApiService apiService = ApiService();

  addTruckRepo({context}) async {
    isAddLoading = true;
    update();
    List<Map<String, String>> body = [
      {
        "type": "truck",
        "truckNumber": truckNumController.text.toString(),
        "cdlNumber": cdlNumController.text.toString()
      }
    ];
    try {
      final response = await apiService.otherPostRequest(
          ApiPaths.addEquipment, jsonEncode(body));

      if (response["statusCode"] == "201") {
        showCommonSnackbar(context, response["message"], isError: false);
        getEquipmentData();
        truckNumController.clear();
        cdlNumController.clear();

        isAddLoading = false;
        update();
      } else {
        showCommonSnackbar(context, response["message"], isError: true);

        isAddLoading = false;
        update();
      }
    } catch (e) {
      isAddLoading = false;
      update();
    }
  }

  //================================add trailer
  addTrailerRepo({context}) async {
    isAddLoading = true;
    update();
    List<Map<String, String>> body = [
      {
        "type": "trailer",
        "trailerSize": trailerSizeController.text,
        "palletSpace": palletController.text,
        "weight": weightController.text
      }
    ];
    try {
      final response = await apiService.otherPostRequest(
          ApiPaths.addEquipment, jsonEncode(body));

      if (response["statusCode"] == "201") {
        showCommonSnackbar(context, response["message"], isError: false);

        getEquipmentData();
        trailerSizeController.clear();
        palletController.clear();
        weightController.clear();
        isAddLoading = false;
        update();
      } else {
        showCommonSnackbar(context, response["message"], isError: true);

        isAddLoading = false;
        update();
      }
    } catch (e) {
      isAddLoading = false;
      update();
    }
  }
}
