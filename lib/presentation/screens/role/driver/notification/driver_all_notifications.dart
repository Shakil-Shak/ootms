// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/common/notification_controller.dart';
import 'package:ootms/presentation/api/models/notification_model.dart';
import 'package:ootms/presentation/components/common_button.dart';

import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_map2.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_load_request_details.dart';

class DriverAllNotificationsPage extends StatefulWidget {

  DriverAllNotificationsPage({super.key});

  @override
  State<DriverAllNotificationsPage> createState() => _DriverAllNotificationsPageState();
}

class _DriverAllNotificationsPageState extends State<DriverAllNotificationsPage> {
  final List<Map<String, dynamic>> loadRequests = [
    {
      'title': 'You have a load request.',
      'time': '16 minutes ago',
      'read': false
    },
    {
      'title': 'You have a load near you.',
      'time': '16 minutes ago',
      'read': false
    },
    {
      'title': 'You have a load request.',
      'time': '16 minutes ago',
      'read': true
    },
    {
      'title': 'You have a load request.',
      'time': '16 minutes ago',
      'read': true
    },
  ];

  int rating = 4;

  final TextEditingController commentController = TextEditingController();

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

  NotificationController notificationController = Get.find<NotificationController>();

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
     notificationController.getNotificationList();
     notificationController.handleScrollController();
    },);
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
      body: GetBuilder<NotificationController>(builder: (controller) {
        return controller.isLoading? const Center(child: CircularProgressIndicator())
            : controller.notificationList.isEmpty
            ? const DriverEmptyNotificationPage()
            : ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
          controller: controller.scrollController,
          itemCount: controller.notificationList.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.notificationList.length) {
              return controller.isMoreLoading
                  ? const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(child: CircularProgressIndicator()),
              )
                  : const SizedBox.shrink();
            }
            NotificationModel notificationItem = controller.notificationList[index];
            return ListTile(
              tileColor: notificationItem.isRead
                  ? AppColor.primaryColorLight
                  : Colors.transparent,
              leading: Image.asset(
                "assets/icons/user home page/notify.png",
              ),
              title: commonText(notificationItem.message, size: 16),
              subtitle: commonText(OtherHelper.getTimeDifference(notificationItem.createdAt), size: 14),
              onTap: () {
                controller.changeNotificationStatus(notificationId: notificationItem.id, index: index);
                if (notificationItem.type == "map") {
                  animetedNavigationPush(const DriverMap2Page(), context);
                } else {
                  DriverLoadRequestDetailsPage.loadId = notificationItem.linkId;
                  animetedNavigationPush(DriverLoadRequestDetailsPage(), context);
                }

                // _showBottomSheet(context);
              },
            );
          },
        );
      },)
    );
  }
}

class DriverEmptyNotificationPage extends StatelessWidget {
  const DriverEmptyNotificationPage({super.key});


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
