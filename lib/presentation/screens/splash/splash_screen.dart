import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ootms/core/constants/assets/images_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/screens/select_role.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SelectRole()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset(AppImages.logo),
          ),
          const SizedBox(
            height: 40,
          ),
          const SpinKitRing(
            color: AppColor.primaryColor,
            size: 70.0,
            lineWidth: 8.0,
          ),
        ],
      )),
    );
  }
}
