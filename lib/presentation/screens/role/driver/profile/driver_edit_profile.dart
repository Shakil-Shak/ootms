// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/screens/role/common/country_model.dart';
import 'package:provider/provider.dart';

import '../../../../api/controllers/user/profile_controller/profile_controller.dart';
import '../../../../api/controllers/user/profile_controller/update_profile_controller.dart';

class DriverEditProfile extends StatefulWidget {
  const DriverEditProfile({super.key});

  @override
  State<DriverEditProfile> createState() => _DriverEditProfileState();
}

class _DriverEditProfileState extends State<DriverEditProfile> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String _selectedCountry = 'USA';

  final List<Country> countries = [
    Country('United States', '+1', 'assets/images/usaflag.png'),
    Country('Canada', '+1', 'assets/images/usaflag.png'),
    Country('United Kingdom', '+44', 'assets/images/usaflag.png'),
    Country('Australia', '+61', 'assets/images/usaflag.png'),
    // Add more countries as needed
  ];

  Country? selectedCountry;

  TextEditingController phoneController = TextEditingController();
    final UpdateProfileController editController =
      Get.find<UpdateProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: commonText("Edit Profile", size: 21, isBold: true),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: ChangeNotifierProvider(
          create: (controller) => ProfileController(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              width: 1, color: AppColor.primaryColor)),
                      child: Consumer<ProfileController>(
                          builder: (context, controller, child) {
                        return Stack(
                          children: [
                            editController.image != null
                                ? Container(
                                    height: 80,
                                    width: 80,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.file(
                                      File(editController.image!),
                                      width: 128,
                                      height: 128,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : Container(
                                    width: 80,
                                    height: 80,
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: AppColor.primaryColor,
                                        borderRadius: BorderRadius.circular(40),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/icons/profile_icon_2.png"),
                                            fit: BoxFit.cover)),
                                  ),
                            Positioned(
                              bottom: 5,
                              right: 5,
                              child: InkWell(
                                onTap: () {
                                  editController.getProfileImage();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 12,
                                  child: Icon(Icons.mode_edit_outline_outlined,
                                      size: 16, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        );
                      })),
                  commonTextfieldWithTitle("Full Name", fullNameController,
                      hintText: "Full Name", keyboardType: TextInputType.text),
                  const SizedBox(height: 20),
                  commonTextfieldWithTitle("Email", emailController,
                      assetIconPath: "assets/icons/emailicon.png",
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 20),
                  // ======================================phone picker

                  commonTextfieldWithTitle("Phone", phoneController,
                      prifixIconWidget:
                          Image.asset("assets/images/usaflag.png"),
                      hintText: "Enter your phone",
                      keyboardType: TextInputType.emailAddress),
                  // commonTextfieldWithTitle(
                  //   "Phone",
                  //   phoneController,
                  //   hintText: "Enter your phone number",
                  //   prifixIconWidget: Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 8),
                  //     child: FittedBox(
                  //       child: DropdownButton<Country>(
                  //         value: selectedCountry ?? countries[0],
                  //         onChanged: (Country? newValue) {
                  //           setState(() {
                  //             selectedCountry = newValue;
                  //           });
                  //         },
                  //         items: countries.map<DropdownMenuItem<Country>>(
                  //             (Country country) {
                  //           return DropdownMenuItem<Country>(
                  //             value: country,
                  //             child: Image.asset(country.flag),
                  //           );
                  //         }).toList(),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      commonText(
                        "Country",
                        size: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Card(
                    elevation: 3,
                    color: Colors.white,
                    child: Container(
                      height: 50,
                      width: 361,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: commonText("USA",
                              size: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF1A1A1A))),
                      // child: DropdownButtonHideUnderline(
                      //   child: DropdownButton<String>(
                      //     value: _selectedCountry,
                      //     icon: const Icon(Icons.arrow_drop_down),
                      //     iconSize: 24,
                      //     isExpanded: true,
                      //     onChanged: (String? newValue) {
                      //       setState(() {
                      //         _selectedCountry = newValue!;
                      //       });
                      //     },
                      //     items: <String>[
                      //       'USA',
                      //       'Canada',
                      //       'Mexico',
                      //       'UK',
                      //       'Germany'
                      //     ].map<DropdownMenuItem<String>>((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(value),
                      //       );
                      //     }).toList(),
                      //   ),
                      // ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  commonTextfieldWithTitle(
                    "Address",
                    addressController,
                    hintText: "Enter your address",
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {},
                    child: commonButton("Submit"),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ));
  }
}
