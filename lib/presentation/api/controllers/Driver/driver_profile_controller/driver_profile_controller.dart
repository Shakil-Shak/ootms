import 'dart:convert';

import 'package:get/get.dart';
import 'package:ootms/helpers/prefs_helper.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../components/common_snackbar.dart';
import '../../../service/api_services.dart';

class DriverProfileController extends GetxController {
  List<String>? userDetails;
  static DriverProfileController get instance =>
      Get.put(DriverProfileController());
  final ApiService apiService = ApiService();
  bool isLoading = false;
  bool isSuccess = false;

  driverFeedback(
      {required num ratting, required String messege, context}) async {
    print("topu");
    isLoading = true;
    update();
    String userId = await PrefsHelper.getString("userRole");

    Map<String, dynamic> body = {"comment": messege, "rating": ratting};

    try {
      var response = await apiService.otherPostRequest(
          ApiPaths.serviceFeedback(userId), jsonEncode(body));
      if (response["statusCode"] == "201") {
        showCommonSnackbar(context, "Feedback Added", isError: false);
        isSuccess = true;
        update();
      } else {
        print("error");
        showCommonSnackbar(context, "Feedback Added Failed", isError: true);
      }
    } catch (e) {
      print("error$e");
      showCommonSnackbar(context, "Something went wrong", isError: true);
    } finally {
      isLoading = false;
      update();
    }
  }
}
