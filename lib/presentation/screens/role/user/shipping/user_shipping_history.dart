import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/user/load_request_controller/load_request_controller.dart';
import 'package:ootms/presentation/api/models/user_model/shiping_model/shipping_history_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_shipping_details.dart';
import 'package:provider/provider.dart';

import '../../../../api/controllers/user/shipping_controller/shipping_history_controller.dart';

class UserShippingHistoryPage extends StatelessWidget {
  UserShippingHistoryPage({super.key});

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
      body: Consumer<ShippinfHistoryController>(
        builder: (context, value, child) {
          return Stack(
            children: [
              value.shippingHistoryData.isEmpty
                  ? SizedBox(
                      height: Get.height,
                      child: Center(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/empty.png",
                            height: 80,
                            width: 80,
                          ),
                          commonText("No Shipping History Found",
                              color: AppColor.black, size: 12),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      )),
                    )
                  : ListView.builder(
                      itemCount: value.shippingHistoryData.length,
                      itemBuilder: (context, index) {
                        final request = requests[index];
                        ShippingHistoryModel data =
                            value.shippingHistoryData[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the details page
                            // Navigator.push(
                            //   context,
                            // MaterialPageRoute(
                            //   builder: (context) => UserShippingDetailsPage(
                            //     shippingId: data.id,
                            //     date: OtherHelper.getDate(serverDate: data.load.deliveryDate.toString()),
                            //     from: data.load.shippingAddress,
                            //     to: data.load.receivingAddress,
                            //     driver: data.driver.fullName,
                            //     driverImage: ApiPaths.baseUrl+ data.driver.image,
                            //   ),
                            // ),
                            // );
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonText(
                                        "${OtherHelper.getDate(serverDate: data.load.deliveryDate.toString())}, ${OtherHelper.getTime(serverDate: data.load.deliveryDate.toString())}",
                                        size: 16,
                                        isBold: true),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        commonText(request['price'],
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                  "assets/icons/arrow_up.png"),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                  child: commonText(
                                                      data.load.shippingAddress,
                                                      size: 14)),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(
                                                  "assets/icons/arrow_up.png"),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                  child: commonText(
                                                      data.load
                                                          .receivingAddress,
                                                      size: 14)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          ApiPaths.baseUrl + data.driver.image),
                                      radius: 20,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              // const Divider(thickness: 4, color: Colors.black26),
                              const SizedBox(
                                height: 8,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              //   child: Row(
                              //     children: [
                              //       commonText(
                              //         "REQUEST AGAIN",
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              const SizedBox(
                                height: 8,
                              ),
                              // const Divider(
                              //   thickness: 4,
                              //   color: Colors.black26,
                              // ),
                              // const SizedBox(
                              //   height: 8,
                              // ),
                            ],
                          ),
                        );
                      },
                    ),
              // Loading overlay
              if (value.isLoading)
                const Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
