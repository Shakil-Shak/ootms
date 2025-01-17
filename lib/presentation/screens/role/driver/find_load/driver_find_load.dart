import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/driver/find_load_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/find_load/driver_map3.dart';

class DriverFindLoadPage extends StatefulWidget {
  const DriverFindLoadPage({super.key});

  @override
  State<DriverFindLoadPage> createState() => _DriverFindLoadPageState();
}

class _DriverFindLoadPageState extends State<DriverFindLoadPage>
    with SingleTickerProviderStateMixin {

  FindLoadController findLoadController = Get.put(FindLoadController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _trailercontroller = TextEditingController();
  final TextEditingController _palletSpacesController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: commonText("Find Load", size: 21, isBold: true),
          centerTitle: true,
        ),
        body: informationTab());
  }

  Widget informationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            commonTextfieldWithTitle(
              "Driver Name",
              _nameController,
              hintText: "Enter full name",
            ),
            const SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Truck Number",
              _numberController,
              hintText: "Enter truck number",
            ),
            const SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Trailer Size",
              _trailercontroller,
              hintText: "Trailer Size",
            ),
            const SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Pallet Spaces",
              _palletSpacesController,
              hintText: "00",
            ),
            const SizedBox(height: 16),

            commonTextfieldWithTitle(
              "Current Location",
              _locationController,
              hintText: "Enter your location",
            ),
            const SizedBox(height: 16),
            commonTextfieldWithTitle(
              "Availability",
              _availabilityController,
              hintText: "Availability",
            ),
            const SizedBox(height: 16),
            // Next Button

            Obx(() =>
                commonButton(
                  isLoading: findLoadController.isLoading.value,
                  "Find Shipment",
                  onTap: () async {
                    await findLoadController.findNearestLoad();
                    animetedNavigationPush(const DriverMap3Page(), context);
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}
