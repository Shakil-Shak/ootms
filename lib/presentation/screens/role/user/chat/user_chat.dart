import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/common/chat_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:provider/provider.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

class UserChatPage extends StatefulWidget {

  String chatId;
  String senderId;

  UserChatPage({super.key, required this.chatId, required this.senderId});

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  ChatController chatController = Get.find<ChatController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Scroll to the bottom of the list after the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chatController.scrollController.hasClients) {
        chatController.scrollController.jumpTo(chatController.scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<UserChatProvider>(context);
    log("SenderId ${widget.senderId}");

    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
                radius: 20,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText('Sabbir Hossein', size: 16, isBold: true),
                  commonText('Online', size: 12, color: Colors.green),
                ],
              ),
            ],
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: chatController.isLoading.value? const Center(child: CircularProgressIndicator()) :Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatController.scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages[index];
                  log("message $message");
                  final isSentByMe = chatController.messages[index]['senderId'] == widget.senderId? true : false;
                  log("chatController.messages[index]['senderId']: ${chatController.messages[index]['senderId']}");
                  log("isSentByMe: $isSentByMe");
                  return Align(
                    alignment:
                    isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: isSentByMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: isSentByMe
                                ? AppColor.primaryColor
                                : AppColor.primaryColorLight,
                            borderRadius: isSentByMe
                                ? const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                                topLeft: Radius.circular(16))
                                : const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                                topRight: Radius.circular(16)),
                          ),
                          child: commonText(
                            message['text'],
                            size: 14,
                            color: isSentByMe ? Colors.white : Colors.black,
                          ),
                        ),
                        if (isSentByMe && message.containsKey('status'))
                          commonText(
                            message['status'],
                            size: 12,
                            color: Colors.grey,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Typing status
            if (chatController.isTyping.value)
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: commonText("Sabbir is typing...",
                        size: 12, color: Colors.grey),
                  ),
                ],
              ),

            // Message Input Field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.message),
                            ),
                            Expanded(
                              child: TextField(
                                controller: chatController.chatTextController,
                                decoration: const InputDecoration(
                                  hintText: "Type something...",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: AppColor.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      chatController.sendMessage(chatId: widget.chatId, senderId: widget.senderId, messageText: chatController.chatTextController.text);
                      // chatProvider
                      //     .sendMessage(chatProvider.messageController.text);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },);
  }
}

class UserChatProvider with ChangeNotifier {
  final TextEditingController messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {
      'text': 'I have some loads, can you transfer them to Dhaka safely?',
      'isSentByMe': true,
      'status': 'Seen',
    },
    {
      'text': 'Oh it’s okay.',
      'isSentByMe': false,
    },
    {
      'text': 'Next time, we will meet again',
      'isSentByMe': true,
      'status': 'Seen',
    },
    {
      'text': 'Oh it’s okay i like it too babe',
      'isSentByMe': false,
    },
    {
      'text': 'Okay see you soon very soon',
      'isSentByMe': true,
      'status': 'Seen',
    },
  ];



  void sendMessage(String message) {
    if (message.isNotEmpty) {
      messages
          .insert(0, {'text': message, 'isSentByMe': true, 'status': 'Seen'});
      messageController.clear();
      notifyListeners(); // Notify listeners when a new message is sent
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
