import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';

Widget buildOTPTextField(
    TextEditingController controller, int index, BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.13,
    height: 55,
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      cursorColor: Colors.black,
      style: const TextStyle(fontSize: 20),
      maxLength: 1,
      decoration: InputDecoration(
        counterText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: (value) {
        if (value.length == 1 && index < 5) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty && index > 0) {
          FocusScope.of(context).previousFocus();
        }
      },
    ),
  );
}
