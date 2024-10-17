import 'package:flutter/material.dart';
import 'package:ootms/presentation/screens/role/notification/all_notifications.dart';
import 'package:ootms/presentation/screens/role/notification/notification.dart';
import 'package:ootms/presentation/screens/role/shipping/current%20_shipment_details.dart';
import 'package:ootms/presentation/screens/role/shipping/current_shipments.dart';
import 'package:ootms/presentation/screens/role/shipping/load_request.dart';
import 'package:ootms/presentation/screens/role/shipping/re_assign_shipment.dart';
import 'package:ootms/presentation/screens/role/shipping/shipping_history.dart';
import 'package:ootms/presentation/screens/role/user/chat/chat.dart';
import 'package:ootms/presentation/screens/role/user/chat/chat_list.dart';
import 'package:provider/provider.dart';

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
        home: AllNotificationsPage());
  }
}
