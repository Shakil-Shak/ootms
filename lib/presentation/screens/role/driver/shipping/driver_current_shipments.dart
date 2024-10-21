import 'dart:math';

import 'package:flutter/material.dart';

import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_current%20_shipment_details.dart';

class DriverCurrentShipmentsPage extends StatelessWidget {
  final List<Map<String, dynamic>> loadRequests = [
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'Rupatoli, Barishal.',
      'to': 'Banasree, Dhaka',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'Rupatoli, Barishal.',
      'to': 'Banasree, Dhaka',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'Rupatoli, Barishal.',
      'to': 'Banasree, Dhaka',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'from': 'Rupatoli, Barishal.',
      'to': 'Banasree, Dhaka',
      'driverImage': 'https://i.pravatar.cc/100',
    },
  ];

  DriverCurrentShipmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText('Current Shipments', size: 21, isBold: true),
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

          return InkWell(
            onTap: () {
              animetedNavigationPush(
                  const DriverCurrentShipmentDetailsPage(), context);
            },
            child: Row(
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
                      const SizedBox(
                        height: 4,
                      ),
                      commonText(request['truckInfo'], size: 14),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  "assets/icons/arrow_up.png",
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                    child:
                                        commonText(request['from'], size: 14)),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Transform.rotate(
                                    angle: pi,
                                    child: Image.asset(
                                        "assets/icons/arrow_up.png")),
                                const SizedBox(width: 4),
                                Expanded(
                                    child: commonText(request['to'], size: 14)),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
