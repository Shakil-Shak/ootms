import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_shipping_details.dart';

class DriverShippingHistoryPage extends StatelessWidget {
  DriverShippingHistoryPage({super.key});

  final List<Map<String, dynamic>> requests = [
    {
      'date': '25 June 2024, 04:40 PM',
      'from': 'Rupatoli, Barishal.',
      'to': 'Banasree, Dhaka',
      'price': '\$11',
      'driver': 'Sabbir Hossein',
      'driverImage': 'https://i.pravatar.cc/100',
      'shippingId': '#GD62G'
    },
    {
      'date': '25 June 2024, 04:40 PM',
      'from': 'Rupatoli, Barishal.',
      'to': 'Banasree, Dhaka',
      'price': '\$11',
      'driver': 'Sabbir Hossein',
      'driverImage': 'https://i.pravatar.cc/100',
      'shippingId': '#GD62G'
    },
    {
      'date': '25 June 2024, 04:40 PM',
      'from': 'Rupatoli, Barishal.',
      'to': 'Banasree, Dhaka',
      'price': '\$11',
      'driver': 'Sabbir Hossein',
      'driverImage': 'https://i.pravatar.cc/100',
      'shippingId': '#GD62G'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        centerTitle: true,
        title: commonText("Shipping History", size: 21, isBold: true),
        backgroundColor: AppColor.white,
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DriverShippingDetailsPage(
                    shippingId: request['shippingId'],
                    date: request['date'],
                    from: request['from'],
                    to: request['to'],
                    driver: request['driver'],
                    driverImage: request['driverImage'],
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 2,
                  color: Colors.black26,
                ),
                // Date and price
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      commonText(request['date'], size: 16, isBold: true),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          commonText(request['price'], size: 16, isBold: true),
                          const Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 16,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Route information
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/icons/arrow_up.png"),
                                const SizedBox(width: 4),
                                Expanded(
                                    child:
                                        commonText(request['from'], size: 14)),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/icons/arrow_up.png"),
                                const SizedBox(width: 4),
                                Expanded(
                                    child: commonText(request['to'], size: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage(request['driverImage']),
                        radius: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(thickness: 4, color: Colors.black26),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      commonText(
                        "REQUEST AGAIN",
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Divider(
                  thickness: 4,
                  color: Colors.black26,
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
