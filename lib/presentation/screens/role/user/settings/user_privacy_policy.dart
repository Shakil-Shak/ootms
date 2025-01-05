import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:provider/provider.dart';

import '../../../../api/controllers/user/static_controller/static_controller.dart';

class UserPrivacyPolicyPage extends StatelessWidget {
  const UserPrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final staticController =
        Provider.of<StaticController>(context, listen: false);
    staticController.getPrivacyPolicy(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: commonText('Privacy Policy', size: 20, isBold: true),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Consumer<StaticController>(
          builder: (context, controller, child) {
            if (controller.isLoading) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height/1.5,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: AppColor.primaryColor,
                )),
              );
            }
            if (controller.privacyPolicy.isEmpty ||
                controller.privacyPolicy['attributes']?['content'] == null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/1.5,
                  child: Center(
                    child: commonText(
                      'Privacy Policy is Empty',
                      size: 14,
                      isBold: false,
                    ),
                  ),
                ),
              );
            }
            final content = controller.privacyPolicy['attributes']?['content'];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: commonText(
                content,
                size: 18,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.justify
              ),
            );
          },
        ),
      ),
    );
  }
}
