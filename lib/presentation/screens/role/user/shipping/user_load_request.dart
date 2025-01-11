// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ootms/core/constants/color/app_color.dart';
// import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
// import 'package:ootms/presentation/api/url_paths.dart';
// import 'package:ootms/presentation/components/common_button.dart';
// import 'package:ootms/presentation/components/common_image.dart';
// import 'package:ootms/presentation/components/common_text.dart';
// import 'package:ootms/presentation/navigation/animeted_navigation.dart';
// import 'package:ootms/presentation/screens/role/user/shipping/user_load_request_details.dart';
// import 'package:provider/provider.dart';

// import '../../../../api/models/user_model/load_request_model/load_request_model.dart';

// class UserLoadRequestPage extends StatefulWidget {
//   final bool isFromDrawer;
//   const UserLoadRequestPage({super.key, this.isFromDrawer = false});

//   @override
//   State<UserLoadRequestPage> createState() => _UserLoadRequestPageState();
// }

// class _UserLoadRequestPageState extends State<UserLoadRequestPage>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController!.addListener(
//       () {
//         setState(() {});
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: commonText('Load Request', size: 21, isBold: true),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.pop(context);
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 Provider.of<ProfileController>(context, listen: false)
//                     .getLoadRequestData(context: context, callFromHome: true);
//               });
//             },
//           ),
//         ),
//         body: Consumer<ProfileController>(
//           builder: (context, controller, child) {
//             return Stack(
//               children: [
// Column(
//                         children: [
//                           Visibility(
//                             visible: widget.isFromDrawer,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFF2D4E68),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10, horizontal: 20),
//                               margin:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               child: TabBar(
//                                 controller: _tabController,
//                                 dividerColor: Colors.transparent,
//                                 indicator: BoxDecoration(
//                                   color: AppColor.primaryColorLight,
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 indicatorSize: TabBarIndicatorSize.tab,
//                                 onTap: (value) {
//                                   if (value == 0) {
//                                     WidgetsBinding.instance
//                                         .addPostFrameCallback((_) {
//                                       controller.getLoadRequestData(
//                                           context: context, callFromHome: true);
//                                     });
//                                   } else {
//                                     WidgetsBinding.instance
//                                         .addPostFrameCallback((_) {
//                                       controller.getLoadRequestData(
//                                           context: context,
//                                           requestType: true,
//                                           callFromHome: true);
//                                     });
//                                   }
//                                 },
//                                 tabs: [
//                                   Tab(
//                                     child: FittedBox(
//                                       child: commonText(
//                                         "Load Request",
//                                         textAlign: TextAlign.center,
//                                         isBold: true,
//                                         size: 18,
//                                         color: (_tabController!.index == 0)
//                                             ? AppColor.black
//                                             : AppColor.white,
//                                       ),
//                                     ),
//                                   ),
//                                   Tab(
//                                     child: FittedBox(
//                                       child: commonText(
//                                         "My Request",
//                                         textAlign: TextAlign.center,
//                                         isBold: true,
//                                         size: 18,
//                                         color: (_tabController!.index == 1)
//                                             ? AppColor.black
//                                             : AppColor.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // controller.isLoading? SizedBox(
//                           //   height: Get.height * 0.5,
//                           //     width: Get.width,
//                           //     child: Center(child: CircularProgressIndicator())) :
      

//                     // controller.isLoading? SizedBox(
//                     //   height: Get.height * 0.5,
//                     //     width: Get.width,
//                     //     child: Center(child: CircularProgressIndicator())) :
//                     Expanded(
//                             child: controller.loadRequestData.isEmpty
//                                 ? Center(
//                                 child: Column(
//                                   children: [
//                                     const SizedBox(
//                                       height: 50,
//                                     ),
//                                     Image.asset(
//                                       "assets/images/empty.png",
//                                       height: 80,
//                                       width: 80,
//                                       color: Colors.grey,
//                                     ),
//                                     commonText("No request found",
//                                         color: AppColor.black, size: 12),
//                                     const SizedBox(
//                                       height: 20,
//                                     )
//                                   ],
//                                 ))
//                                 : ListView.separated(
//                               separatorBuilder: (context, index) => const SizedBox(
//                                 height: 16,
//                               ),
//                               padding: const EdgeInsets.all(16.0),
//                               itemCount: controller.loadRequestData.length,
//                               itemBuilder: (context, index) {
//                                 LoadRequestModel request =
//                                     controller.loadRequestData[index];

//                                 return Row(
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               CommonImage(
//                                                 imageSrc: ApiPaths.baseUrl + request.driver.image,
//                                                 imageType: ImageType.network,
//                                                 size: 50,
//                                                 borderRadius: 100,
//                                               ),
//                                               const SizedBox(width: 16),
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   commonText(
//                                                       request.driver.fullName,
//                                                       size: 16,
//                                                       isBold: true),
//                                                   const SizedBox(
//                                                     height: 4,
//                                                   ),
//                                                   commonText("${request.load.trailerSize}-foot trailer-${request.load.palletSpace} pallets.",
//                                                       size: 14),
//                                                   const SizedBox(
//                                                     height: 4,
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       const Icon(Icons.circle,
//                                                           size: 12,
//                                                           color: Colors.green),
//                                                       const SizedBox(width: 4),
//                                                       commonText("The truck is fully available.",
//                                                           size: 14),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                           const SizedBox(
//                                             height: 4,
//                                           ),
//                                           SizedBox(
//                                             height: 40,
//                                             child: Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: commonButton(
//                                                     "Cancel",
//                                                     isBold: false,
//                                                     borderRadious: 10,
//                                                     onTap: () {
//                                                       // Add your cancel action
//                                                     },
//                                                     color: AppColor
//                                                         .primaryColorLight
//                                                         .withOpacity(0.5),
//                                                     textColor: AppColor.black,
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child: commonButton("Accept Load",
//                                                       onTap: () {
//                                                     animetedNavigationPush(
//                                                         UserLoadRequestDetailsPage(
//                                                           driverName: request
//                                                               .driver.fullName,
//                                                           driverPhone: request
//                                                               .driver.phoneNumber,
//                                                           driverAddress: request
//                                                               .driver.address,
//                                                           driverEmail:
//                                                               request.driver.email,
//                                                           truckNumber: request
//                                                               .truck.truckNumber,
//                                                           trailerSize: request
//                                                               .truck.trailerSize
//                                                               .toString(),
//                                                           palletSpaces: request
//                                                               .truck.palletSpace
//                                                               .toString(),
//                                                           availability:
//                                                               "Fully Available",
//                                                         ),
//                                                         context);
//                                                   },
//                                                       borderRadious: 10,
//                                                       isBold: false),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                 if (controller.isLoadRequest)
//                   Positioned.fill(
//                     child: Container(
//                       color: Colors.black.withOpacity(0.5),
//                       child: const Center(
//                         child: CircularProgressIndicator(),
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_image.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_load_request_details.dart';
import 'package:provider/provider.dart';

import '../../../../api/models/user_model/load_request_model/load_request_model.dart';

class UserLoadRequestPage extends StatefulWidget {
  final bool isFromDrawer;
  const UserLoadRequestPage({super.key, this.isFromDrawer = false});

  @override
  State<UserLoadRequestPage> createState() => _UserLoadRequestPageState();
}

class _UserLoadRequestPageState extends State<UserLoadRequestPage>
    with SingleTickerProviderStateMixin {

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(
      () {
        setState(() {});
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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Provider.of<ProfileController>(context, listen: false).getLoadRequestData(context: context, callFromHome: true);
              });
            },
          ),
        ),
        body: Consumer<ProfileController>(
          builder: (context, controller, child) {
            return Stack(
              children: [
                Column(
                  children: [
                    Visibility(
                      visible: widget.isFromDrawer,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D4E68),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: TabBar(
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: AppColor.primaryColorLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          onTap: (value) {
                            if(value == 0){
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              controller.getLoadRequestData(context: context, callFromHome: true);
                            });
                            }else{WidgetsBinding.instance.addPostFrameCallback((_) {
                              controller.getLoadRequestData(context: context, requestType: true, callFromHome: true);});
                            }
                          },
                          tabs: [
                            Tab(
                              child: FittedBox(
                                child: commonText(
                                  "Load Request",
                                  textAlign: TextAlign.center,
                                  isBold: true,
                                  size: 18,
                                  color: (_tabController!.index == 0)
                                      ? AppColor.black
                                      : AppColor.white,
                                ),
                              ),
                            ),
                            Tab(
                              child: FittedBox(
                                child: commonText(
                                  "My Request",
                                  textAlign: TextAlign.center,
                                  isBold: true,
                                  size: 18,
                                  color: (_tabController!.index == 1)
                                      ? AppColor.black
                                      : AppColor.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // controller.isLoading? SizedBox(
                    //   height: Get.height * 0.5,
                    //     width: Get.width,
                    //     child: Center(child: CircularProgressIndicator())) :
                    Expanded(
                            child: controller.loadRequestData.isEmpty
                                ? Center(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    Image.asset(
                                      "assets/images/empty.png",
                                      height: 80,
                                      width: 80,
                                      color: Colors.grey,
                                    ),
                                    commonText("No request found",
                                        color: AppColor.black, size: 12),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ))
                                : ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(
                                height: 16,
                              ),
                              padding: const EdgeInsets.all(16.0),
                              itemCount: controller.loadRequestData.length,
                              itemBuilder: (context, index) {
                                LoadRequestModel request =
                                    controller.loadRequestData[index];

                                return GestureDetector(
                                  onTap: () {
                                    animetedNavigationPush(
                                        UserLoadRequestDetailsPage(
                                          driverName: request
                                              .driver.fullName,
                                          driverPhone: request
                                              .driver.phoneNumber,
                                          driverAddress: request
                                              .driver.address,
                                          driverEmail:
                                          request.driver.email,
                                          truckNumber: request
                                              .truck.truckNumber,
                                          trailerSize: request
                                              .truck.trailerSize
                                              .toString(),
                                          palletSpaces: request
                                              .truck.palletSpace
                                              .toString(),
                                          availability:
                                          "Fully Available",
                                        ),
                                        context);
                                  },
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CommonImage(
                                                  imageSrc: ApiPaths.baseUrl + request.driver.image,
                                                  imageType: ImageType.network,
                                                  size: 50,
                                                  borderRadius: 100,
                                                ),
                                                const SizedBox(width: 16),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    commonText(
                                                        request.driver.fullName,
                                                        size: 16,
                                                        isBold: true),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    commonText("${request.load.trailerSize}-foot trailer-${request.load.palletSpace} pallets.",
                                                        size: 14),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.circle,
                                                            size: 12,
                                                            color: Colors.green),
                                                        const SizedBox(width: 4),
                                                        commonText("The truck is fully available.",
                                                            size: 14),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 50.0),
                                              child: SizedBox(
                                                height: 40,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: commonButton(
                                                        "Reject Load",
                                                        isBold: false,
                                                        borderRadious: 10,
                                                        margin: 10,
                                                        onTap: () {
                                                          // Add your cancel action
                                                        },
                                                        color: AppColor
                                                            .primaryColorLight
                                                            .withOpacity(0.5),
                                                        textColor: AppColor.black,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: commonButton("Assign Load",
                                                          onTap: () {},
                                                          borderRadious: 10,
                                                          margin: 10,
                                                          isBold: false),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
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
                if (controller.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
              ],
            );
          },
        ));
  }
}