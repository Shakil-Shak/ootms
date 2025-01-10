import 'package:flutter/material.dart';
import 'package:ootms/app.dart';
import 'package:ootms/core/dependency.dart';
import 'package:ootms/presentation/api/controllers/user/load_controller/load_controller.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/api/controllers/user/static_controller/static_controller.dart';
import 'package:provider/provider.dart';

import 'presentation/api/controllers/user/shipping_controller/shipping_history_controller.dart';
// import 'package:ootms/presentation/screens/role/user/settings/user_settings.dart';
// import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection di = DependencyInjection();
  di.dependencies();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => LoadController()),
        ChangeNotifierProvider(create: (_) => StaticController()),
        ChangeNotifierProvider(create: (_) => ShippinfHistoryController()),
      ],
      child: const MyApp(),
    ),
  );
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (_) => UserDeleteAccountPageController(),
  //     child: const MyApp(),
  //   ),
  // );
}
