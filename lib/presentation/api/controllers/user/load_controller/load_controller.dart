import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../api_services.dart';
import '../../../url_paths.dart';

class LoadController extends ChangeNotifier {
  TextEditingController driverIdcontroller = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController(text: kDebugMode? "Topu":"");
  final TextEditingController receiverPhoneController = TextEditingController(text: kDebugMode? "46465454":"");
  final TextEditingController receiverEmailController = TextEditingController(text: kDebugMode? "Topu@gmail.com":"");
  final TextEditingController receiverAddressController =
      TextEditingController();
  final TextEditingController receiverCityController = TextEditingController();
  final TextEditingController receiverStateController = TextEditingController();
  final TextEditingController receiverZipController = TextEditingController();
  final TextEditingController palletSpacesController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController poController = TextEditingController();
  final TextEditingController billOfLadingController = TextEditingController();
  final TextEditingController deliveryInstructionsController =
      TextEditingController();

  final TextEditingController shipperNameController = TextEditingController();
  final TextEditingController shipperPhoneController = TextEditingController();
  final TextEditingController shipperEmailController = TextEditingController();
  final TextEditingController shipperAddressController =
      TextEditingController();
  final TextEditingController shipperCityController = TextEditingController();
  final TextEditingController shipperStateController = TextEditingController();
  final TextEditingController shipperZipController = TextEditingController();
  final TextEditingController loadTypeController = TextEditingController();
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController deliveryController = TextEditingController();
  final TextEditingController trailerSizeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController productTypeCtrl = TextEditingController();
  final TextEditingController paymentCtl = TextEditingController();
  bool isHazMat = false;
  List<String> hazmatList = [];
  final ApiService apiService = ApiService();
  bool isLoading = false;
  Map<String, bool> hazMatItems = {
    "Dangerous": false,
    "Flammable Gas 2": false,
    "Poison 6": false,
    "Corrosive": false,
    "Oxygen 2": false,
    "Danger": false,
    "Flammable 3": false,
    "Radioactive 7": false,
    "Non-Flammable Gas": false
  };
  void updateHazMatItem(String key, bool value) {
    hazMatItems[key] = value;
    // Update selected items
    hazmatList = hazMatItems.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    notifyListeners();
  }

//============================================================create load method
  Future<void> createLoad() async {
    isLoading = true;
    notifyListeners();

    List<Map<String, dynamic>> data = [
      {
        // "driver": driverIdcontroller.text,
        "shipperName": shipperNameController.text,
        "shipperPhoneNumber": shipperPhoneController.text,
        "shipperEmail": shipperEmailController.text,
        "shippingAddress": shipperAddressController.text,
        "shippingCity": shipperCityController.text,
        "shippingState": shipperStateController.text,
        "shippingZip": shipperZipController.text,
        "palletSpace": palletSpacesController.text,
        "weight": weightController.text,
        "loadType": loadTypeController.text,
        "trailerType": loadTypeController.text,
        "trailerSize": trailerSizeController.text,
        "productType": productTypeCtrl.text,
        // "isHazmat": isHazMat,
        "Hazmat": hazmatList,
        "description": descriptionController.text,
        "shipmentPayment": paymentCtl.text,
        "receiverName": receiverNameController.text,
        "receiverPhoneNumber": receiverPhoneController.text,
        "receiverEmail": receiverEmailController.text,
        "receivingAddress": receiverAddressController.text,
        "receiverCity": receiverCityController.text,
        "receiverState": receiverStateController.text,
        "receiverZip": receiverZipController.text,
        "receiverpostalCode": poController.text,
        "pickupDate": pickupController.text,
        "deliveryDate": deliveryController.text,
        "billOfLading": billOfLadingController.text,
        "deliveryInstruction": deliveryInstructionsController.text
      }
    ];
    print("=================================================data $data");

    try {
      final response =
          await apiService.otherPostRequest(ApiPaths.createLoad, data);
      print(
          "44==========================================================response$response");

      log("status code before =-==================${response["statusCode"]}");
      if (response["statusCode"] == 201) {
        log("===================================================================create load success");
      }
    } catch (e) {
      log("failed =-==================$e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
 // Data fields

