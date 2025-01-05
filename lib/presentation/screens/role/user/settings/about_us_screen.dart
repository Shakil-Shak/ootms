import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/color/app_color.dart';
import '../../../../api/controllers/user/static_controller/static_controller.dart';
import '../../../../components/common_text.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staticController =
        Provider.of<StaticController>(context, listen: false);
    staticController.getPrivacyPolicy(context);

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: commonText('About Us', size: 20, isBold: true),
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
            if (controller.aboutUs.isEmpty ||
                controller.aboutUs['attributes']?['content'] == null) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/1.5,
                  child: Center(
                    child: commonText(
                      'About Us is Empty',
                      size: 14,
                      isBold: false,
                    ),
                  ),
                ),
              );
            }
            final content = controller.aboutUs['attributes']?['content'];
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
