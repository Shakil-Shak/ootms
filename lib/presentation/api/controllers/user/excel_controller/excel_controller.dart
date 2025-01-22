import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel/excel.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

class CreateLoadTemplateController extends GetxController {
  // Function to generate and save the Excel file
  Future<void> createAndDownloadExcel() async {
    var excel = Excel.createExcel(); // Create a new Excel file
    var sheet = excel['Create Load Template']; // Create a new sheet

    // Keys
    List<String> keys = [
      "shipperName",
      "shipperPhoneNumber",
      "shipperEmail",
      "shippingAddress",
      "shippingCity",
      "shippingState",
      "shippingZip",
      "palletSpace",
      "weight",
      "loadType",
      "trailerType",
      "trailerSize",
      "productType",
      "Hazmat",
      "description",
      "shipmentPayment",
      "receiverName",
      "receiverPhoneNumber",
      "receiverEmail",
      "receivingAddress",
      "receiverCity",
      "receiverState",
      "receiverZip",
      "receiverpostalCode",
      "pickupDate",
      "deliveryDate",
      "billOfLading",
      "deliveryInstruction",
      "receiverLocation",
      "shipperLocation",
    ];

    // Add keys to the first column
    for (int i = 0; i < keys.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i))
          .value = TextCellValue(keys[i]);
    }

    // Dropdown data
    Map<String, List<String>> dropdownData = {
      "Product Type": [
        "Pine Pulpwood",
        "Pine Mulch",
        "Pine Super Pulpwood",
        "Pine Chip-N-Saw",
        "Pine Sawtimber",
        "Pine Poles",
        "Hardwood Pulpwood",
        "Hardwood Mulch",
        "Hardwood Palletwood",
        "Hardwood Crossties",
        "Hardwood Sawtimber",
        "Hardwood Plylogs",
        "Hardwood Poles",
        "Cypress Mulch"
      ],
      "Trailer Type": [
        "48 ft Dry Van",
        "53 ft Dry Van",
        "Refrigerated (Reefer)",
        "Curtain-side",
        "Open Trailers",
        "Flatbed",
        "Step Deck",
        "Lowboy",
        "RGN (Removable Gooseneck)",
        "Specialized",
        "Tanker",
        "Hopper",
        "Livestock",
        "Roll-Off",
        "Logging - Tree Length",
        "Logging - Double-bunk"
      ],
      "HazMat": [
        "Hazmat",
        "Dangerous",
        "Flammable Gas 2",
        "Poson 6",
        "Corrosive",
        "Oxygen2",
        "Flamable 3",
        "Radioactive",
        "Non-Flammable"
      ]
    };

    // Add dropdown options next to their keys
    dropdownData.forEach((key, values) {
      int rowIndex = keys.indexOf(key);
      if (rowIndex != -1) {
        for (int i = 0; i < values.length; i++) {
          sheet.cell(CellIndex.indexByColumnRow(columnIndex: i + 1, rowIndex: rowIndex))
              .value = TextCellValue(values[i]);
        }
      }
    });

    // Save Excel file
    final dir = await getApplicationDocumentsDirectory();
    String filePath = '${dir.path}/createLoadTemplate.xlsx';

    if (await Permission.storage.request().isGranted) {
      File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);

      Get.snackbar("Success", "Excel file saved at $filePath",
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar("Error", "Storage permission denied",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> requestStoragePermission() async {
    if (await Permission.manageExternalStorage.isDenied) {
      await Permission.manageExternalStorage.request();
    }
  }

}


