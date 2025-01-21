import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/Driver/equipment_controller/equipment_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';

import '../../../../../helpers/other_helper.dart';
import '../../../../components/common_textfield.dart';

class EquipmentField extends StatelessWidget {
  EquipmentField({super.key});

  GlobalKey<FormState> truckKey = GlobalKey<FormState>();
  GlobalKey<FormState> trailerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EquipmentController>(
      builder: (controller) {
        return Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: controller.selectText == "Truck"
                  ? Form(
                      key: truckKey,
                      child: Column(
                        children: [
                          commonTextfieldWithTitle(
                            "Truck",
                            controller.truckNumController,
                            onValidate: (value) => OtherHelper.validator(value),
                            hintText: "Enter Truck Number",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          commonTextfieldWithTitle(
                            "CDL Number",
                            controller.cdlNumController,
                            onValidate: (value) => OtherHelper.validator(value),
                            hintText: "Enter CDL Number",
                          ),
                        ],
                      ),
                    )
                  : SizedBox
                      .shrink(), // Invisible widget when condition is false
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: controller.selectText != "Truck"
                  ? Form(
                      key: trailerKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          commonTextfieldWithTitle(
                            "Trailer Size",
                            controller.trailerSizeController,
                            onValidate: (value) => OtherHelper.validator(value),
                            hintText: "Enter Trailer Size",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          commonTextfieldWithTitle(
                            "Pallete Space",
                            controller.palletController,
                            onValidate: (value) => OtherHelper.validator(value),
                            hintText: "Enter Pallete Space",
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          commonTextfieldWithTitle(
                            "Weight",
                            controller.weightController,
                            onValidate: (value) => OtherHelper.validator(value),
                            hintText: "Enter Weight",
                          ),
                        ],
                      ),
                    )
                  : SizedBox
                      .shrink(), // Invisible widget when condition is false
            ),
            SizedBox(
              height: 100,
            ),
            commonButton(
              isLoading: controller.isAddLoading,
              "Add Equipment",
              onTap: () {
                if (controller.selectText == "Truck") {
                  if (truckKey.currentState!.validate()) {
                    controller.addTruckRepo(context: context);
                  }
                } else if (controller.selectText == "Trailer") {
                  if (trailerKey.currentState!.validate()) {
                    controller.addTrailerRepo(context: context);
                  }
                }
              },
            )
          ],
        );
      },
    );
  }
}
