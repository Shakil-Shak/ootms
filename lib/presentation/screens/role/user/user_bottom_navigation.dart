import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/screens/role/user/home/user_home_page.dart';
import 'package:ootms/presentation/screens/role/user/profile/user_profile.dart';
import 'package:ootms/presentation/screens/role/user/user_create_load_option.dart';

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
          child: Image.asset(
            AppIcons.home,
            color: AppColor.primaryColor,
          ),
        )),
    const CircleAvatar(
        backgroundColor: Colors.white,
        child: Center(
          child: Center(
            child: Icon(
              Icons.add,
              color: AppColor.primaryColor,
              size: 30,
            ),
          ),
        )),
    const CircleAvatar(
        backgroundColor: Colors.white,
        child: Center(
          child: Center(
            child: Icon(
              FontAwesomeIcons.user,
              color: AppColor.primaryColor,
              size: 22,
            ),
          ),
        )),
  ];

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      const UserHomePage(),
      const UserCreateLoadOption(),
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
