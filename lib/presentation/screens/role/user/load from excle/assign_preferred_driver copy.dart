import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/user/prefered_driver_controller/prefered_driver_controller.dart';
import 'package:ootms/presentation/api/models/user_model/prefered_driver_model.dart/prefered_driver_model.dart';
import 'package:ootms/presentation/api/models/user_model/prefered_driver_model.dart/search_prefered_driver_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_image.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/debouncer.dart';

class AddPreferredDriverPage2 extends StatefulWidget {
  const AddPreferredDriverPage2({super.key});

  @override
  _AddPreferredDriverPage2State createState() =>
      _AddPreferredDriverPage2State();
}

class _AddPreferredDriverPage2State extends State<AddPreferredDriverPage2> {

  final PreferedDriverController driverCtl = Get.find<PreferedDriverController>();

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  void _search(String query) {
    driverCtl.getPreferredDriver();
    debugPrint("Searching for: $query");
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
    driverCtl.getMyPreferredDriver();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: commonText("Add Preferred Driver", size: 21, isBold: true),
          centerTitle: true,
        ),
        body: GetBuilder<PreferedDriverController>(builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/driverIcon.png",
                        color: AppColor.black,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controller.searchController,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            _debouncer.run(() {
                              _search(value);
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter your driver’s phone",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Icon(Icons.search, color: AppColor.primaryColor,),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     controller.getPreferredDriver();
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //       backgroundColor: AppColor.primaryColor),
                      //   child: commonText("Search", color: AppColor.white),
                      // ),
                      const SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
                controller.searchController.text.isEmpty? const SizedBox.shrink() : Expanded(
                  child: driverCtl.isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        )
                      : driverCtl.searchPreferredDriverList.isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  const SizedBox(height: 40),
                                  CommonImage(
                                    imageSrc: "assets/images/empty.png",
                                    imageType: ImageType.png,
                                    height: 60,
                                    width: 60,
                                  ),
                                  commonText("No Driver found")
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemCount: controller.searchPreferredDriverList.length,
                              itemBuilder: (context, index) {
                                SearchPreferredDriverModel data = controller.searchPreferredDriverList[index];
                                log("=======????>>>>${data.fullName}");
                                return preferredDriverCard(
                                  onTap: () {
                                    controller.addPreferredDriver(context,driverId: data.id);
                                  },
                                  imagePath: data.image,
                                  drivername: data.fullName,
                                  driverId: data.userId,
                                  rating: data.ratings.toString(),
                                );
                              }),
                ) ,

                SizedBox(height: 20,),
                commonText("My Preferred Driver", size: 16, isBold: true),
                SizedBox(height: 20,),
                Expanded(
                  child: driverCtl.isMyDriverLoading == true
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  )
                      : driverCtl.myPreferredDriverList.isEmpty
                      ? Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        CommonImage(
                          imageSrc: "assets/images/empty.png",
                          imageType: ImageType.png,
                          height: 60,
                          width: 60,
                        ),
                        commonText("No preferred Driver found")
                      ],
                    ),
                  )
                      :ListView.builder(
                      itemCount: controller.myPreferredDriverList.length,
                      itemBuilder: (context, index) {
                        PreferredDriverModel data = controller.myPreferredDriverList[index];
                        log("=======????>>>>${data.driverInfo.fullName}");
                        return preferredDriverCard(
                          onTap: () {},
                          imagePath: data.driverInfo.image,
                          drivername: data.driverInfo.fullName,
                          driverId: data.driverInfo.userId,
                          rating: data.driverInfo.ratings.toString(),
                        );
                      }),
                )
              ],
            ),
          );
        }));
  }

  preferredDriverCard({
    required String imagePath,
    required String drivername,
    required String rating,
    required String driverId,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 14, 13, 13).withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CommonImage(
                  imageSrc: "${ApiPaths.baseUrl}$imagePath",
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
      ),
    );
  }
}


                // const SizedBox(height: 20),
                // if (_driverFound)
                //   ListTile(
                //     leading: const CircleAvatar(
                //       backgroundImage: AssetImage(
                //           "assets/driver_image.png"), // Replace with actual image
                //     ),
                //     title: commonText(_driverName, size: 14, isBold: true),
                //     subtitle: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           children: [
                //             const Icon(Icons.star, color: Colors.yellow, size: 16),
                //             const SizedBox(width: 4),
                //             commonText(_driverRating, size: 14),
                //           ],
                //         ),
                //         RichText(
                //           text: TextSpan(
                //             text: 'Driver ID:', // Normal text before the number
                //             style: const TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.w500,
                //               color: Colors.black,
                //             ),
                //             children: [
                //               TextSpan(
                //                 text: _driverId,
                //                 style: const TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.normal,
                //                   color: Colors.black,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // if (!_driverFound && _phoneController.text.isNotEmpty)
                //   Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //     child: Column(
                //       children: [
                //         commonText("There is not any driver in this number.",
                //             size: 18, fontWeight: FontWeight.w500),
                //         const SizedBox(height: 10),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             RichText(
                //               text: TextSpan(
                //                 text:
                //                     'Send app link to “', // Normal text before the number
                //                 style: const TextStyle(
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.normal,
                //                   color: Colors.black, // Ensure proper color
                //                 ),
                //                 children: [
                //                   TextSpan(
                //                     text:
                //                         _phoneController.text, // Bold the phone number
                //                     style: const TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                     ),
                //                   ),
                //                   const TextSpan(
                //                     text: '”.', // Normal text after the number
                //                     style: TextStyle(
                //                       fontWeight: FontWeight.normal,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             const SizedBox(width: 10),
                //             ElevatedButton(
                //               onPressed: () {
                //                 // Logic to send app link
                //               },
                //               style: ElevatedButton.styleFrom(
                //                   backgroundColor: AppColor.primaryColor),
                //               child: commonText("Send", color: AppColor.white),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
