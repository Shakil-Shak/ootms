import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';

class DriverMap2Page extends StatefulWidget {
  const DriverMap2Page({super.key});

  @override
  State<DriverMap2Page> createState() => _DriverMap2PageState();
}

class _DriverMap2PageState extends State<DriverMap2Page> {
  final String apiKey = 'AIzaSyAJrp3VvbO4E4jo7HRgqsk7EP8mPIZStxQ';
  MapController mapController = MapController();
  final LatLng _markerPosition = const LatLng(23.627556, 90.5212385);

  int rating = 4;
  final TextEditingController commentController = TextEditingController();
  void _showBottomSheetRatting(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (context, scrollController) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    commonText(
                      'Your Shipment Has Been\nDelivered To The Receiver.',
                      size: 18,
                      isBold: true,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          icon: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color:
                                index < rating ? Colors.yellow : AppColor.black,
                            size: 30,
                          ),
                          onPressed: () {},
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      thickness: 8,
                    ),
                    const SizedBox(height: 10),
                    commonText("Leave A Comment For User.",
                        size: 16, isBold: true),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        elevation: 3,
                        child: commonTextfield(
                          commentController,
                          borderColor: Colors.transparent,
                          hintText: "Enter your valuable comment",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    commonButton(
                      "Submit",
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                onTap: (tapPosition, point) {},
                initialCenter: _markerPosition,
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
                      point: _markerPosition,
                      child: InkWell(
                        onTap: () {
                          mapController.move(_markerPosition, 11);
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
            top: 30,
            right: 20,
            child: InkWell(
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 1)],
                    shape: BoxShape.circle,
                    color: AppColor.white),
                child: Image.asset("assets/icons/message.png"),
              ),
            ),
          ),
          Positioned(
            top: 90,
            right: 20,
            child: InkWell(
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 1)],
                    shape: BoxShape.circle,
                    color: AppColor.white),
                child: const Icon(Icons.call),
              ),
            ),
          ),
          // Back button
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

          Positioned(
              bottom: 50,
              child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 50,
                  child: commonButton("Delivered The Load", onTap: () {
                    _showBottomSheetRatting(context);
                  }, borderRadious: 10, isBold: false)))
        ],
      ),
    );
  }
}
