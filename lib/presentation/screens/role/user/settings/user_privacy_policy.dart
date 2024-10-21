import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';

class UserPrivacyPolicyPage extends StatelessWidget {
  const UserPrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        title: commonText('Privacy policy', size: 20, isBold: true),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              commonText(
                'Lorem ipsum dolor sit amet consectetur. . Convallis vel risus egestas ornare proin in. Arcu sodales tempus tellus mattis ac elit hendrerit sapien venenatis id gravida nisl.',
                size: 14,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.circle,
                      size: 10,
                    ),
                  ),
                  Expanded(
                    child: commonText(
                        "Lorem ipsum dolor sit amet consectetur. Mauris cursus laoreet ut egestas. Faucibus elit nunc luctus felis. Nullam faucibus quisque tristique elementum sagittis tempus at lectus. Mattis ipsum amet eu aliquam lorem mi scelerisque sodales viverra. Convallis pretium consequat risus ut augue. Parturient at aliquam egestas diam sed. Sagittis et malesuada sem cras. Maecenas eu aliquam id feugiat gravida nisl ultricies. Integer dui odio nibh quis. Faucibus a luctus amet enim lobortis odio. In turpis sed quam sed etiam senectus bibendum in a. Sagittis dui fringilla morbi sit interdum netus. Lacinia nulla at fusce pellentesque elementum suscipit venenatis. Nisl id aliquet quis id sed cursus vel senectus risus. Neque donec aliquet urna dictumst. Tortor semper lorem lacus ipsum commodo. Eget amet urna montes libero enim in semper. Nisi vivamus consectetur euismod ut eget sit ultricies cursus lectus. Nisl cursus fermentum tempor at.",
                        size: 18),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
