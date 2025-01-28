import 'package:get/get.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../../components/common_snackbar.dart';

class ShipmentStartController extends GetxController {
  RxBool isLoading = false.obs;
  startShipment({required String loadReqId, context,required String action}) async {
    isLoading.value = true;
    Map<String, String> body = {
      "loadReqId": loadReqId,
      "action": action,
    };
    try {
      var response = await ApiClient.patchData(ApiPaths.shipmentStartDelever, body);
      var data = response.body;
      if (response.statusCode == 200) {
        showCommonSnackbar(context, data["message"]);
        Get.back();
      } else {
        showCommonSnackbar(context, data["message"], isError: true);
        Get.back();
      }
    } catch (e) {
      final RegExp regExp = RegExp(r'message:\s([^,]+)');
      final match = regExp.firstMatch(e.toString());
      final message = match?.group(1);
      showCommonSnackbar(context, "$message", isError: true);
      Get.back();
    } finally {
      isLoading.value = false;
    }
  }
}
