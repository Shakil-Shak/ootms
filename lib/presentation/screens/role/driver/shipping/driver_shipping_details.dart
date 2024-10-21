import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

class DriverShippingDetailsPage extends StatelessWidget {
  final String shippingId;
  final String date;
  final String from;
  final String to;
  final String shipperAddress;

  final String shipperEmail;
  final String shipperPhone;
  final String reciverAddress;
  final String reciverEmail;
  final String reciverPhone;
  final String reciverName;
  final String shipperName;

  const DriverShippingDetailsPage({
    super.key,
    required this.shippingId,
    required this.date,
    required this.from,
    required this.to,
    required this.shipperAddress,
    required this.shipperEmail,
    required this.shipperPhone,
    required this.reciverAddress,
    required this.reciverEmail,
    required this.reciverPhone,
    required this.reciverName,
    required this.shipperName,
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
                      children: [const Icon(Icons.copy), commonText("Copy")],
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
                  const SizedBox(
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
                  const SizedBox(
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Receiver Info", isBold: true, size: 18),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Receiver Name", isBold: true),
                            commonText(reciverName),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Receiver Phone", isBold: true),
                            commonText(reciverPhone),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Receiver Email", isBold: true),
                            commonText(reciverEmail),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Receiver Address", isBold: true),
                            commonText(reciverAddress),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const Divider(thickness: 6),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Shipper’s Info", isBold: true, size: 18),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Shipper Name", isBold: true),
                            commonText(shipperName),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Shipper Phone", isBold: true),
                            commonText(shipperPhone),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Shipper Email", isBold: true),
                            commonText(shipperEmail),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText("Shipper Address", isBold: true),
                            commonText(shipperAddress),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const Divider(thickness: 6),
            // Load Information
            loadInfo(),
            const SizedBox(height: 16),
            const Divider(thickness: 6, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget loadInfo() {
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
              Expanded(
                child: Column(
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
              ),
              Expanded(
                child: Column(
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
