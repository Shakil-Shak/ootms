import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import '../../../../helpers/other_helper.dart';
import '../../../api/controllers/user/profile_controller/update_profile_controller.dart';
import '../../role/common/country_model.dart';

class CompleateProfilePage extends StatefulWidget {
  final bool user;
  const CompleateProfilePage({super.key, required this.user});

  @override
  State<CompleateProfilePage> createState() => _CompleateProfilePageState();
}

class _CompleateProfilePageState extends State<CompleateProfilePage> {
  final TextEditingController addressController = TextEditingController();

  final TextEditingController texIdController = TextEditingController();
  final TextEditingController cdlNumberController = TextEditingController();
  final TextEditingController truckNumberController = TextEditingController();
  final TextEditingController trailerSizeController = TextEditingController();
  final TextEditingController palletSpacesController = TextEditingController();

  final List<Country> countries = [
    Country('United States', '+1', 'assets/images/usaflag.png'),
    Country('Canada', '+1', 'assets/images/usaflag.png'),
    Country('United Kingdom', '+44', 'assets/images/usaflag.png'),
    Country('Australia', '+61', 'assets/images/usaflag.png'),
    // Add more countries as needed
  ];
  Country? selectedCountry;
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UpdateProfileController editController =
      Get.find<UpdateProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: GetBuilder(
          init: UpdateProfileController(),
          builder: (value) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    commonText("Now Complete Your \nProfile to Continue.",
                        textAlign: TextAlign.center,
                        size: 21,
                        color: AppColor.black,
                        isBold: true),
                    const SizedBox(
                      height: 8,
                    ),
                    commonText("Fill in your information.",
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 10),
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
                                : Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                            width: 1,
                                            color: AppColor.primaryColor)),
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: AppColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  "assets/icons/profile_icon_2.png"),
                                              fit: BoxFit.cover)),
                                    ),
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
                    Form(
                        child: Column(
                      children: [
                        commonTextfieldWithTitle("Phone", phoneController,
                            prifixIconWidget:
                                Image.asset("assets/images/usaflag.png"),
                            hintText: "Enter your phone",
                            onValidate: (value) => OtherHelper.validator(value),
                            keyboardType: TextInputType.number),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: widget.user,
                          child: commonTextfieldWithTitle(
                            "Tax ID",
                            fontWeight: FontWeight.w500,
                            texIdController,
                            hintText: "Enter your tax ID",
                            onValidate: (value) => OtherHelper.validator(value),
                          ),
                        ),
                        Visibility(
                          visible: !widget.user,
                          child: commonTextfieldWithTitle(
                            "CDL Number",
                            fontWeight: FontWeight.w500,
                            cdlNumberController,
                            hintText: "Enter your CDL number",
                          ),
                        ),
                        Visibility(
                          visible: !widget.user,
                          child: const SizedBox(height: 20),
                        ),
                        Visibility(
                          visible: !widget.user,
                          child: commonTextfieldWithTitle(
                            "Truck Number",
                            fontWeight: FontWeight.w500,
                            truckNumberController,
                            hintText: "Enter your truck number",
                            onValidate: (value) => OtherHelper.validator(value),
                          ),
                        ),
                        Visibility(
                          visible: !widget.user,
                          child: const SizedBox(height: 20),
                        ),
                        Visibility(
                          visible: !widget.user,
                          child: commonTextfieldWithTitle(
                            "Trailer Size",
                            fontWeight: FontWeight.w500,
                            trailerSizeController,
                            hintText: "Trailer Size",
                            onValidate: (value) => OtherHelper.validator(value),
                          ),
                        ),
                        Visibility(
                          visible: !widget.user,
                          child: const SizedBox(height: 20),
                        ),
                        Visibility(
                          visible: !widget.user,
                          child: commonTextfieldWithTitle(
                            "Pallet Spaces",
                            fontWeight: FontWeight.w500,
                            palletSpacesController,
                            hintText: "00",
                            onValidate: (value) => OtherHelper.validator(value),
                          ),
                        ),
                        Visibility(
                          visible: !widget.user,
                          child: const SizedBox(height: 20),
                        ),
                        Visibility(
                            visible: !widget.user,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                commonText(
                                  "Verify Your CDL",
                                  size: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                GestureDetector(
                                  onTap: (){
                                     editController.getCdlImage();
                                    setState(() {});
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    dashPattern: const [7, 7],
                                    radius: const Radius.circular(10),
                                    color: AppColor.black,
                                    strokeWidth: 1,
                                    child: editController.cdlImage != null?
                                     Image.file(
                                      File(editController.cdlImage!),
                                    width: double.infinity,
                                            height: 150,
                                      fit: BoxFit.fill,
                                    )
                                    
                                     : SizedBox(
                                      width: double.infinity,
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.cloud_upload_outlined,
                                            color: Colors.grey,
                                            size: 40,
                                          ),
                                          commonText(
                                              "Choose image or capture image",
                                              size: 14,
                                              fontWeight: FontWeight.w500)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        const SizedBox(height: 20),
                        commonTextfieldWithTitle(
                          "Address",
                          fontWeight: FontWeight.w500,
                          addressController,
                          hintText: "Enter your address",
                        ),
                      ],
                    )),
                    const SizedBox(height: 50),
                    //======================================================continue button
                    Obx(() => InkWell(
                      onTap: () {
                        editController.completeProfile(
                          
                            phone: phoneController.text,
                            taxId: texIdController.text,
                            address: addressController.text,
                            cdlNumber: cdlNumberController.text,
                            palletSpaces: palletSpacesController.text,
                            trailerSize: trailerSizeController.text,
                            truckNumber: truckNumberController.text,
                            user: widget.user,
                            context: context);
                      },
                      child: commonButton(editController.isLoading.value == true? "Loading..." :"Continue"),
                    ),),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
