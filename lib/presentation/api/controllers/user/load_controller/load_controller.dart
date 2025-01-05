import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/url_paths.dart';

import '../../../api_services.dart';

class LoadController extends ChangeNotifier {
  final ApiService apiService = ApiService();
  bool isLoading = false;
  Future<void> createLoad() async {
    isLoading = true;
    notifyListeners();

    // Data fields
    Map<String, dynamic> data = {
      "data": [
        {
          "shipperName": "Alice Brown",
          "shipperPhoneNumber": "1122334455",
          "shipperEmail": "alice.brown@example.com",
          "shippingAddress": "789 Pine St, Metropolis",
          "trailerType": "Refrigerated",
          "productType": "Perishable Food Items",
          "isHazmat": false,
          "Hazmat": "",
          "description": "Frozen vegetables requiring temperature control",
          "shipmentPayment": 2000,
          "receiverName": "Bob Green",
          "receiverPhoneNumber": "5566778899",
          "receiverEmail": "bob.green@example.com",
          "receivingAddress": "321 Oak St, Springfield",
          "palletSpace": 8,
          "billOfLading": "BOL67890",
          "deliveryInstruction": "Keep refrigerated; deliver before 12 PM"
        },
        {
          "shipperName": "Charlie Davis",
          "shipperPhoneNumber": "6677889900",
          "shipperEmail": "charlie.davis@example.com",
          "shippingAddress": "123 Maple Ave, Rivertown",
          "trailerType": "Dry Van",
          "productType": "Electronics",
          "isHazmat": false,
          "Hazmat": "",
          "description": "Laptops and accessories",
          "shipmentPayment": 2500,
          "receiverName": "Diana Evans",
          "receiverPhoneNumber": "3344556677",
          "receiverEmail": "diana.evans@example.com",
          "receivingAddress": "987 Birch Blvd, Lakeview",
          "palletSpace": 12,
          "billOfLading": "BOL54321",
          "deliveryInstruction": "Fragile items; deliver between 1 PM and 4 PM"
        }
      ]
    };

    try {
      final response = await apiService.otherPostRequest(
          ApiPaths.createLoad, jsonEncode(data));

      log("status code before =-==================${response["statusCode"]}");
      if (response["statusCode"] == "200") {
        log("success");
      }
    } catch (e) {
      log("failed =-==================$e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
