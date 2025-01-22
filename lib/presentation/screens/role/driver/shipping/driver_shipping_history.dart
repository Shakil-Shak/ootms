import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_currentshiping_controller/driver_shiping_history.dart';
import 'package:ootms/presentation/api/models/driver_model/driver_shiphistory_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_image.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_shipping_details.dart';


class DriverShippingHistoryPage extends StatefulWidget {
  DriverShippingHistoryPage({super.key});

  @override
  State<DriverShippingHistoryPage> createState() =>
      _DriverShippingHistoryPageState();
}

class _DriverShippingHistoryPageState extends State<DriverShippingHistoryPage> {
  final DriverShipingHistory shipingController =
      Get.find<DriverShipingHistory>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
      () {
        shipingController.getDriverShipingHistory();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          centerTitle: true,
          title: commonText("Shipping History", size: 21, isBold: true),
          backgroundColor: AppColor.white,
        ),
        body: GetBuilder<DriverShipingHistory>(builder: (controller) {
          return controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                )
              : controller.shipingHistory.isEmpty
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
                          commonText("Shiping History Empty",
                              color: AppColor.black, size: 12),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      )),
                    )
                  : ListView.builder(
                      itemCount: controller.shipingHistory.length,
                      itemBuilder: (context, index) {
                        DriverShipHistoryModel data =
                            controller.shipingHistory[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DriverShippingDetailsPage(
                                        data: data,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    commonText(
                                        "${OtherHelper.getDate(serverDate: data.load.deliveryDate.toString())}",
                                        size: 16,
                                        isBold: true),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        commonText("\$20",
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
                                    CommonImage(
                                        imageSrc:
                                            ApiPaths.baseUrl + data.user.image)
                                    // CircleAvatar(
                                    //   backgroundImage: AssetImage(request['driverImage']),
                                    //   radius: 20,
                                    // ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Divider(
                                  thickness: 4, color: Colors.black26),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        );
                      },
                    );
        }));
  }
}
