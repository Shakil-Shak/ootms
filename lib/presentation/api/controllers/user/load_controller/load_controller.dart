import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../components/common_snackbar.dart';
import '../../../../screens/role/user/home/user_home_page.dart';
import '../../../service/api_services.dart';
import '../../../url_paths.dart';

class LoadController extends ChangeNotifier {
  String selectedValue = "";
  String selectedFilterItem = "";
  TextEditingController driverIdcontroller = TextEditingController();
  final TextEditingController receiverNameController =
      TextEditingController(text: kDebugMode ? "Topu" : "");
  final TextEditingController receiverPhoneController =
      TextEditingController(text: kDebugMode ? "46465454" : "");
  final TextEditingController receiverEmailController =
      TextEditingController(text: kDebugMode ? "Topu@gmail.com" : "");
  final TextEditingController receiverAddressController =
      TextEditingController(text: kDebugMode ? "Dhaka" : "");
  final TextEditingController receiverCityController =
      TextEditingController(text: kDebugMode ? "Thakurgaon" : "");
  final TextEditingController receiverStateController =
      TextEditingController(text: kDebugMode ? "Bangladesh" : "");
  final TextEditingController receiverZipController =
      TextEditingController(text: kDebugMode ? "123" : "");
  final TextEditingController palletSpacesController =
      TextEditingController(text: kDebugMode ? "20" : "");
  final TextEditingController weightController =
      TextEditingController(text: kDebugMode ? "50" : "");
  final TextEditingController poController =
      TextEditingController(text: kDebugMode ? "12345" : "");
  final TextEditingController billOfLadingController =
      TextEditingController(text: kDebugMode ? "50" : "");
  final TextEditingController deliveryInstructionsController =
      TextEditingController(text: kDebugMode ? "on time delevary" : "");

  final TextEditingController shipperNameController =
      TextEditingController(text: kDebugMode ? "Topu" : "");
  final TextEditingController shipperPhoneController =
      TextEditingController(text: kDebugMode ? "25346542312" : "");
  final TextEditingController shipperEmailController =
      TextEditingController(text: kDebugMode ? "topu123@gmail.com" : "");
  final TextEditingController shipperAddressController =
      TextEditingController(text: kDebugMode ? "Dhaka" : "");
  final TextEditingController shipperCityController =
      TextEditingController(text: kDebugMode ? "Dhaka" : "");
  final TextEditingController shipperStateController =
      TextEditingController(text: kDebugMode ? "Bangladesh" : "");
  final TextEditingController shipperZipController =
      TextEditingController(text: kDebugMode ? "123" : "");
  final TextEditingController loadTypeController =
      TextEditingController(text: kDebugMode ? "Full Type" : "");
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController deliveryController = TextEditingController();
  final TextEditingController trailerSizeController =
      TextEditingController(text: kDebugMode ? "60" : "");
  final TextEditingController descriptionController =
      TextEditingController(text: kDebugMode ? "on time delevary" : "");
  final TextEditingController productTypeCtrl =
      TextEditingController(text: kDebugMode ? "Full Load" : "");
  final TextEditingController paymentCtl =
      TextEditingController(text: kDebugMode ? "100" : "");
  bool isHazMat = false;
  List<String> hazmatList = [];
  bool isLoading = false;
  bool isSuccess = false;
  final ApiService apiService = ApiService();
  Map<String, bool> hazMatItems = {
    "Dangerous": false,
    "Flammable Gas 2": false,
    "Poson 6": false,
    "Corrosive": false,
    "Oxygen 2": false,
    "Flammable 3": false,
    "Radioactive 7": false,
    "Non-Flammable": false
  };

  pickPickupDate() async {
    String pickDate = await OtherHelper.datePicker(pickupController);
    pickupController.value = TextEditingValue(text: pickDate);
    notifyListeners();
  }

  pickdelivaryDate() async {
    String pickDate = await OtherHelper.datePicker(deliveryController);
    deliveryController.value = TextEditingValue(text: pickDate);
    notifyListeners();
  }

  void updateHazMatItem(String key, bool value) {
    if (hazMatItems.containsKey(key)) {
      hazMatItems[key] = value;

      hazmatList = hazMatItems.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      notifyListeners();
    } else {
      print("Error: Key '$key' does not exist in hazMatItems.");
    }
  }

//============================================================create load method
  Future<void> createLoad({context}) async {
    isLoading = true;
    notifyListeners();

    print("----------------------------------hazmat list $hazmatList");
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
    print("==========================================hazmatlist $hazmatList");
    // print(
    //     "==========================================hazmatlist ${jsonEncode(hazmatList)}");

    try {
      final response = await apiService.otherPostRequest(
          ApiPaths.createLoad, jsonEncode(data));

      log("status code before =-==================${response["statusCode"]}");
      if (response["statusCode"] == "201") {
      
        print(
            "================================================data $response");
    final id = response["data"]["attributes"][0]["id"];
    print("================================================ Load ID: $id");
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
      "load": "677cbb93176e4150add24832",
      "driver": "677a2b7d2f65914268b90421"
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

