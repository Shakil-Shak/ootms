import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ootms/core/constants/color/app_color.dart';

class OtherHelper {
  static const String bearerToken = "BearerToken";
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');

  static String? validator(value) {
    if (value.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? emailValidator(
    value,
  ) {
    if (value!.isEmpty) {
      return "This field is required".tr;
    } else if (!emailRegexp.hasMatch(value)) {
      return "Enter valid email".tr;
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required".tr;
    }

    if (value.length < 8) {
      return "Password must be at least 8 characters long".tr;
    }

    final RegExp passRegExp = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

    if (!passRegExp.hasMatch(value)) {
      return "Password must contain at least:\n- 1 uppercase letter\n- 1 lowercase letter\n- 1 number\n- 1 special character (@\$!%*?&)"
          .tr;
    }

    return null;
  }

  static String? confirmPasswordValidator(value, passwordController) {
    if (value.isEmpty) {
      return "This field is required".tr;
    } else if (value != passwordController.text) {
      return "The password does not match".tr;
    } else {
      return null;
    }
  }

  //===================================pick image from gallery
  static Future<String?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages == null) return null;

    if (kDebugMode) {
      print(getImages.path);
    }

    return getImages.path;
  }

  //===================================pick image from camera

  static Future<String?> openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages == null) return null;

    if (kDebugMode) {
      print(getImages.path);
    }

    return getImages.path;
  }

  /// Get formatted time only (e.g., 01:05 PM)
  static String getTime({required String serverDate}) {
    try {
      DateTime parsedDate =
          DateTime.parse(serverDate).toLocal(); // Convert to local time
      return DateFormat('hh:mm a').format(parsedDate);
    } catch (e) {
      return 'Invalid date format';
    }
  }

  /// Get formatted day only (e.g., Wednesday)
  static String getDay({required String serverDate}) {
    try {
      DateTime parsedDate =
          DateTime.parse(serverDate).toLocal(); // Convert to local time
      return DateFormat('EEEE').format(parsedDate);
    } catch (e) {
      return 'Invalid date format';
    }
  }

  /// Get formatted date only (e.g., 2024-11-27)
  static String getDate({required String serverDate}) {
    try {
      DateTime parsedDate = DateTime.parse(serverDate).toLocal(); // Convert to local time
      return DateFormat('dd-MM-yyyy').format(parsedDate);

    } catch (e) {
      return 'Invalid date format';
    }
  }

  /// Get time and day together (e.g., 01:05 PM, Wednesday)
  static String getTimeAndDay({required String serverDate}) {
    try {
      DateTime parsedDate =
          DateTime.parse(serverDate).toLocal(); // Convert to local time
      String formattedTime = DateFormat('hh:mm a').format(parsedDate);
      String day = DateFormat('EEEE').format(parsedDate);
      return '$day $formattedTime';
    } catch (e) {
      return 'Invalid date format';
    }
  }

  /// Time difference code
  static String getTimeDifference(DateTime timestamp) {
    final DateTime givenTime = timestamp;
    final DateTime now = DateTime.now().toUtc();

    final Duration difference = now.difference(givenTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

//================================================================date picker
  static Future<String> datePicker(
    TextEditingController controller,
  ) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) => Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColor.primaryColor,
            ),
          ),
          child: child!),
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if(picked != null){
      String isoFormat = picked.toIso8601String();

      log("ISO Format: $isoFormat");
      return isoFormat;
    }

    return "";
  }

static Future<String> openTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
        context: Get.context!,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input);

    if (picked != null) {
      final period = picked.period == DayPeriod.am ? "am" : "pm";
      return "${picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod}:${picked.minute < 10 ? "0${picked.minute}" : picked.minute} $period";
    }
    return '';
  }
}
