import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
              child: Stack(
                children: [
                  // Background image
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/userHomePagebg.png'), // Replace with your image asset
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black38, BlendMode.multiply)),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Menu icon
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(8)),
                              child: IconButton(
                                icon: Icon(Icons.menu,
                                    size: 28, color: Colors.black),
                                onPressed: () {
                                  // Handle menu action
                                },
                              ),
                            ),
                            Spacer(),
                            // Notification bell
                            Image.asset(
                                "assets/icons/user home page/notify.png"),
                            SizedBox(width: 10),
                            // Profile avatar
                            CircleAvatar(
                              backgroundColor: AppColor.black,
                              backgroundImage: AssetImage(
                                  'assets/icons/profile_icon_2.png'), // Replace with your image asset
                              radius: 18,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColor.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            commonText(
                                "36 East 8th Street, New York,\nNY 10003, United States.",
                                size: 16,
                                color: AppColor.white)
                          ],
                        ),
                      ),
                      Center(
                        child: commonText("Track Your Shipment",
                            size: 22, isBold: true, color: AppColor.white),
                      ),
                      Container(
                        height: 50,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        padding: EdgeInsets.only(left: 8),
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
                            // Truck icon
                            Icon(Icons.local_shipping, color: Colors.blue),
                            SizedBox(width: 10),

                            // Input field
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Enter bill of lading number',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: FittedBox(
                                child: commonButton(
                                  "Track",
                                  width: 120,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(),
                    ],
                  )
                ],
              ),
            ),

            SizedBox(height: 40), // For spacing after the header

            // Action Cards Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  buildActionCard(
                    imagePath: "assets/icons/user home page/picup2.png",
                    label: 'Create Load',
                    description: 'Send your loads with us in just a few steps.',
                    onTap: () {},
                  ),
                  buildActionCard(
                    imagePath: "assets/icons/user home page/history.png",
                    label: 'Shipping History',
                    description: 'Check your previous shipping history.',
                    onTap: () {},
                  ),
                  buildActionCard(
                    imagePath: "assets/icons/user home page/massage.png",
                    label: 'Chat',
                    description: 'Easily chat with the driver.',
                    onTap: () {},
                  ),
                  buildActionCard(
                    imagePath: "assets/icons/user home page/support.png",
                    label: 'Support',
                    description: 'Take direct support from here.',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Recently Tracking Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recently Tracking',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(12),
                      leading: Icon(Icons.local_shipping,
                          color: Colors.blue, size: 30),
                      title: Text('Your load is being shipped'),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('BOL Number'),
                              Text('123-456-789',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Address'),
                              Text('Banasree, Dhaka',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildActionCard({
    required String imagePath,
    required String label,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        color: AppColor.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                          color: AppColor.primaryColorLight,
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.asset(
                        imagePath,
                      )),
                  SizedBox(width: 10),
                  Expanded(
                    child: commonText(
                      label,
                      isBold: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              commonText(
                description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
