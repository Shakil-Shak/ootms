// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: AppColor.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Status indicator
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    radius: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 8,
                    ),
                  ),
                  const SizedBox(width: 8),
                  commonText(
                    "The truck is fully available.",
                    size: 14,
                    isBold: true,
                  ),
                ],
              ),
            ),

            // Truck details
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColor.primaryColorLight.withOpacity(0.3),
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(
                    "DHK METRO HA 64-8549",
                    size: 14,
                    isBold: true,
                  ),
                  const SizedBox(height: 4),
                  commonText(
                    "48-foot trailer—24 pallets",
                  ),
                  // Driver details
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/100',
                        ),
                        radius: 24,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText(
                            "Sabbir Hossein",
                            size: 14,
                            isBold: true,
                          ),
                          const SizedBox(height: 4),
                          commonText(
                            "+995 654654 | example@gmail.com",
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      // Message input field
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(
                                  Icons.message,
                                  color: AppColor.black,
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Send a message",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Phone icon button
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            shape: BoxShape.circle,
                            border: Border.all(width: 1)),
                        child: const Icon(
                          Icons.phone,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              color: AppColor.primaryColorLight.withOpacity(0.3),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: commonButton("Cancel",
                        borderRadious: 10,
                        color: Color(0xFFDDDDDD),
                        textColor: AppColor.black),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonButton(
                      "Assign Load",
                      borderRadious: 10,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      print(e);
    }
  }
}
