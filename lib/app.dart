import 'package:flutter/material.dart';
import 'package:ootms/presentation/screens/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OOTMS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            actionsIconTheme: IconThemeData(color: Color.fromARGB(255, 45, 78, 104)),
          ),
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D4E68)),
          useMaterial3: true,
        ),
        home: const SplashScreen());
  }
}
