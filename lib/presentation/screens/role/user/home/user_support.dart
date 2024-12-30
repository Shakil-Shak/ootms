// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_snackbar.dart';
import 'package:ootms/presentation/components/common_text.dart';

import 'package:ootms/presentation/components/common_textfield.dart';

class UserSupportPage extends StatelessWidget {
  UserSupportPage({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: commonText("Support", isBold: true, size: 21),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              commonTextfieldWithTitle("Title", titleController,
                  hintText: "Enter title of your problem"),
              SizedBox(
                height: 20,
              ),
              commonTextfieldWithTitle("Description", descriptionController,
                  maxLine: 5,
                  hintText: "Enter a brief description of your problem"),
              SizedBox(
                height: 20,
              ),
              commonButton(
                "Submit",
                onTap: () {
                  showCommonSnackbar(context, "Submited successful!");
                },
              )
            ],
          ),
        ));
  }
}
