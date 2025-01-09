import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/models/driver_model/equipment_model.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:provider/provider.dart';

class MyEquipmentPage extends StatelessWidget {
  final List<String> trucks = ["ABC 1234", "DEF 5678", "GHI 9101"];
  final List<String> trailers = ["Flatbed", "Box Trailer", "Tanker"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<ProfileController>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText("My Trucks", size: 16, isBold: true),
                    const SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: value.equipmentData.length,
                      itemBuilder: (context, index) {
                        EquipmentModel data = value.equipmentData[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: commonText(
                            "${index + 1}. ${data.truckNumber.toString().isNotEmpty ? data.truckNumber.toString() : "TRK554834"}",
                            size: 16,
                            isBold: true,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // commonText("My Trailers", size: 16, isBold: true),
                    // const SizedBox(height: 8),
                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   itemCount: trailers.length,
                    //   itemBuilder: (context, index) {
                    //     return Padding(
                    //       padding: const EdgeInsets.only(bottom: 4.0),
                    //       child: commonText(
                    //         "${index + 1}. ${trailers[index]}",
                    //         size: 16,
                    //         isBold: true,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
