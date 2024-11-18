import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_text.dart';

class MyEquipmentPage extends StatelessWidget {
  final List<String> trucks = ["ABC 1234", "DEF 5678", "GHI 9101"];
  final List<String> trailers = ["Flatbed", "Box Trailer", "Tanker"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonText("My Trucks", size: 16, isBold: true),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap:
                    true, // Allows it to work inside a scrollable parent
                physics:
                    NeverScrollableScrollPhysics(), // Prevents nested scrolling
                itemCount: trucks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: commonText(
                      "${index + 1}. ${trucks[index]}",
                      size: 16,
                      isBold: true,
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              commonText("My Trailers", size: 16, isBold: true),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: trailers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: commonText(
                      "${index + 1}. ${trailers[index]}",
                      size: 16,
                      isBold: true,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
