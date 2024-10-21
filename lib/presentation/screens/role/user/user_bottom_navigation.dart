import 'package:flutter/material.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/screens/role/user/create_load/user_create_load.dart';
import 'package:ootms/presentation/screens/role/user/home/user_home_page.dart';
import 'package:ootms/presentation/screens/role/user/profile/user_profile.dart';

class UserRootPage extends StatefulWidget {
  const UserRootPage({super.key});

  @override
  State<UserRootPage> createState() => _UserRootPageState();
}

class _UserRootPageState extends State<UserRootPage> {
  int _currentIndex = 0;

  final iconList = [
    CircleAvatar(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AppIcons.home),
        )),
    CircleAvatar(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AppIcons.plus),
        )),
    CircleAvatar(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AppIcons.profile),
        )),
  ];

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      UserHomePage(),
      UserCreateLoadPage(),
      const UserProfile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_currentIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColor.primaryColor,
          currentIndex: _currentIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: iconList[0],
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: iconList[1],
              label: 'Create Load',
            ),
            BottomNavigationBarItem(
              icon: iconList[2],
              label: 'Profile',
            ),
          ],
          showSelectedLabels: true,
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
