import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_load_request_details.dart';

class DriverLoadRequestPage extends StatelessWidget {
  final List<Map<String, dynamic>> loadRequests = [
    {
      'loadType': 'Dry Load.',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'Rupatoli, Barishal',
      'to': 'Banani, Dhaka',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'loadType': 'Dry Load.',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'Rupatoli, Barishal',
      'to': 'Banani, Dhaka',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'loadType': 'Dry Load.',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'Rupatoli, Barishal',
      'to': 'Banani, Dhaka',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'loadType': 'Dry Load.',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'Rupatoli, Barishal',
      'to': 'Banani, Dhaka',
      'driverImage': 'https://i.pravatar.cc/100',
    },
  ];

  DriverLoadRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText('Load Request', size: 21, isBold: true),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: loadRequests.length,
        itemBuilder: (context, index) {
          final request = loadRequests[index];

          return Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColor.primaryColor,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(request['driverImage']),
                  radius: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(request['loadType'], size: 16, isBold: true),
                    const SizedBox(
                      height: 4,
                    ),
                    commonText(request['truckInfo'], size: 14),
                    const SizedBox(
                      height: 4,
                    ),
                    commonText("${request['from']} To ${request['to']}",
                        size: 14),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: commonButton(
                              "Cancel",
                              isBold: false,
                              borderRadious: 10,
                              onTap: () {
                                // Add your cancel action
                              },
                              color:
                                  AppColor.primaryColorLight.withOpacity(0.5),
                              textColor: AppColor.black,
                            ),
                          ),
                          Expanded(
                            child: commonButton("Accept Load", onTap: () {
                              animetedNavigationPush(
                                  DriverLoadRequestDetailsPage(), context);
                            }, borderRadious: 10, isBold: false),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
