// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/controllers/user/load_controller/load_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:provider/provider.dart';



class AssignPreferredDriver extends StatelessWidget {
  const AssignPreferredDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText("Assign Preferred Driver", size: 21, isBold: true),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LoadController>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Driver ID", size: 18),
                  const SizedBox(height: 16),
                  commonTextfield(value.driverIdcontroller,
                      hintText: "Enter the driver ID here"),
                  const SizedBox(height: 16),
                  commonButton(
                    isLoading: value.isLoading,
                    "Continue",
                    onTap: () {
                      value.assignPrefferedDriver(context: context);
                    },
                  )
                ],
              );
            },
          )),
    );
  }
}
