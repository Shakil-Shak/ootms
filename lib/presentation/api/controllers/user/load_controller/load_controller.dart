import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';

import '../../../../components/common_snackbar.dart';
import '../../../../screens/role/user/home/user_home_page.dart';
import '../../../service/api_services.dart';
import '../../../url_paths.dart';

class LoadController extends ChangeNotifier {
  TextEditingController driverIdcontroller = TextEditingController();
  final TextEditingController receiverNameController =
      TextEditingController(text: kDebugMode ? "Topu" : "");
  final TextEditingController receiverPhoneController =
      TextEditingController(text: kDebugMode ? "46465454" : "");
  final TextEditingController receiverEmailController =
      TextEditingController(text: kDebugMode ? "Topu@gmail.com" : "");
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
  bool isLoading = false;
  bool isSuccess = false;
  final ApiService apiService = ApiService();
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
  Future<void> createLoad({context}) async {
    isLoading = true;
    notifyListeners();
    // List<Map<String, dynamic>> data = [
    //   {
    //     "shipperName": "John Doe",
    //     "shipperPhoneNumber": "+1234567890",
    //     "shipperEmail": "john.doe@example.com",
    //     "shippingAddress": "123 Main Street",
    //     "shippingCity": "New York",
    //     "shippingState": "NY",
    //     "shippingZip": "10001",
    //     "palletSpace": 10,
    //     "weight": 1500,
    //     "loadType": "Full Load",
    //     "trailerSize": 500,
    //     "productType": "Frozen Foods",
    //     "Hazmat": "Hazmat",
    //     "description": "Frozen meat shipment",
    //     "shipmentPayment": 5000,
    //     "receiverName": "Jane Smith",
    //     "receiverPhoneNumber": "+0987654321",
    //     "receiverEmail": "jane.smith@example.com",
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
        "Hazmat": "Hazmat",
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
      final response = await apiService.otherPostRequest(
          ApiPaths.createLoad, jsonEncode(data));
    

      log("status code before =-==================${response["statusCode"]}");
      if (response["statusCode"] == "201") {
        showCommonSnackbar(context, "Create Load Successfull", isError: false);
        isSuccess = true;
        notifyListeners();
      }
    } catch (e) {
      showCommonSnackbar(context, "Create Load Failed", isError: true);
      log("failed =-==================$e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //============================================assign a preffered driver method
  //============================================================create load method
  Future<void> assignPrefferedDriver({context}) async {
    isLoading = true;
    notifyListeners();

    Map<String, String> data = {
      "driver": driverIdcontroller.text,
    };

    try {
      final response = await apiService.otherPostRequest(
          ApiPaths.preferredDriver, jsonEncode(data));
      debugPrint(
          "44==========================================================response$response");

      debugPrint(
          "status code before =-==================${response["statusCode"]}");
      if (response["statusCode"] == 201) {
        animetedNavigationPush(UserHomePage(), context);
        showCommonSnackbar(context, "Assign Preffered Driver Successfull",
            isError: false);
        isSuccess = true;
        notifyListeners();
      } else if (response["statusCode"] == 208) {
        showCommonSnackbar(
          context,
          response["message"],
        );
      } else {
        showCommonSnackbar(context, "Something Went wrong", isError: true);
      }
    } catch (e) {
      showCommonSnackbar(context, "Assign Preffered Driver Failed",
          isError: true);
      debugPrint("failed =-==================$e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
 // Data fields

