import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/create_load/map.dart';

class UserCreateLoadPage extends StatefulWidget {
  const UserCreateLoadPage({super.key});

  @override
  _UserCreateLoadPageState createState() => _UserCreateLoadPageState();
}

class _UserCreateLoadPageState extends State<UserCreateLoadPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  final TextEditingController _receiverNameController = TextEditingController();
  final TextEditingController _receiverPhoneController =
      TextEditingController();
  final TextEditingController _receiverEmailController =
      TextEditingController();
  final TextEditingController _receiverAddressController =
      TextEditingController();
  final TextEditingController _receiverCityController = TextEditingController();
  final TextEditingController _receiverStateController =
      TextEditingController();
  final TextEditingController _receiverZipController = TextEditingController();
  final TextEditingController _palletSpacesController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _poController = TextEditingController();
  final TextEditingController _billOfLadingController = TextEditingController();
  final TextEditingController _deliveryInstructionsController =
      TextEditingController();

  final TextEditingController _shipperNameController = TextEditingController();
  final TextEditingController _shipperPhoneController = TextEditingController();
  final TextEditingController _shipperEmailController = TextEditingController();
  final TextEditingController _shipperAddressController =
      TextEditingController();
  final TextEditingController _shipperCityController = TextEditingController();
  final TextEditingController _shipperStateController = TextEditingController();
  final TextEditingController _shipperZipController = TextEditingController();
  final TextEditingController _loadTypeController = TextEditingController();
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _deliveryController = TextEditingController();
  final TextEditingController _trailerSizeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool isHazMat = false; // Controls Yes/No for HazMat
  Map<String, bool> hazMatItems = {
    "Dangerous": false,
    "Flammable Gas 2": true,
    "Poison 6": false,
    "Corrosive": true,
    "Oxygen 2": false,
    "Danger": true,
    "Flammable 3": false,
    "Radioactive 7": true,
    "Non-Flammable Gas": false
  };

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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(
                  0xFF2D4E68), // Background color for the TabBar container
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              children: [receiverInformationTab(), shipperInformationTab()],
            ),
          ),
        ],
      ),
    );
  }

  Widget receiverInformationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Receiver's Information Form Fields
            commonTextfieldWithTitle(
              "Receiver Name",
              _receiverNameController,
              hintText: "Enter full name",
            ),
            SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Receiver Phone",
              _receiverPhoneController,
              hintText: "Enter phone number",
            ),
            SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Receiver Email",
              _receiverEmailController,
              hintText: "Enter email address",
            ),
            SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Receiver Address",
              _receiverAddressController,
              hintText: "Enter address",
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: commonTextfieldWithTitle(
                    "City",
                    _receiverCityController,
                    hintText: "Enter city",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: commonTextfieldWithTitle(
                    "State",
                    _receiverStateController,
                    hintText: "Enter state",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: commonTextfieldWithTitle(
                    "Zip",
                    _receiverZipController,
                    hintText: "Enter zip",
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: commonTextfieldWithTitle(
                    "Pallet Spaces",
                    _palletSpacesController,
                    hintText: "00",
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: commonTextfieldWithTitle(
                    "Weight",
                    _weightController,
                    hintText: "00 lbs",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: commonTextfieldWithTitle(
                    "PO#",
                    _poController,
                    hintText: "00",
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: commonTextfieldWithTitle(
                    "Bill of Lading",
                    _billOfLadingController,
                    hintText: "00 lbs",
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Delivery Instructions",
              _deliveryInstructionsController,
              hintText: "Enter delivery instructions",
              maxLine: 3,
            ),
            SizedBox(height: 16),
            // Next Button
            commonIconButton(
              "Next",
              isRight: true,
              Icon(
                Icons.arrow_forward,
                color: AppColor.white,
              ),
              onTap: () {
                _tabController!.index = 1;
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }

  Widget shipperInformationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonTextfieldWithTitle(
              "Shipper Name",
              _shipperNameController,
              hintText: "Enter full name",
            ),
            SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Shipper Phone",
              _shipperPhoneController,
              hintText: "Enter phone number",
            ),
            SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Shipper Email",
              _shipperEmailController,
              hintText: "Enter email address",
            ),
            SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Shipper Address",
              _shipperAddressController,
              hintText: "Enter address",
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: commonTextfieldWithTitle(
                    "City",
                    _shipperCityController,
                    hintText: "Enter city",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: commonTextfieldWithTitle(
                    "State",
                    _shipperStateController,
                    hintText: "Enter state",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: commonTextfieldWithTitle(
                    "Zip",
                    _shipperZipController,
                    hintText: "Enter zip",
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Load Type",
              _loadTypeController,
              hintText: "Enter load type",
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: commonTextfieldWithTitle(
                    "Pickup",
                    _pickupController,
                    hintText: "MM-DD-YYYY",
                    suffinxIcon: Icon(Icons.calendar_month_outlined, size: 20),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: commonTextfieldWithTitle(
                    "Delivery",
                    _deliveryController,
                    hintText: "MM-DD-YYYY",
                    suffinxIcon: Icon(Icons.calendar_month_outlined, size: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Trailer Size",
              _trailerSizeController,
              hintText: "Enter trailer size",
            ),

            SizedBox(height: 16),

            Card(
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 5),
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
                              groupValue: isHazMat,
                              onChanged: (value) {
                                setState(() {
                                  isHazMat = value!;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            commonText("No"),
                            Radio<bool>(
                              value: false,
                              groupValue: isHazMat,
                              onChanged: (value) {
                                setState(() {
                                  isHazMat = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Checkbox list of HazMat items
                    Column(
                      children: hazMatItems.keys.map((String key) {
                        return CheckboxListTile(
                          title: commonText(key, isBold: true),
                          value: hazMatItems[key],
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (bool? value) {
                            setState(() {
                              hazMatItems[key] = value!;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            commonTextfieldWithTitle(
              "Description",
              _descriptionController,
              hintText: "Enter description",
              maxLine: 3,
            ),
            SizedBox(height: 16),

            // Find Driver Button
            commonButton(
              "Find A Driver",
              onTap: () {
                animetedNavigationPush(Map3Page(), context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
