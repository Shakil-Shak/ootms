import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/user_bottom_navigation.dart';

import '../../role/user/country_model.dart';

class CompleateProfilePage extends StatefulWidget {
  final bool user;
  const CompleateProfilePage({super.key, required this.user});

  @override
  State<CompleateProfilePage> createState() => _CompleateProfilePageState();
}

class _CompleateProfilePageState extends State<CompleateProfilePage> {
  final TextEditingController addressController = TextEditingController();

  final TextEditingController texIdController = TextEditingController();

  final List<Country> countries = [
    Country('United States', '+1', 'assets/images/usaflag.png'),
    Country('Canada', '+1', 'assets/images/usaflag.png'),
    Country('United Kingdom', '+44', 'assets/images/usaflag.png'),
    Country('Australia', '+61', 'assets/images/usaflag.png'),
    // Add more countries as needed
  ];
  Country? selectedCountry;
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
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
                    border: Border.all(width: 1, color: AppColor.primaryColor)),
                child: Stack(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(40),
                          image: const DecorationImage(
                              image:
                                  AssetImage("assets/icons/profile_icon_2.png"),
                              fit: BoxFit.cover)),
                    ),
                    const Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 12,
                        child: Icon(Icons.mode_edit_outline_outlined,
                            size: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              commonTextfieldWithTitle(
                "Phone",
                fontWeight: FontWeight.w500,
                phoneController,
                hintText: "Enter your phone number",
                prifixIconWidget: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: FittedBox(
                    child: DropdownButton<Country>(
                      value: selectedCountry ?? countries[0],
                      onChanged: (Country? newValue) {
                        setState(() {
                          selectedCountry = newValue;
                        });
                      },
                      items: countries
                          .map<DropdownMenuItem<Country>>((Country country) {
                        return DropdownMenuItem<Country>(
                          value: country,
                          child: Image.asset(country.flag),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: widget.user,
                child: commonTextfieldWithTitle(
                  "Tax ID",
                  fontWeight: FontWeight.w500,
                  texIdController,
                  hintText: "Enter your tax ID",
                ),
              ),
              Visibility(
                visible: !widget.user,
                child: commonTextfieldWithTitle(
                  "CDL Number",
                  fontWeight: FontWeight.w500,
                  texIdController,
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
                  texIdController,
                  hintText: "Enter your truck number",
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
                  texIdController,
                  hintText: "Trailer Size",
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
                      SizedBox(
                        height: 16,
                      ),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: const [7, 7],
                        radius: Radius.circular(10),
                        color: AppColor.black,
                        strokeWidth: 1,
                        child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cloud_upload_outlined,
                                color: Colors.grey,
                                size: 40,
                              ),
                              commonText("Choose image or capture image",
                                  size: 14, fontWeight: FontWeight.w500)
                            ],
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
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  if (widget.user) {
                    animetedNavigationPush(const UserRootPage(), context);
                  } else {
                    //driver
                  }
                },
                child: commonButton("Continue"),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
