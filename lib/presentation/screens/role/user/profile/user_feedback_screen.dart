import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/other_helper.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_profile_controller/driver_profile_controller.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_textfield.dart';

import '../../../../api/controllers/user/profile_controller/user_getx_profile_controller.dart';
import '../../../../components/common_text.dart';

class UserFeedbackScreen extends StatefulWidget {
  UserFeedbackScreen({super.key});

  @override
  State<UserFeedbackScreen> createState() => _UserFeedbackScreenState();
}

class _UserFeedbackScreenState extends State<UserFeedbackScreen> {
  final TextEditingController msgController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double ratingValue = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: commonText('Feedback', size: 21, isBold: true),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GetBuilder<UserGetxProfileController>(builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: SizedBox(
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 325,
                      child: commonText(
                          "You have been running the app for a long time!",
                          size: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                          textAlign: TextAlign.center),
                    ),
                    SizedBox(
                      width: 325,
                      child: commonText("Give us ratings and reviews please.",
                          size: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 325,
                      child: commonText("Your Feedback",
                          size: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                          textAlign: TextAlign.center),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //===============================================ratting
                    RatingBar.builder(
                      initialRating: ratingValue,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          ratingValue = rating;
                        });
                        print("rattaing $ratingValue");
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      heightFactor: 0,
                      child: commonText("How are we doing?",
                          size: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColor.black,
                          textAlign: TextAlign.start),
                    ),
                    Form(
                        key: formKey,
                        child: commonTextfieldWithTitle(
                          "",
                          msgController,
                          hintText: "Write your answer",
                          maxLine: 3,
                          onValidate: (value) => OtherHelper.validator(value),
                        )),
                    const SizedBox(
                      height: 100,
                    ),
                    commonButton(
                      isLoading: controller.isLoading,
                      "Submit",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.userAppFeedback(
                              ratting: ratingValue,
                              messege: msgController.text,
                              context: context);
                          if (controller.isFeedbackComplete == true) {
                            msgController.clear();
                            controller.isFeedbackComplete = false;
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
