// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';

import 'package:ootms/presentation/components/common_textfield.dart';
import 'package:provider/provider.dart';

class UserSupportPage extends StatelessWidget {
  UserSupportPage({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: commonText("Support", isBold: true, size: 21),
          centerTitle: true,
        ),
        body: Consumer<ProfileController>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          commonTextfieldWithTitle(
                            "Title",
                            titleController,
                            hintText: "Enter title of your problem",
                            onValidate: (value) => OtherHelper.validator(value),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          commonTextfieldWithTitle(
                            "Description",
                            descriptionController,
                            maxLine: 5,
                            hintText:
                                "Enter a brief description of your problem",
                            onValidate: (value) => OtherHelper.validator(value),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  commonButton(
                    isLoading: value.isSupportLoad,
                    "Submit",
                    onTap: () async {
                      if (formkey.currentState!.validate()) {
                        await value.postSupport(
                          title: titleController.text,
                          content: descriptionController.text,
                          context: context,
                        );
                        if (value.isSupportFieldClear) {
                          titleController.clear();
                          descriptionController.clear();
                          value.isSupportFieldClear = false;
                          value.notifyListeners();
                        }
                      }
                    },
                  )
                ],
              ),
            );
          },
        ));
  }
}
