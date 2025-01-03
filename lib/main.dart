import 'package:flutter/material.dart';
import 'package:ootms/app.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:provider/provider.dart';
// import 'package:ootms/presentation/screens/role/user/settings/user_settings.dart';
// import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileController()),
      ],
      child:const MyApp(),
    ),
  );
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (_) => UserDeleteAccountPageController(),
  //     child: const MyApp(),
  //   ),
  // );
}
