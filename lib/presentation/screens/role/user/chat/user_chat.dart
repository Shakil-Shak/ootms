import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:provider/provider.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

class UserChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<UserChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
              radius: 20,
            ),
            SizedBox(width: 10),
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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(16),
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messages[index];
                final isSentByMe = message['isSentByMe'];
                return Align(
                  alignment:
                      isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: isSentByMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        margin: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          color: isSentByMe
                              ? AppColor.primaryColor
                              : AppColor.primaryColorLight,
                          borderRadius: isSentByMe
                              ? BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                  topLeft: Radius.circular(16))
                              : BorderRadius.only(
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
          if (chatProvider.isTyping)
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
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return DraggableScrollableSheet(
                          expand: false,
                          builder: (context, scrollController) {
                            return Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Full width

                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(Icons.cancel))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  commonButton("Request for Take The Load")
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.white,
                      ),
                      child: Icon(Icons.add, color: AppColor.black),
                    ),
                  ),
                ),
                SizedBox(width: 10),
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Icon(Icons.message),
                          ),
                          Expanded(
                            child: TextField(
                              controller: chatProvider.messageController,
                              decoration: InputDecoration(
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
                  icon: Icon(Icons.send),
                  onPressed: () {
                    chatProvider
                        .sendMessage(chatProvider.messageController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
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

  bool isTyping = false;

  UserChatProvider() {
    // Add a listener to the message controller to update typing status
    messageController.addListener(() {
      if (messageController.text.isNotEmpty && !isTyping) {
        isTyping = true;
        notifyListeners(); // Notify listeners when typing starts
      } else if (messageController.text.isEmpty && isTyping) {
        isTyping = false;
        notifyListeners(); // Notify listeners when typing stops
      }
    });
  }

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
