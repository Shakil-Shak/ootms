import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';

class TrackYourShipment extends StatefulWidget {
  const TrackYourShipment({super.key});

  @override
  State<TrackYourShipment> createState() => _TrackYourShipmentState();
}

class _TrackYourShipmentState extends State<TrackYourShipment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText('Track Your Shipment', size: 21, isBold: true),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            // Truck icon
            const Icon(Icons.local_shipping, color: Colors.blue),
            const SizedBox(width: 10),

            // Input field
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter bill of lading number',
                  border: InputBorder.none,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: FittedBox(
                child: commonButton(
                  "Track",
                  width: 120,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
