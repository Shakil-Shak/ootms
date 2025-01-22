
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/user/excel_controller/excel_controller.dart';



class ExcelTemplateScreen extends StatelessWidget {
  final CreateLoadTemplateController controller = Get.put(CreateLoadTemplateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Excel Template Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => controller.createAndDownloadExcel(),
          child: const Text("Download Excel Template"),
        ),
      ),
    );
  }
}
