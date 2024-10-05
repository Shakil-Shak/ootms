import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: commonText("OOTMS", size: 20, isBold: true)),
    );
  }
}
