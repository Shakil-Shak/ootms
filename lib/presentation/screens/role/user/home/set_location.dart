import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

class SetLocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: commonText(
          'Set Your Location',
          size: 18,
          isBold: true,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          // Search Bar Section
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            decoration: BoxDecoration(color: AppColor.white, boxShadow: const [
              BoxShadow(blurRadius: 3, color: Colors.black38),
            ]),
            child: const Row(
              children: [
                Icon(
                  Icons.bookmark_border,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search address',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                Icon(
                  Icons.search,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          // Location Options
          Expanded(
            child: ListView(
              children: [
                // Set on Map Option
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration:
                      BoxDecoration(color: AppColor.white, boxShadow: const [
                    BoxShadow(blurRadius: 3, color: Colors.black38),
                  ]),
                  child: ListTile(
                    leading: Image.asset("assets/icons/user home page/pin.png"),
                    title: commonText('Set On Map', size: 16, isBold: true),
                    onTap: () {
                      // Handle set on map action
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                // My Current Location Option
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration:
                      BoxDecoration(color: AppColor.white, boxShadow: const [
                    BoxShadow(blurRadius: 3, color: Colors.black38),
                  ]),
                  child: ListTile(
                    leading: Image.asset("assets/icons/user home page/pin.png"),
                    title: commonText('My Current Location',
                        size: 16, isBold: true),
                    onTap: () {
                      // Handle current location action
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
