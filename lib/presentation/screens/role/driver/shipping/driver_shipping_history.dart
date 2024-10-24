import 'package:flutter/material.dart';
import 'package:ootms/core/constants/assets/images_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_shipping_details.dart';

class DriverShippingHistoryPage extends StatelessWidget {
  DriverShippingHistoryPage({super.key});
  final List<Map<String, dynamic>> requests = [
    {
      'date': '25 June 2024, 04:40 PM',
      'from': 'Rupatoli, Barishal',
      'to': 'Banasree, Dhaka',
      'price': '\$11',
      'shippingId': '#GD62G',
      'reciverAddress': '123 Banasree, Dhaka',
      'reciverEmail': 'receiver1@example.com',
      'reciverName': 'John Doe',
      'reciverPhone': '123-456-7890',
      'shipperAddress': '45 Rupatoli, Barishal',
      'shipperEmail': 'shipper1@example.com',
      'shipperName': 'Jane Smith',
      'shipperPhone': '987-654-3210',
      'driverImage': AppImages.profile
    },
    {
      'date': '26 June 2024, 02:30 PM',
      'from': 'Rupatoli, Barishal',
      'to': 'Banani, Dhaka',
      'price': '\$12',
      'shippingId': '#GH54H',
      'reciverAddress': '456 Banani, Dhaka',
      'reciverEmail': 'receiver2@example.com',
      'reciverName': 'Alice Johnson',
      'reciverPhone': '234-567-8901',
      'shipperAddress': '45 Rupatoli, Barishal',
      'shipperEmail': 'shipper2@example.com',
      'shipperName': 'Bob Brown',
      'shipperPhone': '876-543-2109',
      'driverImage': AppImages.profile
    },
    {
      'date': '27 June 2024, 01:15 PM',
      'from': 'Rupatoli, Barishal',
      'to': 'Uttara, Dhaka',
      'price': '\$13',
      'shippingId': '#HJ76J',
      'reciverAddress': '789 Uttara, Dhaka',
      'reciverEmail': 'receiver3@example.com',
      'reciverName': 'Charlie Davis',
      'reciverPhone': '345-678-9012',
      'shipperAddress': '45 Rupatoli, Barishal',
      'shipperEmail': 'shipper3@example.com',
      'shipperName': 'Diana Prince',
      'shipperPhone': '765-432-1098',
      'driverImage': AppImages.profile
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
                          reciverAddress: request['reciverAddress'],
                          reciverEmail: request['reciverEmail'],
                          reciverName: request['reciverName'],
                          reciverPhone: request['reciverPhone'],
                          shipperAddress: request['shipperAddress'],
                          shipperEmail: request['shipperEmail'],
                          shipperName: request['shipperName'],
                          shipperPhone: request['shipperPhone'],
                        )),
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
                          commonText("\$${request['price']}",
                              size: 16, isBold: true),
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
                        backgroundImage: AssetImage(request['driverImage']),
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
              ],
            ),
          );
        },
      ),
    );
  }
}
