import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/user/load_controller/load_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
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

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

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
                "Receiver Address",
                value.receiverAddressController,
                hintText: "Enter address",
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
                "Shipper Address",
                value.shipperAddressController,
                hintText: "Enter address",
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
                "Trailer Type",
                value.loadTypeController,
                hintText: "Trailer Type",
              ),
              const SizedBox(height: 16),
              commonTextfieldWithTitle(
                "Product Type",
                value.productTypeCtrl,
                hintText: "Product Type",
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "Pickup",
                      value.pickupController,
                      hintText: "MM-DD-YYYY",
                      suffinxIcon:
                          const Icon(Icons.calendar_month_outlined, size: 20),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: commonTextfieldWithTitle(
                      "Delivery",
                      value.deliveryController,
                      hintText: "MM-DD-YYYY",
                      suffinxIcon:
                          const Icon(Icons.calendar_month_outlined, size: 20),
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
                child: Container(
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
                              const SizedBox(
                                width: 10,
                              ),
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
                      Column(
                        children: value.hazMatItems.keys.map((String key) {
                          return CheckboxListTile(
                            title: commonText(key, isBold: true),
                            value: value.hazMatItems[key],
                            controlAffinity: ListTileControlAffinity.trailing,
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
                onTap: () {
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
                                  onPressed: () {
                                    Navigator.pop(context);
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
