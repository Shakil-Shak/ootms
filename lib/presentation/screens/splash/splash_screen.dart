import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ootms/core/constants/color/app_color.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset("assets/images/logo.png"),
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
