import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/Driver/load_request_controller/load_request_controller.dart';
import 'package:ootms/presentation/api/models/driver_model/load_request_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_load_request_details.dart';

class DriverLoadRequestPage extends StatefulWidget {
  DriverLoadRequestPage({super.key});

  @override
  State<DriverLoadRequestPage> createState() => _DriverLoadRequestPageState();
}

class _DriverLoadRequestPageState extends State<DriverLoadRequestPage> {
  DriverLoadRequest driverLoadCtl = Get.find<DriverLoadRequest>();
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        driverLoadCtl.handleScrollController();
        driverLoadCtl.getDriverLoadReg();
      },
    );
  }

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
        body: GetBuilder<DriverLoadRequest>(
          builder: (controller) {
            return controller.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  )
                : controller.loadRequestData.isEmpty
                    ? Center(child: commonText("Load Request Empty"))
                    : ListView.separated(
                        controller: controller.scrollController,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        itemCount: controller.loadRequestData.length,
                        itemBuilder: (context, index) {
                          DriverLoadModel data =
                              controller.loadRequestData[index];

                          return InkWell(
                            onTap: () {
                              animetedNavigationPush(
                                  DriverLoadRequestDetailsPage(
                                    shipperPhone: data.load.shipperPhoneNumber,
                                    shipperName: data.load.shipperName,
                                    shipperRating: data.user.ratings.toString(),
                                    shipperEmail: data.load.shipperEmail,
                                    shipperAddress: data.load.shippingAddress,
                                    reciverName: data.load.receivingAddress,
                                    reciverPhone: data.load.receiverPhoneNumber,
                                    reciverEmail: data.load.receivingAddress,
                                    reciverAddress: data.load.receivingAddress,
                                    rating: data.user.ratings.toString(),
                                    description: data.load.description,
                                    deliveryInstructions:
                                        data.load.deliveryInstruction,
                                    loadType: data.load.loadType,
                                    trailerSize:
                                        data.load.trailerSize.toString(),
                                    weight: data.load.weight.toString(),
                                    hazmat: data.load.hazmat,
                                    pickupDate: OtherHelper.getDate(
                                        serverDate:
                                            data.load.pickupDate.toString()),
                                    deliveryDate: OtherHelper.getDate(
                                        serverDate:
                                            data.load.deliveryDate.toString()),
                                  ),
                                  context);
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: AppColor.primaryColor,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        ApiPaths.baseUrl + data.user.image),
                                    radius: 24,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      commonText(data.load.loadType,
                                          size: 16, isBold: true),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      commonText(data.truck.truckNumber,
                                          size: 14),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      commonText(
                                        "${data.load.shippingAddress} To ${data.load.receivingAddress}",
                                      ),
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
                                                isLoading: data.isReject
                                                    ? data.isLoading
                                                    : false,
                                                isBold: false,
                                                borderRadious: 8,
                                                loadingColor: AppColor.primaryColor,
                                                onTap: () {
                                                  controller.loadRequestReject(
                                                      loadRequestId: data.id,
                                                      context: context,
                                                      index: index);
                                                },
                                                color: AppColor
                                                    .primaryColorLight
                                                    .withOpacity(0.5),
                                                textColor: AppColor.black,
                                              ),
                                            ),
                                            Expanded(
                                              child: commonButton("Accept Load",
                                                  isLoading: data.isAccept
                                                      ? data.isLoading
                                                      : false, onTap: () {
                                                controller.loadRequestAccept(
                                                    loadRequestId: data.id,
                                                    index: index,
                                                    context: context);
                                              },
                                                  borderRadious: 8,
                                                  isBold: false),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
          },
        ));
  }
}
