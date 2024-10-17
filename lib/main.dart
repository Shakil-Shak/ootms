import 'package:flutter/material.dart';
import 'package:ootms/app.dart';
import 'package:ootms/presentation/screens/role/user/settings/settings.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp());
  runApp(
    ChangeNotifierProvider(
      create: (_) => DeleteAccountPageController(),
      child: MyApp(),
    ),
  );
}
