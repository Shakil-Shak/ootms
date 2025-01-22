import 'package:flutter/material.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/create_load/user_create_load.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/create_load.dart';

class UserCreateLoadOption extends StatelessWidget {
  const UserCreateLoadOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  animetedNavigationPush(const UserCreateLoadPage(), context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: commonText("Create Load from Form",
                      isBold: true, size: 14),
                )),
            const Divider(),
            InkWell(
                onTap: () {
                  animetedNavigationPush(Create_load_XL(), context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: commonText("Create Load from Excel Sheet",
                      isBold: true, size: 14),
                )),
          ],
        ),
      ),
    );
  }
}
