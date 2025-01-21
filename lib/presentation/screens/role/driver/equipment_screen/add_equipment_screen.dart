import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/Driver/equipment_controller/equipment_controller.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/screens/role/driver/equipment_screen/equipment_field.dart';

class AddEquipmentScreen extends StatefulWidget {
  const AddEquipmentScreen({super.key});

  @override
  State<AddEquipmentScreen> createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  bool isDropdown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: commonText("Add Equipment",
              size: 20, fontWeight: FontWeight.w600),
        ),
        body: GetBuilder<EquipmentController>(builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  commonText("Category", size: 14, fontWeight: FontWeight.w600),
                  const SizedBox(
                    height: 10,
                  ),
                  //======================================================dropdown button
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: 361,
                    height: isDropdown ? 150 : 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF9F9F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 8,
                          offset: Offset(0, 1),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            commonText(controller.selectText,
                                size: 15, color: AppColor.black),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isDropdown = !isDropdown;
                                    });
                                  },
                                  icon: isDropdown
                                      ? const Icon(Icons.keyboard_arrow_up)
                                      : const Icon(Icons.keyboard_arrow_down)),
                            )
                          ],
                        ),
                        if (isDropdown)
                          Expanded(
                            child: SingleChildScrollView(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Column(
                                      children: [
                                        Divider(
                                          color: AppColor.black,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      overlayColor:
                                          WidgetStatePropertyAll(Colors.blue),
                                      onTap: () {
                                        controller.updateText(text: "Truck");
            
                                        setState(() {
                                          isDropdown = false;
                                        });
                                      },
                                      child: commonText("Truck",
                                          size: 15, color: AppColor.black),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      overlayColor:
                                          WidgetStatePropertyAll(Colors.blue),
                                      onTap: () {
                                        controller.updateText(text: "Trailer");
                                        setState(() {
                                          isDropdown = false;
                                        });
                                      },
                                      child: commonText("Trailer",
                                          size: 15, color: AppColor.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  EquipmentField(),
                ],
              ),
            ),
          );
        }));
  }
}
