import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map.dart';

class UserSetLocationPage extends StatelessWidget {
  const UserSetLocationPage({super.key});

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
          const SizedBox(
            height: 20,
          ),
          // Search Bar Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            decoration: const BoxDecoration(color: AppColor.white, boxShadow: [
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
          const SizedBox(
            height: 16,
          ),
          // Location Options
          Expanded(
            child: ListView(
              children: [
                // Set on Map Option
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration:
                      const BoxDecoration(color: AppColor.white, boxShadow: [
                    BoxShadow(blurRadius: 3, color: Colors.black38),
                  ]),
                  child: ListTile(
                    leading: Image.asset("assets/icons/user home page/pin.png"),
                    title: commonText('Set On Map', size: 16, isBold: true),
                    onTap: () {
                      animetedNavigationPush(const UserMapPage(), context);
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // My Current Location Option
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration:
                      const BoxDecoration(color: AppColor.white, boxShadow: [
                    BoxShadow(blurRadius: 3, color: Colors.black38),
                  ]),
                  child: ListTile(
                    leading: Image.asset("assets/icons/user home page/pin.png"),
                    title: commonText('My Current Location',
                        size: 16, isBold: true),
                    onTap: () {
                      animetedNavigationPush(const UserMapPage(), context);
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
