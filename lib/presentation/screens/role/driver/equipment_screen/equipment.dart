// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ootms/core/constants/color/app_color.dart';
// import 'package:ootms/presentation/api/controllers/Driver/equipment_controller/equipment_controller.dart';
// import 'package:ootms/presentation/components/common_text.dart';
// import 'package:ootms/presentation/navigation/animeted_navigation.dart';
// import 'package:ootms/presentation/screens/role/driver/equipment_screen/add_equipment_screen.dart';
// class MyEquipmentPage extends StatefulWidget {
//   const MyEquipmentPage({super.key});

//   @override
//   State<MyEquipmentPage> createState() => _MyEquipmentPageState();
// }

// class _MyEquipmentPageState extends State<MyEquipmentPage> {
//   final EquipmentController equipmentController =
//       Get.find<EquipmentController>();
//   @override
//   Widget build(BuildContext context) {
//     equipmentController.getEquipmentData();
//     return Scaffold(
//         appBar: AppBar(
//           actions: [
//             InkWell(
//               onTap: () {
//                 animetedNavigationPush(AddEquipmentScreen(), context);
//               },
//               child: Container(
//                 height: 34,
//                 width: 128,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: AppColor.black)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     commonText("+ Add Equipment",
//                         size: 12,
//                         color: AppColor.black,
//                         fontWeight: FontWeight.w500)
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             )
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 commonText("My Trucks", size: 16, isBold: true),
//                 const SizedBox(height: 8),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: equipmentController.equipmentData[0].truck.length,
//                   itemBuilder: (context, index) {
//                     var data =
//                         equipmentController.equipmentData[0].truck[index];
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 4.0),
//                       child: commonText(
//                         "${index + 1}. ${data.truckNumber.toString().isNotEmpty ? data.truckNumber.toString() : "TRK554834"}",
//                         size: 16,
//                         isBold: true,
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 commonText("My Trailers", size: 16, isBold: true),
//                 const SizedBox(height: 8),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount:
//                       equipmentController.equipmentData[0].trailer.length,
//                   itemBuilder: (context, index) {
//                     var trailerData =
//                         equipmentController.equipmentData[1].trailer[index];
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 4.0),
//                       child: commonText(
//                         "${index + 1}. ${trailerData.trailerSize}-foot ${trailerData.palletSpace} pallets.",
//                         size: 16,
//                         isBold: true,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/Driver/equipment_controller/equipment_controller.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/equipment_screen/add_equipment_screen.dart';

class MyEquipmentPage extends StatefulWidget {
  const MyEquipmentPage({super.key});

  @override
  State<MyEquipmentPage> createState() => _MyEquipmentPageState();
}

class _MyEquipmentPageState extends State<MyEquipmentPage> {
  final EquipmentController equipmentController =
      Get.find<EquipmentController>();

  @override
  void initState() {
    super.initState();
    equipmentController.getEquipmentData(); // Fetch data on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              animetedNavigationPush(const AddEquipmentScreen(), context);
            },
            child: Container(
              height: 34,
              width: 128,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColor.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  commonText("+ Add Equipment",
                      size: 12,
                      color: AppColor.black,
                      fontWeight: FontWeight.w500),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GetBuilder<EquipmentController>(
          builder: (controller) {
            if (controller.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final equipment = controller.equipmentData;

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset(AppIcons.truck)),
                          const SizedBox(
                            width: 5,
                          ),
                          commonText("My Trucks", size: 22, isBold: true),
                        ],
                      ),
                      const SizedBox(
                          width: 160,
                          child: Divider(
                            color: AppColor.black,
                          ))
                    ],
                  ),
                  const SizedBox(height: 8),
                  equipment.truck.isEmpty
                      ? SizedBox(
                          height: Get.height / 4,
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
                              commonText("Truck Empty",
                                  color: AppColor.black, size: 12),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          )),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: equipment.truck.length,
                          itemBuilder: (context, index) {
                            var truck = equipment.truck[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: commonText(
                                "${index + 1}. ${truck.truckNumber}",
                                size: 16,
                                isBold: true,
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: SvgPicture.asset(AppIcons.trailer)),
                          const SizedBox(
                            width: 5,
                          ),
                          commonText("My Trailers", size: 22, isBold: true),
                        ],
                      ),
                      const SizedBox(
                          width: 180,
                          child: Divider(
                            color: AppColor.black,
                          ))
                    ],
                  ),
                  const SizedBox(height: 8),
                  equipment.trailer.isEmpty
                      ? SizedBox(
                          height: Get.height / 4,
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
                              commonText("Trailer Empty",
                                  color: AppColor.black, size: 12),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          )),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: equipment.trailer.length,
                          itemBuilder: (context, index) {
                            var trailer = equipment.trailer[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: commonText(
                                "${index + 1}. ${trailer.trailerSize}-foot trailer ${trailer.palletSpace} pallets.",
                                size: 16,
                                isBold: true,
                              ),
                            );
                          },
                        ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
