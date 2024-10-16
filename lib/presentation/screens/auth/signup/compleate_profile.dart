import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/user_bottom_navigation.dart';

class CompleateProfilePage extends StatefulWidget {
  final bool user;
  CompleateProfilePage({super.key, required this.user});

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
              SizedBox(
                height: 8,
              ),
              commonText(
                "Fill in your information.",
              ),
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
                      margin: EdgeInsets.all(2),
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
              commonTextfieldWithTitle(
                "Tax ID",
                texIdController,
                hintText: "Enter your tax ID",
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
                  if (widget.user) {
                    animetedNavigationPush(UserRootPage(), context);
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

// this is country model
class Country {
  final String name;
  final String code;
  final String flag;

  Country(this.name, this.code, this.flag);
}
