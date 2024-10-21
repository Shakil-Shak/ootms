import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

class UserTermsconditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: commonText('Terms & conditions', size: 20, isBold: true),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: commonText(
              size: 18,
              "Lorem ipsum dolor sit amet consectetur. Mauris cursus laoreet ut egestas. Faucibus elit nunc luctus felis. Nullam faucibus quisque tristique elementum sagittis tempus at lectus. Mattis ipsum amet eu aliquam lorem mi scelerisque sodales viverra. Convallis pretium consequat risus ut augue. Parturient at aliquam egestas diam sed. Sagittis et malesuada sem cras. Maecenas eu aliquam id feugiat gravida nisl ultricies. Integer dui odio nibh quis. Faucibus a luctus amet enim lobortis odio. In turpis sed quam sed etiam senectus bibendum in a. Sagittis dui fringilla morbi sit interdum netus. Lacinia nulla at fusce pellentesque elementum suscipit venenatis. Nisl id aliquet quis id sed cursus vel senectus risus. Neque donec aliquet urna dictumst. Tortor semper lorem lacus ipsum commodo. Eget amet urna montes libero enim in semper. Nisi vivamus consectetur euismod ut eget sit ultricies cursus lectus. Nisl cursus fermentum tempor at."),
        ),
      ),
    );
  }
}
