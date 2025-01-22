import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_image.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/chat/user_chat_details.dart';
import 'package:provider/provider.dart';

class UserChatListPage extends StatelessWidget {

  UserChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ProfileController>(builder: (context, controller, child) {
        return Stack(
          children: [

            controller.isCurrentShip == false &&
                controller.currentShipData.isEmpty
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
                      commonText("No Current Shipment Found",
                          color: AppColor.black, size: 12),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  )),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(
                    'Current Shipments',
                    size: 18,
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      padding: const EdgeInsets.only(bottom: 10.0),
                      itemCount: controller.currentShipData.length,
                      itemBuilder: (context, index) {
                        var data = controller.currentShipData[index];

                        return InkWell(
                          onTap: () {
                            animetedNavigationPush(UserChatDetailsScreen(shipmentDetails: data,), context);
                          },
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: AppColor.primaryColor, width: 4)
                                ),
                                child: CommonImage(
                                  imageSrc: ApiPaths.baseUrl +
                                      data.driver.image,
                                  imageType: ImageType.network,
                                  fill: BoxFit.cover,
                                  size: 40,
                                  borderRadius: 100,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText(data.driver.fullName,
                                        size: 16, isBold: true),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    commonText("${data.load.trailerSize}- foot trailer -- ${data.load.palletSpace} pallets", size: 14),
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
                                                  child: commonText(
                                                    data.load.shippingAddress,
                                                  )),
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
                                                  child: commonText(
                                                    data.load.receivingAddress,
                                                  )),
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
                  ),
                ],
              ),
            ),

            // Loading overlay
            if (controller.isCurrentShip)
              const Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        AppColor.primaryColor),
                  ),
                ),
              ),
          ],
        );
      },),
    );
  }
}
