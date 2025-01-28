
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../components/common_snackbar.dart';

class TechnicalIssueController extends GetxController {
  RxBool isLoading = false.obs;
  technicalIssue(
      {required String loadId, required String loadReqId, context}) async {
    isLoading.value = true;
    Map<String, String> body = {
      "loadId": loadId,
      "loadRequestId": loadReqId
    };
    try {
      var response = await ApiClient.postData(ApiPaths.technicalIssue, body);
      var data = response.body;
      if (response.statusCode == 200) {
        showCommonSnackbar(context, data["message"]);
        Get.back();
      } else {
        showCommonSnackbar(context, data["message"], isError: true);
      }
    } catch (e) {
      final RegExp regExp = RegExp(r'message:\s([^,]+)');
      final match = regExp.firstMatch(e.toString());
      final message = match?.group(1);
      showCommonSnackbar(context, "$message", isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
