import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_text.dart';

class DriverSupportPage extends StatelessWidget {
  const DriverSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: commonText("Support", size: 21, isBold: true),
      ),
    );
  }
}
