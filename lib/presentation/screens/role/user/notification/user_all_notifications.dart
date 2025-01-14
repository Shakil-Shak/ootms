// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';

import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_load_request_details.dart';

class UserAllNotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> loadRequests = [
    {
      'title': 'Your Shipment is delivered by driver, please confirm it first.',
      'time': '16 minutes ago',
      'read': false
    },
    {
      'title': 'You have a load request from driver.',
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

  int rating = 4;
  final TextEditingController commentController = TextEditingController();

  UserAllNotificationsPage({super.key});

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Container(
              width: MediaQuery.of(context).size.width, // Full width

              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: commonText(
                        "Your Shipment is delivered by driver, please\nconfirm it first.",
                        isBold: true,
                        textAlign: TextAlign.center,
                        size: 16),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: commonButton(
                          "No",
                          textColor: AppColor.black,
                          borderRadious: 10,
                          color: AppColor.primaryColorLight.withOpacity(0.5),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: commonButton(
                        "Yes",
                        borderRadious: 10,
                        onTap: () {
                          Navigator.pop(context);
                          _showBottomSheetRatting(context);
                        },
                      ))
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showBottomSheetRatting(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    commonText(
                      'Your Shipment Has Been\nDelivered To The Receiver.',
                      size: 18,
                      isBold: true,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color:
                                index < rating ? Colors.yellow : AppColor.black,
                            size: 30,
                          ),
                          onPressed: () {},
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 8,
                    ),
                    const SizedBox(height: 10),
                    commonText("Leave a comment for driver.",
                        size: 16, isBold: true),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 3,
                        child: commonTextfield(commentController,
                            borderColor: Colors.transparent,
                            hintText: "Leave A Comment For Driver"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    commonButton(
                      "Submit",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: commonText('Notifications', size: 21, isBold: true),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              "assets/images/empty.png",
              height: 80,
              width: 80,
            ),
            commonText("No notification found",
                color: AppColor.black, size: 12),
            const SizedBox(
              height: 20,
            )
          ],
        ))
        // (loadRequests.isEmpty)
        //     ? const UserEmptyNotificationPage()
        //     : ListView.separated(
        //         separatorBuilder: (context, index) => const SizedBox(
        //           height: 4,
        //         ),
        //         itemCount: loadRequests.length,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             tileColor: (loadRequests[index]['read'] == false)
        //                 ? AppColor.primaryColorLight
        //                 : Colors.transparent,
        //             leading: Image.asset(
        //               "assets/icons/user home page/notify.png",
        //             ),
        //             title: commonText(loadRequests[index]['title'], size: 16),
        //             subtitle: commonText(loadRequests[index]['time'], size: 14),
        //             onTap: () {
        //               if (index == 1) {
        //                 animetedNavigationPush(
        //                     UserLoadRequestDetailsPage(), context);
        //               } else {
        //                 _showBottomSheet(context);
        //               }
        //             },
        //           );
        //         },
        //       ),
        );
  }
}

class UserEmptyNotificationPage extends StatelessWidget {
  const UserEmptyNotificationPage({super.key});

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
