// ignore_for_file: must_be_immutable

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverMap3Page extends StatefulWidget {
  const DriverMap3Page({super.key});

  @override
  State<DriverMap3Page> createState() => _DriverMap3PageState();
}

class _DriverMap3PageState extends State<DriverMap3Page> {
  TextEditingController searchController = TextEditingController();
  final String apiKey =
      'AIzaSyAJrp3VvbO4E4jo7HRgqsk7EP8mPIZStxQ'; // Replace with your Geoapify API key
  MapController mapController = MapController();
  LatLng? _markerPosition = const LatLng(23.627556, 90.5212385);

  @override
  void initState() {
    super.initState();
  }

  // void _showLocationDetails() {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: Colors.white,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (context) {
  //       return DraggableScrollableSheet(
  //         expand: false,
  //         initialChildSize: 0.6,
  //         builder: (context, scrollController) {
  //           return Container(
  //             width: MediaQuery.of(context).size.width, // Full width
  //             height: MediaQuery.of(context).size.height *
  //                 0.9, // 70% of screen height
  //             padding: const EdgeInsets.all(16.0),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //             ),
  //             child: SingleChildScrollView(
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(25),
  //                       topRight: Radius.circular(25)),
  //                   color: AppColor.white,
  //                 ),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     // Status indicator
  //                     Padding(
  //                       padding: const EdgeInsets.all(16.0),
  //                       child: Row(
  //                         children: [
  //                           const CircleAvatar(
  //                             backgroundColor: Colors.lightGreen,
  //                             radius: 12,
  //                             child: CircleAvatar(
  //                               backgroundColor: Colors.green,
  //                               radius: 8,
  //                             ),
  //                           ),
  //                           const SizedBox(width: 8),
  //                           commonText(
  //                             "The truck is fully available.",
  //                             size: 14,
  //                             isBold: true,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     // Truck details
  //                     Container(
  //                       padding: const EdgeInsets.all(16),
  //                       color: AppColor.primaryColorLight.withOpacity(0.3),
  //                       width: MediaQuery.sizeOf(context).width,
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           commonText(
  //                             "DHK METRO HA 64-8549",
  //                             size: 14,
  //                             isBold: true,
  //                           ),
  //                           const SizedBox(height: 4),
  //                           commonText(
  //                             "48-foot trailer—24 pallets",
  //                           ),
  //                           // Driver details
  //                         ],
  //                       ),
  //                     ),
  //                     Container(
  //                       padding: const EdgeInsets.all(16),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Row(
  //                             children: [
  //                               const CircleAvatar(
  //                                 backgroundImage: NetworkImage(
  //                                   'https://i.pravatar.cc/100',
  //                                 ),
  //                                 radius: 24,
  //                               ),
  //                               const SizedBox(width: 12),
  //                               Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   commonText(
  //                                     "Sabbir Hossein",
  //                                     size: 14,
  //                                     isBold: true,
  //                                   ),
  //                                   const SizedBox(height: 4),
  //                                   commonText(
  //                                     "+995 654654 | example@gmail.com",
  //                                   ),
  //                                 ],
  //                               ),
  //                             ],
  //                           ),
  //                           const SizedBox(height: 16),
  //                           Row(
  //                             children: [
  //                               // Message input field
  //                               Expanded(
  //                                 child: Container(
  //                                   decoration: BoxDecoration(
  //                                     borderRadius: BorderRadius.circular(25),
  //                                     border: Border.all(
  //                                         color: Colors.grey, width: 1),
  //                                   ),
  //                                   child: const Row(
  //                                     children: [
  //                                       Padding(
  //                                         padding: EdgeInsets.symmetric(
  //                                             horizontal: 12.0),
  //                                         child: Icon(
  //                                           Icons.message,
  //                                           color: AppColor.black,
  //                                         ),
  //                                       ),
  //                                       Expanded(
  //                                         child: TextField(
  //                                           decoration: InputDecoration(
  //                                             hintText: "Send a message",
  //                                             border: InputBorder.none,
  //                                             hintStyle:
  //                                                 TextStyle(color: Colors.grey),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                               ),
  //                               const SizedBox(width: 10),
  //                               // Phone icon button
  //                               Container(
  //                                 padding: const EdgeInsets.all(8),
  //                                 decoration: BoxDecoration(
  //                                     color: AppColor.white,
  //                                     shape: BoxShape.circle,
  //                                     border: Border.all(width: 1)),
  //                                 child: const Icon(
  //                                   Icons.phone,
  //                                   color: Colors.black,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Container(
  //                       color: AppColor.primaryColorLight.withOpacity(0.3),
  //                       padding: EdgeInsets.all(16),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Expanded(
  //                             child: commonButton("Cancel",
  //                                 borderRadious: 10,
  //                                 color: Color(0xFFDDDDDD),
  //                                 textColor: AppColor.black),
  //                           ),
  //                           const SizedBox(width: 16),
  //                           Expanded(
  //                             child: commonButton(
  //                               "Accept Load",
  //                               onTap: () {
  //                                 animetedNavigationPush(
  //                                     DriverMap2Page(), context);
  //                               },
  //                               borderRadious: 10,
  //                               textColor: Colors.white,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  void _showLocationDetails() {
    showModalBottomSheet(
      context: context,
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
                            "Dry Load",
                            size: 16,
                            isBold: true,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: commonText("48-foot trailer—24 pallets"),
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
                                commonText("Date: 12-11-2024"),
                                commonText("Address: Rupatoli, Barishal",
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
                                commonText("Date: 15-11-2024"),
                                commonText("Address: Banasree, Dhaka",
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
                              commonText("+995 654654"),
                              commonText(" | "),
                              commonText("example@gmail.com",
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

                    // Shipper Information
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/100',
                            ),
                            radius: 24,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              commonText(
                                "Shohag Ahmed",
                                isBold: true,
                              ),
                              commonText("+995 654654 | example@gmail.com"),
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

  void _onMarkerTap(LatLng position) {
    setState(() {
      _markerPosition = position;
    });
    _showLocationDetails(); // Show bottom sheet on marker tap
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Map with marker
          ColorFiltered(
            colorFilter:
                const ColorFilter.mode(Colors.white, BlendMode.colorBurn),
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onTap: (tapPosition, point) {
                  _onMarkerTap(point); // Trigger bottom sheet on map tap
                },
                initialCenter: (_markerPosition != null)
                    ? _markerPosition!
                    : const LatLng(23.627556, 90.5212385),
                maxZoom: 21.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  additionalOptions: {
                    'apiKey': apiKey,
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 25.0,
                      height: 25.0,
                      point: (_markerPosition != null)
                          ? _markerPosition!
                          : const LatLng(23.627556, 90.5212385),
                      child: InkWell(
                        onTap: () {
                          _onMarkerTap(_markerPosition!);
                          mapController.move(_markerPosition!, 11);
                          setState(() {});
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(0, 0, 255, 1),
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 1,
                                    )
                                  ],
                                  border: Border.all(
                                      width: 5, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: 10,
            left: 16,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                maxRadius: 16,
                backgroundColor: AppColor.white,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchDialer(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch $phoneNumber';
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
