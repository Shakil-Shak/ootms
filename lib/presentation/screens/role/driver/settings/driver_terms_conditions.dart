import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:provider/provider.dart';

import '../../../../api/controllers/user/static_controller/static_controller.dart';

class DriverTermsconditionsPage extends StatelessWidget {
  const DriverTermsconditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final staticController =
        Provider.of<StaticController>(context, listen: false);
    staticController.getPrivacyPolicy(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: commonText('Terms & conditions', size: 20, isBold: true),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<StaticController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                )),
              );
            }
            if (controller.termsConditions.isEmpty ||
                controller.termsConditions['attributes']?['content'] == null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Center(
                    child: commonText(
                      'Terms and Conditions is Empty',
                      size: 14,
                      isBold: false,
                    ),
                  ),
                ),
              );
            }
            final content =
                controller.termsConditions['attributes']?['content'];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: commonText(content,
                  size: 18,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.justify),
            );
          },
        ),
      ),
    );
  }
}
