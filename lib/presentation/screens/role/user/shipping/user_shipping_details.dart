import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

class UserShippingDetailsPage extends StatelessWidget {
  final String shippingId;
  final String date;
  final String from;
  final String to;
  final String driver;
  final String driverImage;

  UserShippingDetailsPage({
    required this.shippingId,
    required this.date,
    required this.from,
    required this.to,
    required this.driver,
    required this.driverImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        centerTitle: true,
        title: commonText("Shipping Details", size: 21, isBold: true),
        backgroundColor: AppColor.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shipping ID with copy button
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText("Shipping ID\n$shippingId",
                      size: 16, isBold: true),
                  IconButton(
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.copy), commonText("Copy")],
                    ),
                    onPressed: () {
                      // Copy to clipboard
                    },
                  ),
                ],
              ),
            ),
            const Divider(thickness: 6),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Trip Info", size: 16, isBold: true),
                  const SizedBox(height: 16),
                  commonText(
                    date,
                    size: 14,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/arrow_up.png"),
                      const SizedBox(width: 4),
                      Expanded(child: commonText(from)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/arrow_up.png"),
                      const SizedBox(width: 4),
                      Expanded(child: commonText(to)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(thickness: 6),
            // Driver Info
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Driver Info", size: 16, isBold: true),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(driverImage),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText(driver, isBold: true),
                          commonText(
                            "+995 654654 | example@gmail.com",
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 6),
            // Truck Info
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Truck Info", size: 16, isBold: true),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("Truck Number: ", size: 14, isBold: true),
                      Expanded(
                          child: commonText("DHK METRO HA 64-8549", size: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      commonText("Trailer Size: ", isBold: true, size: 14),
                      Expanded(
                          child: commonText("48-foot trailer—24 pallets",
                              size: 14)),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(thickness: 6),
            // Load Information
            LoadInfo(),
            const SizedBox(height: 16),
            const Divider(thickness: 6, color: Colors.black26),
            const SizedBox(
              height: 8,
            ),

            // Request Again Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  commonText("REQUEST AGAIN", size: 14),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(
              thickness: 6,
              color: Colors.black26,
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }

  Widget LoadInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commonText(
            "Load Information",
            size: 18,
            isBold: true,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(
                    "Load Type",
                    size: 14,
                    isBold: true,
                  ),
                  commonText(
                    "Dry Load",
                    size: 14,
                  ),
                  const SizedBox(height: 10),
                  commonText(
                    "Pickup",
                    size: 14,
                    isBold: true,
                  ),
                  commonText(
                    "12-12-2024",
                    size: 14,
                  ),
                  commonText("Address: Rupatoli, Barishal",
                      size: 14, fontWeight: FontWeight.w500),
                  const SizedBox(height: 10),
                  commonText(
                    "Weight",
                    size: 14,
                    isBold: true,
                  ),
                  commonText(
                    "120 kg",
                    size: 14,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText(
                    "Trailer size",
                    size: 14,
                    isBold: true,
                  ),
                  commonText(
                    "48-foot trailer—24 pallets",
                    size: 14,
                  ),
                  const SizedBox(height: 10),
                  commonText(
                    "Delivery",
                    size: 14,
                    isBold: true,
                  ),
                  commonText(
                    "13-12-2024",
                    size: 14,
                  ),
                  commonText("Address: Banasree, Dhaka",
                      size: 14, fontWeight: FontWeight.w500),
                  const SizedBox(height: 10),
                  commonText(
                    "HazMat",
                    size: 14,
                    isBold: true,
                  ),
                  commonText(
                    "Flammable Gas 2,\nCorrosive, Danger.",
                    size: 14,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}