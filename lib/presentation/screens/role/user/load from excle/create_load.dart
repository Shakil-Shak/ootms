import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/load_data.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

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

        List<LoadData> loadDataList = [];

        for (var table in excel.tables.keys) {
          final sheet = excel.tables[table];

          if (sheet != null) {
            for (var i = 1; i < sheet.rows.length; i++) {
              final row = sheet.rows[i];
              loadDataList.add(
                LoadData(
                  receiverName: row[0]?.value?.toString() ?? '',
                  receiverPhoneNumber: row[1]?.value?.toString() ?? '',
                  receiverEmail: row[2]?.value?.toString() ?? '',
                  receivingAddress: row[3]?.value?.toString() ?? '',
                  receiverCity: row[4]?.value?.toString() ?? '',
                  receiverState: row[5]?.value?.toString() ?? '',
                  receiverZip:
                      int.tryParse(row[6]?.value?.toString() ?? '') ?? 0,
                  receiverPostalCode:
                      int.tryParse(row[7]?.value?.toString() ?? '') ?? 0,
                  shipperName: row[8]?.value?.toString() ?? '',
                  shipperPhoneNumber: row[9]?.value?.toString() ?? '',
                  shipperEmail: row[10]?.value?.toString() ?? '',
                  shippingAddress: row[11]?.value?.toString() ?? '',
                  shippingCity: row[12]?.value?.toString() ?? '',
                  shippingState: row[13]?.value?.toString() ?? '',
                  shippingZip:
                      int.tryParse(row[14]?.value?.toString() ?? '') ?? 0,
                  palletSpace:
                      int.tryParse(row[15]?.value?.toString() ?? '') ?? 0,
                  loadType: row[16]?.value?.toString() ?? '',
                  weight:
                      double.tryParse(row[17]?.value?.toString() ?? '') ?? 0.0,
                  loadDetails: row[18]?.value?.toString() ?? '',
                  productType: row[19]?.value?.toString() ?? '',
                  pickupDate: row[20]?.value?.toString() ?? '',
                  deliveryDate: row[21]?.value?.toString() ?? '',
                  billOfLading: row[22]?.value?.toString() ?? '',
                  trailerSize:
                      int.tryParse(row[23]?.value?.toString() ?? '') ?? 0,
                  hazmat: row[24]?.value?.toString() ?? '',
                  deliveryInstruction: row[25]?.value?.toString() ?? '',
                  description: row[26]?.value?.toString() ?? '',
                  latitude:
                      double.tryParse(row[27]?.value?.toString() ?? '') ?? 0.0,
                  longitude:
                      double.tryParse(row[28]?.value?.toString() ?? '') ?? 0.0,
                ),
              );
            }
            // Navigate to LoadDataScreen after loading all data.
            animetedNavigationPush(
                LoadDataScreen(
                  loadDataList: loadDataList,
                ),
                context);
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
                    await rootBundle.load('assets/excel/demo.xlsx');
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
  final String receiverName;
  final String receiverPhoneNumber;
  final String receiverEmail;
  final String receivingAddress;
  final String receiverCity;
  final String receiverState;
  final int receiverZip;
  final int receiverPostalCode;
  final String shipperName;
  final String shipperPhoneNumber;
  final String shipperEmail;
  final String shippingAddress;
  final String shippingCity;
  final String shippingState;
  final int shippingZip;
  final int palletSpace;
  final String loadType;
  final double weight;
  final String loadDetails;
  final String productType;
  final String pickupDate;
  final String deliveryDate;
  final String billOfLading;
  final int trailerSize;
  final String hazmat;
  final String deliveryInstruction;
  final String description;
  final double latitude;
  final double longitude;

  LoadData({
    required this.receiverName,
    required this.receiverPhoneNumber,
    required this.receiverEmail,
    required this.receivingAddress,
    required this.receiverCity,
    required this.receiverState,
    required this.receiverZip,
    required this.receiverPostalCode,
    required this.shipperName,
    required this.shipperPhoneNumber,
    required this.shipperEmail,
    required this.shippingAddress,
    required this.shippingCity,
    required this.shippingState,
    required this.shippingZip,
    required this.palletSpace,
    required this.loadType,
    required this.weight,
    required this.loadDetails,
    required this.productType,
    required this.pickupDate,
    required this.deliveryDate,
    required this.billOfLading,
    required this.trailerSize,
    required this.hazmat,
    required this.deliveryInstruction,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  factory LoadData.fromJson(Map<String, dynamic> json) {
    return LoadData(
      receiverName: json['receiverName'],
      receiverPhoneNumber: json['receiverPhoneNumber'],
      receiverEmail: json['receiverEmail'],
      receivingAddress: json['receivingAddress'],
      receiverCity: json['receiverCity'],
      receiverState: json['receiverState'],
      receiverZip: json['receiverZip'],
      receiverPostalCode: json['receiverPostalCode'],
      shipperName: json['shipperName'],
      shipperPhoneNumber: json['shipperPhoneNumber'],
      shipperEmail: json['shipperEmail'],
      shippingAddress: json['shippingAddress'],
      shippingCity: json['shippingCity'],
      shippingState: json['shippingState'],
      shippingZip: json['shippingZip'],
      palletSpace: json['palletSpace'],
      loadType: json['loadType'],
      weight: json['weight'],
      loadDetails: json['loadDetails'],
      productType: json['productType'],
      pickupDate: json['pickupDate'],
      deliveryDate: json['deliveryDate'],
      billOfLading: json['billOfLading'],
      trailerSize: json['trailerSize'],
      hazmat: json['hazmat'],
      deliveryInstruction: json['deliveryInstruction'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
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

