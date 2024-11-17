import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

class LoadDetailsScreen extends StatelessWidget {
  const LoadDetailsScreen({super.key});

  final String shipperPhone = "123-456-789",
      shipperName = "NR Shakib",
      shipperRating = "4.5",
      shipperEmail = "example@gmail.com",
      shipperAddress = "Rupatoli, Barishal",
      reciverName = "MD. Shihabul Islam",
      reciverPhone = "123-456-789",
      reciverEmail = "example@gmail.com",
      reciverAddress = "Banasree, Dhaka",
      deliveryInstructions =
          "Lorem ipsum dolor sit amet consectetur. Blandit auctor sit scelerisque ultricies.",
      description =
          "Lorem ipsum dolor sit amet consectetur. Blandit auctor sit scelerisque ultricies.";

  Widget editButton() {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(Icons.edit, size: 16, color: Colors.black),
      label: commonText(
        'Edit Details',
        size: 12,
      ),
      style: TextButton.styleFrom(
        backgroundColor: AppColor.primaryColorLight.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Go back
          },
        ),
        title: commonText(
          'Load Details',
          size: 21,
          isBold: true,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ExpansionTile(
                title: commonText(
                  "Shipper's Information",
                  size: 16,
                  isBold: true,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: shipperInfo(),
                  ),
                ],
              ),
              ExpansionTile(
                title: commonText(
                  "Load Information",
                  size: 16,
                  isBold: true,
                ),
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: loadInfo()),
                ],
              ),
              ExpansionTile(
                title: commonText(
                  "Receiver Information",
                  size: 16,
                  isBold: true,
                ),
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0), child: reciverInfo()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shipperInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [editButton()],
        ),
        const SizedBox(height: 10),
        _buildInfoRow("Shipper Name", " $shipperRating $shipperName",
            "Shipper Phone", shipperPhone),
        const SizedBox(height: 10),
        _buildInfoRow(
            "Shipper Email", shipperEmail, "Shipper Address", shipperAddress),
        SizedBox(
          height: 10,
        )
      ]),
    );
  }

  Widget loadInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [editButton()],
        ),
        const SizedBox(height: 10),
        _buildLoadInfoSection(),
      ],
    );
  }

  Widget reciverInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [editButton()],
          ),
          const SizedBox(height: 10),
          _buildInfoRow(
              "Receiver Name", reciverName, "Receiver Phone", reciverPhone),
          const SizedBox(height: 10),
          _buildInfoRow("Receiver Email", reciverEmail, "Receiver Address",
              reciverAddress),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
      String title1, String data1, String title2, String data2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText(title1, isBold: true),
              Row(
                children: [
                  Visibility(
                    visible: title1 == "Shipper Name",
                    child: const Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.yellow,
                    ),
                  ),
                  Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: commonText(data1))),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText(title2, isBold: true),
              commonText(data2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoadInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText("Load Type", size: 14, isBold: true),
                    commonText("Dry Load", size: 14),
                    const SizedBox(height: 10),
                    commonText("Pickup", size: 14, isBold: true),
                    commonText("12-12-2024", size: 14),
                    commonText("Address: Rupatoli, Barishal",
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("Weight", size: 14, isBold: true),
                    commonText("120 kg", size: 14),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText("Trailer size", size: 14, isBold: true),
                    commonText("48-foot trailer—24 pallets", size: 14),
                    const SizedBox(height: 10),
                    commonText("Delivery", size: 14, isBold: true),
                    commonText("13-12-2024", size: 14),
                    commonText("Address: Banasree, Dhaka",
                        size: 14, fontWeight: FontWeight.w500),
                    const SizedBox(height: 10),
                    commonText("HazMat", size: 14, isBold: true),
                    commonText("Flammable Gas 2, Corrosive, Danger.", size: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // Delivery Instructions
          commonText("Delivery Instructions", isBold: true, size: 16),
          const SizedBox(height: 5),
          commonText(description),
        ],
      ),
    );
  }
}
