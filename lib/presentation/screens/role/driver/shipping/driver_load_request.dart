
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/shipping/driver_load_request_details.dart';
import 'package:provider/provider.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../api/controllers/Driver/load_request_controller/load_request_controller.dart';
import '../../../../api/models/driver_model/load_request_model.dart';

class DriverLoadRequestPage extends StatefulWidget {
  final bool isFromDrawer;
  DriverLoadRequestPage({
    super.key,
    this.isFromDrawer = false,
  });

  @override
  State<DriverLoadRequestPage> createState() => _DriverLoadRequestPageState();
}

class _DriverLoadRequestPageState extends State<DriverLoadRequestPage>
    with SingleTickerProviderStateMixin {
  DriverLoadRequest driverLoadCtl = Get.find<DriverLoadRequest>();
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
              Provider.of<ProfileController>(context, listen: false)
                  .getLoadRequestData(context: context, callFromHome: true);
            });
          },
        ),
      ),
      body: Column(
        children: [
          Visibility(
            visible: widget.isFromDrawer,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2D4E68),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
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
                  if (value == 0) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      driverLoadCtl.getDriverLoadReg(
                          context: context, callFromHome: true);
                    });
                  } else {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      driverLoadCtl.getDriverLoadReg(
                          context: context,
                          requestType: true,
                          callFromHome: true);
                    });
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
          Expanded(child: Obx(() {
            return driverLoadCtl.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  )
                : driverLoadCtl.loadRequestData.isEmpty
                    ? Center(child: commonText("Load Request Empty"))
                    : ListView.separated(
                        controller: driverLoadCtl.scrollController,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        itemCount: driverLoadCtl.loadRequestData.length,
                        itemBuilder: (context, index) {
                          DriverLoadModel data =
                              driverLoadCtl.loadRequestData[index];

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
                                    tabIndex: _tabController!.index,
                                    index: index,
                                    data: data,
                                    loadReqId: data.id,
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
                                      commonText(data.load.shipperName,
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
                                      _tabController!.index == 0?
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
                                                loadingColor:
                                                    AppColor.primaryColor,
                                                onTap: () {
                                                  driverLoadCtl
                                                      .loadRequestReject(
                                                          loadRequestId:
                                                              data.id,
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
                                                driverLoadCtl.loadRequestAccept(
                                                    loadRequestId: data.id,
                                                    index: index,
                                                    context: context);
                                              },
                                                  borderRadious: 8,
                                                  isBold: false),
                                            ),
                                          ],
                                        ),
                                      ):SizedBox(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
          })),
        ],
      ),
    );
  }
}
