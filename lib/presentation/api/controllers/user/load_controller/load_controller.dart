import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../api_services.dart';
import '../../../url_paths.dart';

class LoadController extends ChangeNotifier {
  TextEditingController driverIdcontroller = TextEditingController();
  final TextEditingController receiverNameController = TextEditingController();
  final TextEditingController receiverPhoneController = TextEditingController();
  final TextEditingController receiverEmailController = TextEditingController();
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

    // List<Map<String, dynamic>> data = [
    //   {
    //     "driver": "63f96eb5b4dce8b0298ebf77",
    //     "shipperName": "John Doe",
    //     "shipperPhoneNumber": "+1234567890",
    //     "shipperEmail": "shipper@example.com",
    //     "shippingAddress": "123 Main Street",
    //     "shippingCity": "New York",
    //     "shippingState": "NY",
    //     "shippingZip": "10001",
    //     "palletSpace": 10,
    //     "weight": 1500,
    //     "loadType": "Full Load",
    //     "trailerType": "Refrigerated",
    //     "trailerSize": "22",
    //     "productType": "Frozen Foods",
    //     "isHazmat": true,
    //     "Hazmat": "Class 2",
    //     "description": "Frozen meat shipment",
    //     "shipmentPayment": 5000,
    //     "receiverName": "Jane Doe",
    //     "receiverPhoneNumber": "+0987654321",
    //     "receiverEmail": "receiver@example.com",
    //     "receivingAddress": "456 Elm Street",
    //     "receiverCity": "Los Angeles",
    //     "receiverState": "CA",
    //     "receiverZip": "90001",
    //     "receiverpostalCode": "90001",
    //     "pickupDate": "2025-01-10T08:00:00Z",
    //     "deliveryDate": "2025-01-12T18:00:00Z",
    //     "billOfLading": "BOL-123456789",
    //     "deliveryInstruction": "Handle with care, keep refrigerated."
    //   }
    // ];
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
        "Hazmat": "gas-2",
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

