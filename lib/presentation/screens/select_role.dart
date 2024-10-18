import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/screens/onboarding_page.dart';
import 'package:provider/provider.dart';

class SelectRole extends StatefulWidget {
  const SelectRole({super.key});

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        commonText("Select Your Role", size: 21, isBold: true),
        SizedBox(
          height: 50,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            commonIconButton(
                "User",
                color: AppColor.primaryColorLight,
                Icon(
                  Icons.person_2_outlined,
                ),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (_) => OnboardingProvider(),
                          child: OnboardingScreen(
                            user: true,
                          ),
                        ),
                      ),
                    ),
                textColor: AppColor.black),
            SizedBox(
              height: 20,
            ),
            commonIconButton(
              "Driver",
              Image.asset(
                "assets/icons/driverIcon.png",
                width: 30,
                height: 30,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => OnboardingProvider(),
                    child: OnboardingScreen(
                      user: false,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
