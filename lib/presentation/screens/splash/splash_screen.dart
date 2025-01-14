import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ootms/core/constants/assets/images_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/helpers/prefs_helper.dart';
import 'package:ootms/presentation/api/sharePrefarences/local_storage_save.dart';
import 'package:ootms/presentation/api/sharePrefarences/login_tokan.dart';
import 'package:ootms/presentation/screens/role/driver/driver_bottom_navigation.dart';
import 'package:ootms/presentation/screens/role/user/user_bottom_navigation.dart';
import 'package:ootms/presentation/screens/select_role.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<String>? userDetails;

  bool isRemember = false;

  @override
  void initState() {
    super.initState();
    userCredential();
    Future.delayed(const Duration(seconds: 3), () async {
      userDetails = await getUserAcessDetails();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        if (userDetails != null && userDetails!.length > 1) {
          String tempAcessToken = userDetails![0];
          String tempRole = userDetails![1];
          if (isRemember == true && tempRole == userString) {
            return const UserRootPage();
          }
          if (isRemember = true && tempRole == driverString) {
            return const DriverRootPage();
          }
        }
        return const SelectRole();
      }));
      // userDetails = await getUserAcessDetails();
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     if (userDetails != null && userDetails!.length > 1) {
      //       String tempAcessToken = userDetails![0];
      //       String tempRole = userDetails![1];
      //       if (tempAcessToken.isNotEmpty && tempRole == userString) {
      //         return const UserRootPage();
      //       }
      //       if (tempAcessToken.isNotEmpty && tempRole == driverString) {
      //         return const DriverRootPage();
      //       }
      //     }
      //     return const SelectRole();
      //   }),
      // );
    });
  }

  userCredential() async {
    var value = await PrefsHelper.getBool("isRemember");
    setState(() {
      isRemember = value;
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
