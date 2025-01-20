import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/create_load_map_controller.dart';
import 'package:ootms/presentation/screens/role/user/create_load/create_load_map_screen.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../components/common_snackbar.dart';
import '../../../../navigation/animeted_navigation.dart';
import '../../../../screens/role/user/home/user_home_page.dart';
import '../../../service/api_services.dart';
import '../../../url_paths.dart';
import '../../common/bottom_nav_controller.dart';

class LoadController extends ChangeNotifier {
  String selectedValue = "";
  String selectedFilterItem = "";
  String loadId = "";
  TextEditingController driverIdcontroller = TextEditingController();
  final TextEditingController receiverNameController =
      TextEditingController(text: kDebugMode ? "Topu" : "");
  final TextEditingController receiverPhoneController =
      TextEditingController(text: kDebugMode ? "46465454" : "");
  final TextEditingController receiverEmailController =
      TextEditingController(text: kDebugMode ? "Topu@gmail.com" : "");
  TextEditingController receiverAddressController =
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
  num shipperLatitude = 0.0;
  num shipperLongitude = 0.0;
  String pickedUpDate = "";
  String deliveryDate = "";

  final ApiService apiService = ApiService();
  Map<String, bool> hazMatItems = {
    "Hazmat": false,
    "Dangerous": false,
    "Flammable Gas 2": false,
    "Poson 6": false,
    "Corrosive": false,
    "Oxygen2": false,
    "Flamable 3": false,
    "Radioactive": false,
    "Non-Flammable": false
  };

  pickPickupDate() async {
    String pickDate = await OtherHelper.datePicker(pickupController);
    pickedUpDate = pickDate;
    // Parse the ISO string into a DateTime object
    DateTime dateTime = DateTime.parse(pickDate);

    // Format it as `dd-MM-yyyy`
    String day = dateTime.day < 10 ? "0${dateTime.day}" : "${dateTime.day}";
    String month = dateTime.month < 10 ? "0${dateTime.month}" : "${dateTime.month}";
    String formattedDate = "$day-$month-${dateTime.year}";
    pickupController.value = TextEditingValue(text: formattedDate);
    notifyListeners();
  }

  pickdelivaryDate() async {
    String pickDate = await OtherHelper.datePicker(deliveryController);
    deliveryDate = pickDate;

    DateTime dateTime = DateTime.parse(pickDate);

    // Format it as `dd-MM-yyyy`
    String day = dateTime.day < 10 ? "0${dateTime.day}" : "${dateTime.day}";
    String month = dateTime.month < 10 ? "0${dateTime.month}" : "${dateTime.month}";
    String formattedDate = "$day-$month-${dateTime.year}";
    deliveryController.value= TextEditingValue(text: formattedDate);
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

  updateAddresses(double latitude, double longitude) async {
    await CreateLoadMapController.instance.onMapTapped(LatLng(latitude, longitude));
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
        "pickupDate": pickedUpDate,
        "deliveryDate": deliveryDate,
        "billOfLading": billOfLadingController.text,
        "deliveryInstruction": deliveryInstructionsController.text,
        "location": {
          "type": "Point",
          "coordinates": [CreateLoadMapController.instance.selectedLongitude, CreateLoadMapController.instance.selectedLatitude]
        }
      }
    ];
    log("==============>>>> $data <<<<===============");

    try {
      final response = await apiService.otherPostRequest(
          ApiPaths.createLoad, jsonEncode(data));

      log("status code before =-==================${response}");
      if (response["statusCode"] == "201") {
        log("status code after =-==================${response["statusCode"]}");
        final id = response["data"]["attributes"][0]["_id"];
        loadId = id;
        showCommonSnackbar(context, "Create Load Successful", isError: false);
        isSuccess = true;
        notifyListeners();
      }
    } catch (e, s) {
      showCommonSnackbar(context, "Create Load Failed", isError: true);
      log("failed =-==================$e");
      log("failed =-==================$s");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //============================================assign a preffered driver method
  //============================================================create load method
  
  final BottomNavController navController = Get.put(BottomNavController());
  Future<void> assignPrefferedDriver({context}) async {
    isLoading = true;
    
    notifyListeners();

    List<Map<String, String>> data = [
      {"load": loadId, "driver": driverIdcontroller.text}
    ];
    print("=====================================data $data");

    try {
      final response = await apiService.otherPostRequest(
          ApiPaths.preferredDriver, jsonEncode(data));
      debugPrint(
          "44==========================================================response${response["statusCode"]}");
      if (response["statusCode"] == 201) {
        driverIdcontroller.clear();
        showCommonSnackbar(context, "Assign Preffered Driver Successfull",
            isError: false);
        navController.valueIncrease(value: 0);
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

