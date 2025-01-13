import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/chat/user_chat.dart';
import 'package:provider/provider.dart';

class UserChatDetailsScreen extends StatelessWidget {
  const UserChatDetailsScreen({super.key});

  final String driverPhone = "123-456-789",
      driverName = "NR Shakib",
      driverRating = "4.5",
      driverEmail = "example@gmail.com",
      driverAddress = "Rupatoli, Barishal",
      reciverName = "MD. Shihabul Islam",
      reciverPhone = "123-456-789",
      reciverEmail = "example@gmail.com",
      reciverAddress = "Banasree, Dhaka",
      deliveryInstructions =
          "Lorem ipsum dolor sit amet consectetur. Blandit auctor sit scelerisque ultricies.",
      description =
          "Lorem ipsum dolor sit amet consectetur. Blandit auctor sit scelerisque ultrices.Tortor sed donec facilisis odio auctor platea ultrices pharetra. Quis auctor iaculis fames faucibus quis enim odio et. Diam at risus augue nisl aliquet scelerisque lorem nunc velit.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              shipperInfo(),
              commonIconButton(onTap: () {
                animetedNavigationPush(
                    ChangeNotifierProvider(
                        create: (context) => UserChatProvider(),
                        child: const UserChatPage()),
                    context);
              },
                  "Chat with Shipper",
                  Image.asset(
                    "assets/icons/user home page/massage.png",
                    color: AppColor.white,
                  )),
              const SizedBox(
                height: 10,
              ),
              reciverInfo(),
              commonIconButton(onTap: () {
                animetedNavigationPush(
                    ChangeNotifierProvider(
                        create: (context) => UserChatProvider(),
                        child: const UserChatPage()),
                    context);
              },
                  "Chat with Receiver",
                  Image.asset(
                    "assets/icons/user home page/massage.png",
                    color: AppColor.white,
                  )),
              const SizedBox(
                height: 10,
              ),
              loadInfo()
            ],
          ),
        ),
      ),
    );
  }

  Widget shipperInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonText(
          "Shipper's Information",
          size: 16,
          isBold: true,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 10),
            _buildInfoRow("Shipper Name", " $driverRating $driverName",
                "Shipper Phone", driverPhone),
            const SizedBox(height: 10),
            _buildInfoRow(
                "Shipper Email", driverEmail, "Shipper Address", driverAddress),
            const SizedBox(
              height: 10,
            )
          ]),
        ),
      ],
    );
  }

  Widget loadInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonText(
          "Load Information",
          size: 16,
          isBold: true,
        ),
        const Divider(),
        _buildLoadInfoSection(),
      ],
    );
  }

  Widget reciverInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        commonText(
          "Receiver Information",
          size: 16,
          isBold: true,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(
                  "Receiver Name", reciverName, "Receiver Phone", reciverPhone),
              const SizedBox(height: 10),
              _buildInfoRow("Receiver Email", reciverEmail, "Receiver Address",
                  reciverAddress),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ],
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
                    visible: title1 == "driver Name",
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
          commonText("Description", isBold: true, size: 16),
          const SizedBox(height: 5),
          commonText(description, maxLines: 10),
          const SizedBox(
            height: 15,
          ),
          commonButton("Track on Map")
        ],
      ),
    );
  }
}
