import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/load_data.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class Create_load_XL extends StatefulWidget {
  const Create_load_XL({super.key});

  @override
  State<Create_load_XL> createState() => _Create_load_XLState();
}

class _Create_load_XLState extends State<Create_load_XL> {
  final List<LoadData> loadDataList = [];

  @override
  Widget build(BuildContext context) {
    Future<void> _importExcel(BuildContext context) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        final bytes = file.readAsBytesSync();
        final excel = Excel.decodeBytes(bytes);

        // List<LoadData> loadDataList = [];

        for (var table in excel.tables.keys) {
          final sheet = excel.tables[table];

          if (sheet != null) {
            for (var i = 1; i < sheet.rows.length; i++) {
              final row = sheet.rows[i];
              loadDataList.add(
                LoadData(
                  load: row[0]?.value.toString() ?? '',
                  receiver: row[1]?.value.toString() ?? '',
                  shipper: row[2]?.value.toString() ?? '',
                ),
              );
              animetedNavigationPush(
                  LoadDataScreen(
                    loadDataList: loadDataList,
                  ),
                  context);
            }
          }
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: commonText("Create Load", size: 21, isBold: true),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            commonIconButton(
              "Download the Excel Form",
              onTap: () async {
                // animetedNavigationPush(LoadDataScreen(), context);
                final byteData =
                    await rootBundle.load('assets/excel/createLoadTemplate.xlsx');
                final directory = await getApplicationDocumentsDirectory();
                final filePath = "${directory.path}/ootms.xlsx";
                final file = File(filePath);

                await file.writeAsBytes(byteData.buffer.asUint8List());

                log(filePath.toString());
                OpenFile.open(filePath);
              },
              color: AppColor.primaryColorLight,
              textColor: AppColor.black,
              const FaIcon(FontAwesomeIcons.fileExcel),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () {
                _importExcel(context);
              },
              child: DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: const [7, 7],
                radius: const Radius.circular(10),
                color: AppColor.black,
                strokeWidth: 1,
                child: SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload_outlined,
                        color: Colors.grey,
                        size: 80,
                      ),
                      commonText("Upload the Excel Sheet",
                          size: 14, fontWeight: FontWeight.w500)
                    ],
                  ),
                ),
              ),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: loadDataList.length,
            //     itemBuilder: (context, index) {
            //       final data = loadDataList[index];+
            //       return ListTile(
            //         title: Text(data.load),
            //         subtitle: Text(
            //             'Receiver: ${data.receiver}, Shipper: ${data.shipper}'),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class LoadData {
  final String load;
  final String receiver;
  final String shipper;

  LoadData({required this.load, required this.receiver, required this.shipper});
}



// class FileController extends GetxController {
//   Future<void> downloadExcelFromAssets(String fileName) async {
//     try {
//       // Request storage permissions
//       if (await _requestStoragePermission()) {
//         // Get a writable directory
//         final directory = await getExternalStorageDirectory();
//         if (directory == null) {
//           throw Exception("External storage directory not found");
//         }
//
//         final filePath = "${directory.path}/$fileName";
//         final file = File(filePath);
//
//         // Check if file already exists
//         if (await file.exists()) {
//           Get.snackbar("File Exists", "File already saved at $filePath");
//           return;
//         }
//
//         // Load the file from assets
//         ByteData data = await rootBundle.load('assets/excel/$fileName');
//
//         // Write the file to the writable directory
//         await file.writeAsBytes(data.buffer.asUint8List());
//
//         // Notify user of success
//         Get.snackbar("Success", "File downloaded to: $filePath");
//       } else {
//         Get.snackbar("Permission Required", "Storage permission is needed to save the file.");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Failed to download file: $e");
//     }
//   }
//
//   Future<bool> _requestStoragePermission() async {
//     // Request storage permissions based on Android version
//     if (Platform.isAndroid) {
//       final status = await Permission.manageExternalStorage.request();
//       return status.isGranted;
//     } else if (Platform.isIOS) {
//       // For iOS, permissions aren't needed for app-specific directories
//       return true;
//     }
//     return false;
//   }
// }
//
//
//
//
//
//
// class Create_load_XL extends StatelessWidget {
//
//   Create_load_XL({super.key});
//
//   final FileController fileController = Get.put(FileController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Download Excel from Assets"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             fileController.downloadExcelFromAssets('createLoadTemplate.xlsx');
//           },
//           child: Text("Download Excel"),
//         ),
//       ),
//     );
//   }
// }

