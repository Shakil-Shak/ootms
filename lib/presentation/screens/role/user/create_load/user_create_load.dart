import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/user/nearest_driver_controller/find_nearest_driver_controller.dart';
import 'package:ootms/presentation/api/controllers/user/load_controller/load_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map2.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/assign_preferred_driver.dart';
import 'package:provider/provider.dart';

class UserCreateLoadPage extends StatefulWidget {
  const UserCreateLoadPage({super.key});

  @override
  _UserCreateLoadPageState createState() => _UserCreateLoadPageState();
}

class _UserCreateLoadPageState extends State<UserCreateLoadPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String selectedValue = "";

  FindNearestDriverController nearestDriverController = Get.find<FindNearestDriverController>();

  // Controls Yes/No for HazMat

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

  // @override
  // void dispose() {
  //   _tabController?.dispose();
  //   super.dispose();
  // }

  bool isHazMat = false;
  int visibleItemCount = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: commonText("Create Load", size: 21, isBold: true),
          centerTitle: true,
        ),
        body: Consumer<LoadController>(
          builder: (context, controller, child) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D4E68),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TabBar(
                    controller: _tabController,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: AppColor.primaryColorLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(
                        child: FittedBox(
                          child: commonText(
                            "Receiver\nInformation",
                            textAlign: TextAlign.center,
                            isBold: true,
                            size: 21,
                            color: (_tabController!.index == 0)
                                ? AppColor.black
                                : AppColor.white,
                          ),
                        ),
                      ),
                      Tab(
                        child: FittedBox(
                          child: commonText(
                            "Shipper's\nInformation",
                            textAlign: TextAlign.center,
                            isBold: true,
                            size: 21,
                            color: (_tabController!.index == 1)
                                ? AppColor.black
                                : AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      receiverInformationTab(),
                      shipperInformationTab()
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }

  buildMenuItem(String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(
        value,
        style: TextStyle(
          color: selectedValue == value ? Colors.blue : AppColor.black,
        ),
      ),
    );
  }

  //========================================================================================load type
  Widget loadTypePopup(BuildContext parentContext) {
    return Consumer<LoadController>(
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset offset = renderBox.localToGlobal(Offset.zero);
            Size size = renderBox.size;

            double availableHeight = MediaQuery.of(parentContext).size.height;

            double iconPositionTop = offset.dy;
            double iconPositionBottom =
                availableHeight - (offset.dy + size.height);

            double topPosition = iconPositionBottom > 200
                ? offset.dy + size.height
                : offset.dy - 200;

            double bottomPosition = iconPositionBottom > 200
                ? -offset.dy - size.height
                : availableHeight - offset.dy;

            showMenu<String>(
              context: parentContext,
              position: RelativeRect.fromLTRB(
                  offset.dx + size.width, topPosition, 0, bottomPosition),
              items: [
                buildMenuItem('48 ft Dry Van'),
                buildMenuItem('53 ft Dry Van'),
                buildMenuItem('Refrigerated (Reefer)'),
                buildMenuItem('Curtain-side'),
                buildMenuItem('Open Trailers'),
                buildMenuItem('Flatbed'),
                buildMenuItem('Step Deck'),
                buildMenuItem('Lowboy'),
                buildMenuItem('RGN (Removable Gooseneck)'),
                buildMenuItem('Specialized'),
                buildMenuItem('Tanker'),
                buildMenuItem('Hopper'),
                buildMenuItem('Livestock'),
                buildMenuItem('Roll-Off'),
                buildMenuItem('Logging - Tree Length'),
                buildMenuItem('Logging - Double-bunk'),
              ],
              elevation: 8.0,
            ).then((value) {
              if (value != null) {
                selectedValue = value;
                setState(() {});
                controller.loadTypeController.value =
                    TextEditingValue(text: value);
              }
            });
          },
          child: const Icon(Icons.keyboard_arrow_down),
        );
      },
    );
  }

  //========================================================================================porduct type
  Widget productTypePopup(BuildContext parentContext) {
    return Consumer<LoadController>(
      builder: (context, controller, child) {
        return GestureDetector(
          onTap: () {
            RenderBox renderBox = context.findRenderObject() as RenderBox;
            Offset offset = renderBox.localToGlobal(Offset.zero);
            Size size = renderBox.size;

            double availableHeight = MediaQuery.of(parentContext).size.height;

            double iconPositionTop = offset.dy;
            double iconPositionBottom =
                availableHeight - (offset.dy + size.height);

            double topPosition = iconPositionBottom > 200
                ? offset.dy + size.height
                : offset.dy - 200;

            double bottomPosition = iconPositionBottom > 200
                ? -offset.dy - size.height
                : availableHeight - offset.dy;

            showMenu<String>(
              context: parentContext,
              position: RelativeRect.fromLTRB(
                  offset.dx + size.width, topPosition, 0, bottomPosition),
              items: [
                buildMenuItem('Pine Pulpwood'),
                buildMenuItem('Pine Mulch'),
                buildMenuItem('Pine Super Pulpwood'),
                buildMenuItem('Pine Chip-N-Saw'),
                buildMenuItem('Pine Sawtimber'),
                buildMenuItem('Pine Poles'),
                buildMenuItem('Hardwood Pulpwood'),
                buildMenuItem('Hardwood Mulch'),
                buildMenuItem('Hardwood Palletwood'),
                buildMenuItem('Hardwood Crossties'),
                buildMenuItem('Hardwood Sawtimber'),
                buildMenuItem('Hardwood Plylogs'),
                buildMenuItem('Hardwood Poles'),
                buildMenuItem('Cypress Mulch'),
              ],
              elevation: 8.0,
            ).then((value) {
              if (value != null) {
                selectedValue = value;
                setState(() {});
                controller.productTypeCtrl.value =
                    TextEditingValue(text: value);
              }
            });
          },
          child: const Icon(Icons.keyboard_arrow_down),
        );
      },
    );
  }

  Widget receiverInformationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(child: Consumer<LoadController>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText("Receiver’s Information",
                  color: AppColor.black, size: 16, isBold: true),
              const Divider(),
              commonTextfieldWithTitle(
                "Receiver Name",
                value.receiverNameController,
                hintText: "Enter full name",
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                "Receiver Phone",
                value.receiverPhoneController,
                hintText: "Enter phone number",
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                "Receiver Email",
                value.receiverEmailController,
                hintText: "Enter email address",
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitleSideButton(
                context,
                "Receiver Address",
                value.receiverAddressController,
                hintText: "Enter address",
                isReceiver: true,
                enable: false,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "City",
                      value.receiverCityController,
                      hintText: "Enter city",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "State",
                      value.receiverStateController,
                      hintText: "Enter state",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "Zip",
                      value.receiverZipController,
                      hintText: "Enter zip",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "Pallet Spaces",
                      value.palletSpacesController,
                      hintText: "00",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "Weight",
                      value.weightController,
                      hintText: "00 lbs",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "PO#",
                      value.poController,
                      hintText: "00",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "Bill of Lading",
                      value.billOfLadingController,
                      hintText: "00 lbs",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                "Delivery Instructions",
                value.deliveryInstructionsController,
                hintText: "Enter delivery instructions",
                maxLine: 3,
              ),
              const SizedBox(height: 16),
              // Next Button
              Consumer<LoadController>(
                builder: (context, value, child) {
                  return commonIconButton(
                    "Next",
                    isRight: true,
                    const Icon(
                      Icons.arrow_forward,
                      color: AppColor.white,
                    ),
                    onTap: () {
                      setState(() {
                        _tabController!.index = 1;
                        // value.createLoad();
                        print("===================================topu");
                      });
                    },
                  );
                },
              )
            ],
          );
        },
      )),
    );
  }

  Widget shipperInformationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(child: Consumer<LoadController>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText("Shipper’s Information",
                  color: AppColor.black, size: 16, isBold: true),
              const Divider(),
              commonTextfieldWithTitle(
                "Shipper Name",
                value.shipperNameController,
                hintText: "Enter full name",
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                "Shipper Phone",
                value.shipperPhoneController,
                hintText: "Enter phone number",
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                "Shipper Email",
                value.shipperEmailController,
                hintText: "Enter email address",
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitleSideButton(
                context,
                "Shipper Address",
                value.shipperAddressController,
                hintText: "Enter address",
                isReceiver: false,
                enable: false
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "City",
                      value.shipperCityController,
                      hintText: "Enter city",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "State",
                      value.shipperStateController,
                      hintText: "Enter state",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "Zip",
                      value.shipperZipController,
                      hintText: "Enter zip",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                readOnly: true,
                "Trailer Type",
                value.loadTypeController,
                suffinxIcon: loadTypePopup(context),
                hintText: "Trailer Type",
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                readOnly: true,
                "Product Type",
                value.productTypeCtrl,
                suffinxIcon: productTypePopup(context),
                hintText: "Product Type",
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "Pickup",
                      value.pickupController,
                      readOnly: true,
                      hintText: "MM-DD-YYYY",
                      suffinxIcon: InkWell(
                          onTap: () {
                            value.pickPickupDate();
                          },
                          child: const Icon(Icons.calendar_month_outlined,
                              size: 20)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "Delivery",
                      value.deliveryController,
                      readOnly: true,
                      hintText: "MM-DD-YYYY",
                      suffinxIcon: InkWell(
                          onTap: () {
                            value.pickdelivaryDate();
                          },
                          child: const Icon(Icons.calendar_month_outlined,
                              size: 20)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                "Trailer Size",
                value.trailerSizeController,
                hintText: "Trailer Size",
              ),
              const SizedBox(height: 16),

              Card(
                elevation: 3,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  height: value.isHazMat == true
                      ? 600
                      : 100, // Adjust height as needed
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          commonText("HazMat", isBold: true, size: 16),
                          Row(
                            children: [
                              commonText("Yes"),
                              Radio<bool>(
                                value: true,
                                groupValue: value.isHazMat,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      value.isHazMat = newValue;
                                    });
                                  }
                                },
                              ),
                              const SizedBox(width: 10),
                              commonText("No"),
                              Radio<bool>(
                                value: false,
                                groupValue: value.isHazMat,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      value.isHazMat = newValue;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (value.isHazMat == true)
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children:
                                  value.hazMatItems.keys.map((String key) {
                                return CheckboxListTile(
                                  title: commonText(key, isBold: true),
                                  value: value.hazMatItems[key],
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      value.hazMatItems[key] = newValue!;
                                    });
                                    if (newValue != null) {
                                      value.updateHazMatItem(key, newValue);
                                    }
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              commonTextfieldWithTitle(
                "Description",
                value.descriptionController,
                hintText: "Enter description",
                maxLine: 3,
              ),
              const SizedBox(height: 10),

              commonTextfieldWithTitle(
                "Shipment Payment",
                value.paymentCtl,
                hintText: "Write your messege",
              ),
              const SizedBox(height: 16),

              // Find Driver Button
              commonButton(
                "Create Load",
                isLoading: value.isLoading,
                onTap: () async {
                  await value.createLoad(context: context);

                  if (value.isSuccess == true) {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              commonText(
                                'Do you have preferred Driver?',
                                size: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // "No" Button
                                  TextButton(
                                    onPressed: () async {
                                      await nearestDriverController.findNearestDriver(createdLoadId: value.loadId);
                                      animetedNavigationPush(
                                          const UserMap2Page(), context);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.grey.shade300,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: commonText(
                                      'No',
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // "Yes" Button
                                  TextButton(
                                    onPressed: () {
                                      animetedNavigationPush(
                                          AssignPreferredDriver(), context);
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.blueGrey.shade800,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: commonText(
                                      'Yes',
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  // animetedNavigationPush(const UserMap3Page(), context);
                },
              ),
            ],
          );
        },
      )),
    );
  }
}
