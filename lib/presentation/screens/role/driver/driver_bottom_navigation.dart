import 'package:flutter/material.dart';
import 'package:ootms/core/constants/assets/icons_string.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/screens/role/driver/find_load/driver_find_load.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_home_page.dart';
import 'package:ootms/presentation/screens/role/driver/profile/driver_profile.dart';

class DriverRootPage extends StatefulWidget {
  const DriverRootPage({super.key});

  @override
  State<DriverRootPage> createState() => _DriverRootPageState();
}

class _DriverRootPageState extends State<DriverRootPage> {
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
    _widgetOptions = [DriverHomePage(), DriverFindLoadPage(), DriverProfile()];
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
              label: 'Accept Load',
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
