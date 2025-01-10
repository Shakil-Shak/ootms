
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/service/api_services.dart';
import 'package:ootms/presentation/api/url_paths.dart';

class StaticController extends ChangeNotifier {
  ApiService apiService = ApiService();
  bool isLoading = false;
  Map<String, dynamic> privacyPolicy = {};
  Map<String, dynamic> termsConditions = {};
  Map<String, dynamic> aboutUs = {};

  //=============================================for account delete
    bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  void selectPasswordVisibility(bool visibility) {
    _isPasswordVisible = visibility;
    notifyListeners();
  }
  //==================================================================get privacy policy
  getPrivacyPolicy(BuildContext context) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      var response = await apiService
          .getRequest(ApiPaths.staticContent(contentType: "privacy-policy"));
      if (response["statusCode"] == "200") {
        privacyPolicy = response["data"];
      }
    } catch (e) {
      debugPrint("==========================================faild = $e");
    } finally {
      isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  //==================================================================terms and conditions
  getTermsConditions(BuildContext context) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      var response = await apiService.getRequest(
          ApiPaths.staticContent(contentType: "terms-and-conditions"));
      if (response["statusCode"] == "200") {
        termsConditions = response["data"];
      }
    } catch (e) {
      print("==========================================faild = $e");
    } finally {
      isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
  //==================================================================aboutUs
    getAboutUs(BuildContext context) async {
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    try {
      var response = await apiService.getRequest(
          ApiPaths.staticContent(contentType: "about-us"));
      log(response["data"]);
      if (response["statusCode"] == "200") {
        aboutUs = response["data"];
      }
    } catch (e) {
      debugPrint("==========================================faild = $e");
    } finally {
      isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
  //=============================================userSupport
  userSupport({required String title, required String desce})async{

    Map<String, dynamic> data = {
      "type":"support",
      "content":""
    };

    try {
      var response = await apiService.otherPostRequest(ApiPaths.userSupport, jsonEncode(data)); 
    } catch (e) {
      
    }
  }
}
