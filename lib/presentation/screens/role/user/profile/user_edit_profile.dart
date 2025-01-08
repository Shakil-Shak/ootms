// ignore_for_file: must_be_immutable

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/update_profile_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/screens/role/common/country_model.dart';
import 'package:provider/provider.dart';

import '../../../../api/url_paths.dart';
import '../../../../components/common_image.dart';

class UserEditProfile extends StatefulWidget {
  String imagePath;
  String title;
  String email;
  String contact;
  String country;
  String address;
  UserEditProfile(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.email,
      required this.contact,
      required this.address,
      required this.country});

  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final UpdateProfileController editController =
      Get.find<UpdateProfileController>();
  // String _selectedCountry = 'USA';

  // final List<Country> countries = [
  //   Country('United States', '+1', 'assets/images/usaflag.png'),
  //   Country('Canada', '+1', 'assets/images/usaflag.png'),
  //   Country('United Kingdom', '+44', 'assets/images/usaflag.png'),
  //   Country('Australia', '+61', 'assets/images/usaflag.png'),
  //   // Add more countries as needed
  // ];

  Country? selectedCountry;

  @override
  void initState() {
    super.initState();
    fullNameController.text = widget.title;
    emailController.text = widget.email;
    addressController.text = widget.address;
    phoneController.text = widget.contact;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: commonText("Edit Profile", size: 21, isBold: true),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: GetBuilder<UpdateProfileController>(builder: (controller) {
          log(ApiPaths.baseUrl + widget.imagePath);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              width: 1, color: AppColor.primaryColor)),
                      child: Stack(
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
                              : CommonImage(
                            imageSrc: ApiPaths.baseUrl + widget.imagePath,
                            imageType: ImageType.network,
                            size: 90,
                            borderRadius: 100,
                          ),
                          Positioned(
                            bottom: 5,
                            right: 2,
                            child: InkWell(
                              onTap: () {
                                editController.getProfileImage();
                                setState(() {});
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
                      )),
                  commonTextfieldWithTitle("Full Name", fullNameController,
                      hintText: "Full Name", keyboardType: TextInputType.text),
                  const SizedBox(height: 20),
                  commonTextfieldWithTitle(
                    enable: false,
                      "Email", emailController,
                      assetIconPath: "assets/icons/emailicon.png",
                      hintText: "Email",
                      keyboardType: TextInputType.none),
                  const SizedBox(height: 20),
                  // ======================================phone picker

                  commonTextfieldWithTitle("Phone", phoneController,
                      prifixIconWidget:
                      Image.asset("assets/images/usaflag.png"),
                      hintText: "Enter your phone",
                      keyboardType: TextInputType.emailAddress),

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
                    onTap: () {
                      editController.updateProfile(
                          name: fullNameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          address: addressController.text);
                    },
                    child: Obx(() {
                      return commonButton("Submit",
                          isLoading: editController.isLoading.value);
                    }),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },),
        );
  }
}
