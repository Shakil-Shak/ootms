
import 'dart:developer';

import 'package:get/get.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class ChatController extends GetxController{

  static ChatController get instance => Get.find<ChatController>();

  RxBool isLoading = false.obs;
  // ChatModel chatModel = ChatModel();
  List chatList = [];

  Future<void> getChatList(context, {required String chatId})async {
      isLoading.value = true;

    try {
      final response = await ApiClient.getData("${ApiPaths.chatUrl}$chatId");
      log("Full Response: ${response.body}");
      log("Full Response: ${response.statusCode}");

      if (response.statusCode == int.parse("200")) {
        log("================================================successful");
        // List responseData = response.body['data']["attributes"]["notificationList"];
        // log("responseData: $responseData");
        // chatList.addAll(responseData.map((items) => ChatModel.fromJson(items)).toList());
        update();

      } else {
        log("Error: statusCode is not 200 or response is null");
      }
    } catch (e) {
      log("$e");
    } finally {
      isLoading.value = false;
      update();
    }
  }
}