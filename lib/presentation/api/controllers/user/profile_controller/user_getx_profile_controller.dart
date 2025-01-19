import 'dart:convert';
import 'package:get/get.dart';
import 'package:ootms/helpers/prefs_helper.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../components/common_snackbar.dart';
import '../../../service/api_services.dart';

class UserGetxProfileController extends GetxController {
  bool isLoading = false;
  bool isFeedbackComplete = false;
    final ApiService apiService = ApiService();
  //==========================================================================driver feedback

  userAppFeedback(
      {required num ratting, required String messege, context}) async {
    print("topu");
    isLoading = true;
    update();
    String userId = await PrefsHelper.getString("userId");

    Map<String, dynamic> body = {"comment": messege, "rating": ratting};

    try {
      var response = await apiService.otherPostRequest(
          ApiPaths.appFeedback, jsonEncode(body));
          print("==============================response$response");
      if (response["statusCode"] == 201) {
        showCommonSnackbar(context, "Feedback Added", isError: false);
        isFeedbackComplete = true;
        update();
        isLoading = false;
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
