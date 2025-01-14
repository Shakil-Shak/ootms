import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/chat/driver_chat.dart';
import 'package:provider/provider.dart';

class DriverChatListPage extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {
      'name': 'Sabbir Hossein',
      'message': 'Hai, what’s up bro. hayu atuh hangout dei jang Sabrina',
      'time': '2:30 PM',
      'imageUrl': 'https://i.pravatar.cc/100', // Replace with your image URL
    },
    // Add more messages here if needed
    {
      'name': 'Sabbir Hossein',
      'message': 'Hai, what’s up bro. hayu atuh hangout dei jang Sabrina',
      'time': '2:30 PM',
      'imageUrl': 'https://i.pravatar.cc/100', // Replace with your image URL
    },
    {
      'name': 'Sabbir Hossein',
      'message': 'Hai, what’s up bro. hayu atuh hangout dei jang Sabrina',
      'time': '2:30 PM',
      'imageUrl': 'https://i.pravatar.cc/100', // Replace with your image URL
    },
  ];

  DriverChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Card(
              elevation: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search messages...",
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Messages list
            commonText("Messages", isBold: true, size: 16),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: InkWell(
                      onTap: () {
                        animetedNavigationPush(
                            ChangeNotifierProvider(
                                create: (context) => DriverChatProvider(),
                                child: DriverChatPage()),
                            context);
                      },
                      child: Row(
                        children: [
                          // Profile picture
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(message['imageUrl']!),
                          ),
                          const SizedBox(width: 12),

                          // Message details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commonText(
                                  message['name']!,
                                  size: 14,
                                  isBold: true,
                                ),
                                const SizedBox(height: 4),
                                commonText(
                                  message['message']!,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),

                          // Message time
                          commonText(
                            message['time']!,
                            size: 10,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
