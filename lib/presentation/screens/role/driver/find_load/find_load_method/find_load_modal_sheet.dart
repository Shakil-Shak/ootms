
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/models/driver_model/nearest_load_model.dart';
import 'package:ootms/presentation/api/url_paths.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';

void showLocationDetails({required NearestLoadModel loadItems}) {
  showModalBottomSheet(
    context: Get.context!,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: commonText("Here is a load for you.",
                            size: 16, isBold: true),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        thickness: 6,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: commonText(
                          "${loadItems.loadType} Load",
                          size: 16,
                          isBold: true,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: commonText("${loadItems.trailerSize}-foot trailer—${loadItems.palletSpace} pallets"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 6,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonText("Pickup", size: 14, isBold: true),
                              const SizedBox(height: 8),
                              commonText("Date: ${OtherHelper.getDate(serverDate: loadItems.pickupDate.toString())}"),
                              commonText("Address: ${loadItems.shippingAddress}",
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                        FittedBox(
                          child: Container(
                            width: 2,
                            height: 60,
                            color: Colors.black54,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonText("Delivery", size: 14, isBold: true),
                              const SizedBox(height: 8),
                              commonText("Date: ${OtherHelper.getDate(serverDate: loadItems.deliveryDate.toString())}"),
                              commonText("Address: ${loadItems.receivingAddress}",
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    thickness: 6,
                  ),
                  const SizedBox(height: 8),

                  // Receiver Information
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        commonText(
                          "Receiver Information",
                          size: 14,
                          isBold: true,
                        ),
                        Row(
                          children: [
                            commonText(loadItems.receiverPhoneNumber),
                            commonText(" | "),
                            commonText(loadItems.receiverEmail,
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 6,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                    child: commonText("Shipper Information", size: 14, isBold: true),
                  ),

                  // Shipper Information
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            '${ApiPaths.baseUrl}${loadItems.user.userImage}',
                          ),
                          radius: 24,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText(
                              loadItems.shipperName,
                              isBold: true,
                            ),
                            commonText("${loadItems.shipperPhoneNumber} | ${loadItems.shipperEmail}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(
                    thickness: 6,
                  ),
                  const SizedBox(height: 8),

                  // Message Input and Call Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                children: [
                                  Icon(Icons.message),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Send a message",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          icon: const Icon(Icons.phone),
                          onPressed: () {
                            // Handle phone action
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Buttons for Accept/Cancel
                  Row(
                    children: [
                      Expanded(
                        child: commonButton(
                          "Cancel",
                          borderRadious: 10,
                          color: const Color(0xFFDDDDDD),
                          textColor: Colors.black,
                          onTap: () {
                            Navigator.pop(context); // Handle cancel
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: commonButton(
                          "Accept Load",
                          borderRadious: 10,
                          textColor: Colors.white,
                          onTap: () {
                            // Handle accept
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}