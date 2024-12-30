import 'package:flutter/material.dart';
import 'package:ootms/presentation/api/sharepreference_service.dart';
import 'package:ootms/presentation/screens/auth/sign_in_sign_up_chosser.dart';
import 'package:ootms/presentation/screens/auth/signin/signin_view.dart';
import 'package:ootms/presentation/screens/role/user/home/user_home_page.dart';
import 'package:ootms/presentation/api/login_tokan.dart';
import 'package:ootms/presentation/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ootms/presentation/screens/splash/onboarding_page.dart';
import 'package:ootms/presentation/screens/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String?> getLanguage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(ootmsAccessToken);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OOTMS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            actionsIconTheme: IconThemeData(color: Color(0xFF2D4E68)),
          ),
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D4E68)),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
