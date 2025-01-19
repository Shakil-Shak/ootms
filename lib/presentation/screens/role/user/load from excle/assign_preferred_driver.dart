// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/user/load_controller/load_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/color/app_color.dart';
import '../../../../api/controllers/user/prefered_driver_controller/prefered_driver_controller.dart';
import '../../../../api/models/user_model/prefered_driver_model.dart/prefered_driver_model.dart';
import '../../../../api/url_paths.dart';
import '../../../../components/common_image.dart';

class AssignPreferredDriver extends StatefulWidget {
  const AssignPreferredDriver({super.key});

  @override
  State<AssignPreferredDriver> createState() => _AssignPreferredDriverState();
}

class _AssignPreferredDriverState extends State<AssignPreferredDriver> {
  final PreferedDriverController driverCtl =
      Get.find<PreferedDriverController>();

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        driverCtl.getPreferedDriver();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText("Assign Preferred Driver", size: 21, isBold: true),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LoadController>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Driver ID", size: 18),
                  const SizedBox(height: 16),
                  commonTextfield(value.driverIdcontroller,
                      hintText: "Enter the driver ID here"),
                  const SizedBox(height: 16),
                  commonButton(
                    isLoading: value.isLoading,
                    "Continue",
                    onTap: () {
                      value.assignPrefferedDriver(context: context);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  commonText("My Prefered Driver",
                      size: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  GetBuilder<PreferedDriverController>(builder: (controller) {
                    return Expanded(
                      child: driverCtl.isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.primaryColor,
                              ),
                            )
                          : driverCtl.driverList.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 40),
                                      CommonImage(
                                        imageSrc: "assets/images/empty.png",
                                        imageType: ImageType.png,
                                        height: 60,
                                        width: 60,
                                      ),
                                      commonText("No prefered Driver found")
                                    ],
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: driverCtl.driverList.length,
                                  itemBuilder: (context, index) {
                                    print(
                                        "mydriver=============================================${driverCtl.driverList}");
                                    PreferredDriverModel data =
                                        driverCtl.driverList[index];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          value.driverIdcontroller.text =
                                              data.driverInfo!.id.toString();
                                        });
                                      },
                                      child: prefiredDriverCard(
                                        imagePath: data.driverInfo!.image!,
                                        drivername:
                                            data.driverInfo!.fullName ?? "",
                                        driverId: data.driverInfo!.userId ?? "",
                                        rating:
                                            data.driverInfo!.ratings.toString(),
                                      ),
                                    );
                                  }),
                    );
                  })
                ],
              );
            },
          )),
    );
  }

  prefiredDriverCard({
    required String imagePath,
    required String drivername,
    required String rating,
    required String driverId,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 14, 13, 13).withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CommonImage(
                imageSrc: "${ApiPaths.baseUrl}${imagePath}",
                imageType: ImageType.network,
                size: 50,
                borderRadius: 100,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(drivername,
                      size: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      commonText(rating,
                          size: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.black),
                    ],
                  ),
                  commonText("Driver ID: $driverId",
                      size: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.black),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
