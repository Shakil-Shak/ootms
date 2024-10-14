import 'package:flutter/material.dart';

Widget buildOTPTextField(
    TextEditingController controller, int index, BuildContext context) {
  return Card(
    elevation: 3,
    child: SizedBox(
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
          fillColor: Colors.white,
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
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
    ),
  );
}
