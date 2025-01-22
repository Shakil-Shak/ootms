// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:ootms/core/constants/assets/icons_string.dart';
// import 'package:ootms/core/constants/color/app_color.dart';
// import 'package:ootms/presentation/screens/role/driver/find_load/driver_find_load.dart';
// import 'package:ootms/presentation/screens/role/driver/home/driver_home_page.dart';
// import 'package:ootms/presentation/screens/role/driver/profile/driver_profile.dart';

// class DriverRootPage extends StatefulWidget {
//   const DriverRootPage({super.key});

//   @override
//   State<DriverRootPage> createState() => _DriverRootPageState();
// }

// class _DriverRootPageState extends State<DriverRootPage> {
//   int _currentIndex = 0;

//   final iconList = [
//     CircleAvatar(
//         backgroundColor: Colors.white,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(AppIcons.home, color: AppColor.primaryColor),
//         )),
//     const CircleAvatar(
//         backgroundColor: Colors.white,
//         child: Center(
//           child: Center(
//             child: Icon(
//               Icons.add,
//               color: AppColor.primaryColor,
//               size: 30,
//             ),
//           ),
//         )),
//     const CircleAvatar(
//         backgroundColor: Colors.white,
//         child: Center(
//           child: Center(
//             child: Icon(
//               FontAwesomeIcons.user,
//               color: AppColor.primaryColor,
//               size: 22,
//             ),
//           ),
//         )),
//   ];

//   late List<Widget> _widgetOptions;

//   @override
//   void initState() {
//     super.initState();
//     _widgetOptions = [
//       const DriverHomePage(),
//       const DriverFindLoadPage(),
//       const DriverProfile()
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColor.white));
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_currentIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: AppColor.primaryColor,
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white70,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: [
//           BottomNavigationBarItem(
//             icon: iconList[0],
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: iconList[1],
//             label: 'Accept Load',
//           ),
//           BottomNavigationBarItem(
//             icon: iconList[2],
//             label: 'Profile',
//           ),
//         ],
//         showSelectedLabels: true,
//         showUnselectedLabels: true,
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      const DriverHomePage(),
      const DriverFindLoadPage(),
      const DriverProfile()
    ];
  }

  CircleAvatar buildIcon(Widget child) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: buildIcon(Image.asset(AppIcons.home, color: AppColor.primaryColor)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(const Icon(Icons.add, color: AppColor.primaryColor, size: 24)),
            label: 'Accept Load',
          ),
          BottomNavigationBarItem(
            icon: buildIcon(const Icon(FontAwesomeIcons.user, color: AppColor.primaryColor, size: 22)),
            label: 'Profile',
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
      ),
    );
  }
}
