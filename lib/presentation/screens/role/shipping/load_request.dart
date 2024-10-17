import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';

class LoadRequestPage extends StatelessWidget {
  final List<Map<String, dynamic>> loadRequests = [
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'availability': 'The truck is fully available.',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'availability': 'The truck is fully available.',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'availability': 'The truck is fully available.',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'availability': 'The truck is fully available.',
      'driverImage': 'https://i.pravatar.cc/100',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText('Load Request', size: 21, isBold: true),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(
          height: 16,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: loadRequests.length,
        itemBuilder: (context, index) {
          final request = loadRequests[index];

          return Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(request['driverImage']),
                radius: 24,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText(request['driverName'], size: 16, isBold: true),
                    SizedBox(
                      height: 4,
                    ),
                    commonText(request['truckInfo'], size: 14),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle, size: 12, color: Colors.green),
                        const SizedBox(width: 4),
                        commonText(request['availability'], size: 14),
                      ],
                    ),
                    SizedBox(
                      height: 4,
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
                            child: commonButton("Accept Load",
                                borderRadious: 10, isBold: false),
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
