import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_profile_controller/driver_profile_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';

class DriverMap2Page extends StatefulWidget {
  final String shiperId;
  const DriverMap2Page({super.key, required this.shiperId});

  @override
  State<DriverMap2Page> createState() => _DriverMap2PageState();
}

class _DriverMap2PageState extends State<DriverMap2Page> {
  final String apiKey = 'AIzaSyAJrp3VvbO4E4jo7HRgqsk7EP8mPIZStxQ';
  MapController mapController = MapController();
  final LatLng _markerPosition = const LatLng(23.627556, 90.5212385);

  int rating = 4;
  double ratingValue = 0.0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  DriverProfileController feedbackController =
      Get.find<DriverProfileController>();
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
          builder: (context, scrollController) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    commonText(
                      'Your Shipment Has Been\nDelivered To The Receiver.',
                      size: 18,
                      isBold: true,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //===============================================ratting
                    RatingBar.builder(
                      initialRating: ratingValue,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          ratingValue = rating;
                        });
                        print("rattaing $ratingValue");
                      },
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(5, (index) {
                    //     return IconButton(
                    //       icon: Icon(
                    //         index < rating ? Icons.star : Icons.star_border,
                    //         color:
                    //             index < rating ? Colors.yellow : AppColor.black,
                    //         size: 30,
                    //       ),
                    //       onPressed: () {},
                    //     );
                    //   }),
                    // ),
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
                        child: Form(
                            key: formKey,
                            child: commonTextfieldWithTitle(
                                "", commentController,
                                hintText: "Enter your valuable comment",
                                onValidate: (value) =>
                                    OtherHelper.validator(value))

                            //  commonTextfield(
                            //   commentController,
                            //   borderColor: Colors.transparent,

                            //   hintText: "Enter your valuable comment",
                            // ),
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                      return commonButton(
                        isLoading: feedbackController.isDriverFeedback.value,
                        "Submit",
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await feedbackController.userFeedbackFromDriver(
                                ratting: ratingValue,
                                messege: commentController.text,
                                userId: widget.shiperId,
                                context: context);
                            Get.back();
                            Get.back();
                          }
                        },
                      );
                    }),
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
