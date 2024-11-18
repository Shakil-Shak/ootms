// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/assign_loads.dart';

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
            commonText("Driver ID", size: 18),
            const SizedBox(height: 16),
            commonTextfield(controller, hintText: "Enter the driver ID here"),
            const SizedBox(height: 16),
            commonButton(
              "Continue",
              onTap: () {
                animetedNavigationPush(AssignLoadsScreen(), context);
              },
            )
          ],
        ),
      ),
    );
  }
}
