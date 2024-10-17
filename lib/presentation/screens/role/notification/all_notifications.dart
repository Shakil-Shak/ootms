import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';

import 'package:ootms/presentation/components/common_text.dart';

class AllNotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> loadRequests = [
    {
      'title': 'Your Shipment is delivered by driver, please confirm it first.',
      'time': '16 minutes ago',
      'read': false
    },
    {
      'title': 'Your Shipment is delivered by driver, please confirm it first.',
      'time': '16 minutes ago',
      'read': false
    },
    {
      'title': 'Your Shipment is delivered by driver, please confirm it first.',
      'time': '16 minutes ago',
      'read': true
    },
    {
      'title': 'Your Shipment is delivered by driver, please confirm it first.',
      'time': '16 minutes ago',
      'read': true
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText('Notifications', size: 21, isBold: true),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 4,
        ),
        itemCount: loadRequests.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: (loadRequests[index]['read'] == false)
                ? AppColor.primaryColorLight
                : Colors.transparent,
            leading: Image.asset(
              "assets/icons/user home page/notify.png",
            ),
            title: commonText(loadRequests[index]['title'], size: 16),
            subtitle: commonText(loadRequests[index]['time'], size: 14),
          );
        },
      ),
    );
  }
}
