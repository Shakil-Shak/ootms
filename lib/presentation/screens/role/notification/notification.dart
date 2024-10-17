import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_text.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/notification_image.png"),
          commonText("There’s no notifications", size: 18, isBold: true),
          commonText("Your notifications will be appear on\nthis page.",
              size: 16, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}
