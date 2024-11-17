// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';

class AssignPreferredDriver extends StatelessWidget {
  AssignPreferredDriver({super.key});
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText("Assign Preferred Driver", size: 21, isBold: true),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonText("Search Preferred Driver", size: 18),
            SizedBox(height: 16),
            commonTextfield(controller,
                hintText: "Search by Name/Phone Number/Driver ID"),
            SizedBox(height: 16),
            commonButton("Continue")
          ],
        ),
      ),
    );
  }
}
