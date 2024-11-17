import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

class AddPreferredDriverPage2 extends StatefulWidget {
  @override
  _AddPreferredDriverPage2State createState() =>
      _AddPreferredDriverPage2State();
}

class _AddPreferredDriverPage2State extends State<AddPreferredDriverPage2> {
  final TextEditingController _phoneController = TextEditingController();
  bool _driverFound = false; // Toggle to simulate driver found or not
  String _driverName = "NR Shakib";
  String _driverRating = "4.65";
  String _driverId = "564653";

  void _searchDriver() {
    setState(() {
      if (_phoneController.text == "1234567890") {
        _driverFound = true; // Simulate a driver found
      } else {
        _driverFound = false; // Simulate no driver found
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText("Add Preferred Driver", size: 21, isBold: true),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 50,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/driverIcon.png",
                    color: AppColor.black,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        hintText: "Enter your driver’s phone",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _searchDriver,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor),
                    child: commonText("Search", color: AppColor.white),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            if (_driverFound)
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(
                      "assets/driver_image.png"), // Replace with actual image
                ),
                title: commonText(_driverName, size: 14, isBold: true),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 16),
                        SizedBox(width: 4),
                        commonText(_driverRating, size: 14),
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Driver ID:', // Normal text before the number
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '$_driverId',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            if (!_driverFound && _phoneController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    commonText("There is not any driver in this number.",
                        size: 18, fontWeight: FontWeight.w500),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text:
                                'Send app link to “', // Normal text before the number
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.black, // Ensure proper color
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${_phoneController.text}', // Bold the phone number
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '”.', // Normal text after the number
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Logic to send app link
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor),
                          child: commonText("Send", color: AppColor.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
