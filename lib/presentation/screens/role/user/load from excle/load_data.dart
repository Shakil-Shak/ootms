import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/home/user_map2.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/assign_preferred_driver.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/load_details.dart';

class LoadDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText(
          'Load Data',
          size: 21,
          isBold: true,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      child: ListTile(
                        onTap: () {
                          animetedNavigationPush(
                              (const LoadDetailsScreen()), context);
                        },
                        title: commonText('Load - 1', size: 18, isBold: true),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 16,
                                    height: 16,
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(width: 1)),
                                    child: const FittedBox(
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: AppColor.black,
                                      ),
                                    )),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: commonText('Rupatoli, Barishal.')),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                    width: 16,
                                    height: 16,
                                    padding: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(width: 1)),
                                    child: const FittedBox(
                                      child: Icon(
                                        Icons.arrow_downward,
                                        color: AppColor.black,
                                      ),
                                    )),
                                const SizedBox(width: 8),
                                Expanded(child: commonText('Banasree, Dhaka')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            commonButton("Continue", onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        commonText(
                          'Do you have a preferred Driver?',
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // "No" Button
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                   animetedNavigationPush(
                                    const UserMap2Page(), context);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: commonText(
                                'No',
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 16),
                            // "Yes" Button
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);

                                animetedNavigationPush(
                                    AssignPreferredDriver(), context);
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade800,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: commonText(
                                'Yes',
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              );
              // animetedNavigationPush(AssignLoadsScreen(), context);
            })
          ],
        ),
      ),
    );
  }
}
