import 'package:flutter/material.dart';
import 'package:ootms/presentation/screens/role/driver/driver_bottom_navigation.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(42, 64, 148, 1)),
          useMaterial3: true,
        ),
        home: DriverRootPage());
  }
}
