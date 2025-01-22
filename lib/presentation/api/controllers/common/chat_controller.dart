
// import 'package:get/get.dart';
//
// class ChatController extends GetxController{
//
//   RxBool isLoading = false.obs;
//
//   Future<void> getChatList()async {
//       isLoading = true;
//       update();
//     }
//
//     try {
//       final response = await ApiClient.getData("${ApiPaths.getNotification}$page");
//       log("Full Response: ${response.body}");
//       log("Full Response: ${response.statusCode}");
//
//       if (response.statusCode == int.parse("200")) {
//         log("================================================successful");
//         List responseData = response.body['data']["attributes"]["notificationList"];
//         log("responseData: $responseData");
//         notificationList.addAll(responseData.map((items) => NotificationModel.fromJson(items)).toList());
//         update();
//
//       } else {
//         log("Error: statusCode is not 200 or response is null");
//       }
//     } catch (e) {
//       log("$e");
//     } finally {
//       isLoading = false;
//       update();
//     }
//   }
// }