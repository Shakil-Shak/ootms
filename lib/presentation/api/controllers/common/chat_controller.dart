
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/models/chat_model.dart';
import 'package:ootms/presentation/api/service/get_api_service.dart';
import 'package:ootms/presentation/api/service/socket_service.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class ChatController extends GetxController{

  static ChatController get instance => Get.find<ChatController>();

  RxBool isLoading = false.obs;
  // ChatModel chatModel = ChatModel();
  List chatList = [].obs;
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;


  TextEditingController chatTextController = TextEditingController();
  ScrollController scrollController = ScrollController();

  RxBool isTyping = false.obs;

  UserChatProvider() {
    // Add a listener to the message controller to update typing status
    chatTextController.addListener(() {
      if (chatTextController.text.isNotEmpty && !isTyping.value) {
        isTyping.value = true;

      } else if (chatTextController.text.isEmpty && isTyping.value) {
        isTyping.value = false;

      }
    });
  }

  Future<void> getChatList(context, {required String chatId})async {
    chatList.clear();
    messages.clear();
      isLoading.value = true;
      log("Chat Id=====>> $chatId");

    try {
      var response = await ApiClient.getData("${ApiPaths.chatUrl}$chatId");

      log("Full Response: ${response.body.runtimeType}");
      log("Full Response: ${response.statusCode}");

      var responseBody = response.body["data"]["attributes"];

      log("attributes: $responseBody");

      if (response.statusCode == int.parse("200")) {
        chatList.addAll(responseBody.map((items) => ChatModel.fromJson(items)).toList());

        messages.value = chatList.map((chat) {
          log("=======>>>: ${chat.text}");
          return {
            'text': chat.text ?? '',
            'status': chat.seen == true ? 'Seen' : 'Unseen',
            'senderId' : chat.sender ?? ""
          };
        }).toList();

        SocketServices.makeChatConnection(chatId: chatId);
        getMessage(chatId: chatId);
        scrollToBottom();

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

  Future<bool> sendMessage({required String chatId, required String senderId, required String messageText}) async {
    try {
      log('send message is being called');

      Map<String, String> data = {
        "chat": chatId, // here value will be chat id
        "text": messageText,         // here value will be your send message
        "sender": senderId // here value will be user id
      };

      // Check if the socket is connected before emitting
      if (SocketServices.socket.connected) {
        log('Socket is connected. Emitting client_location event.');

        SocketServices.socket.emitWithAck("send-new-message", data, ack: (response) {
          if (response != null) {

            chatList.add(ChatModel.fromJson(response));
            messages.add({
              'text': response['text'] ?? '',
              'status': response['seen'] == true ? 'Seen' : 'Unseen',
              'senderId' : response['senderId'] ?? ""
            });

            log('Acknowledgment received for send message: ${response}');
            chatTextController.clear();
            scrollToBottom();

            return true;
          } else {
            log('No acknowledgment received or timeout occurred.');
          }
        });
      } else {
        log('Socket is not connected. Unable to emit event.');
      }
    } catch (error, stackTrace) {
      // Catch any unexpected errors and log them
      log('Error in send message: $error');
      log('Stack Trace: $stackTrace');
      return false;
    }
    return false;
  }

  Future<void> getMessage({required String chatId}) async {
    try {

      // Check if the socket is connected before emitting
      if (SocketServices.socket.connected) {
        log('Socket is connected. Getting client_message event.');
        log('User Id: $chatId');

        // ::$userId
        SocketServices.socket.on("new-message-received::$chatId", (data) {
          if(data != null){

            chatList.add(ChatModel.fromJson(data));
            messages.add({
              'text': data['text'] ?? '',
              'status': data['seen'] == true ? 'Seen' : 'Unseen',
              'senderId' : data['senderId'] ?? ""
            });
            scrollToBottom();
          }

          log("======>>>$data<<<=======");


          // return LatLng(double.parse(data["lat"]), double.parse(data["lang"]));

        },);
      } else {
        log('Socket is not connected. Unable to emit event.');
      }
    } catch (error, stackTrace) {
      // Catch any unexpected errors and log them
      log('Error in get message: $error');
      log('Stack Trace: $stackTrace');
    }
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}