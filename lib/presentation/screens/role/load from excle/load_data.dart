import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';

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
                        title: commonText('Load - 1', size: 18, isBold: true),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 16,
                                    height: 16,
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(width: 1)),
                                    child: FittedBox(
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: AppColor.black,
                                      ),
                                    )),
                                SizedBox(width: 8),
                                Expanded(
                                    child: commonText('Rupatoli, Barishal.')),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                    width: 16,
                                    height: 16,
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(width: 1)),
                                    child: FittedBox(
                                      child: Icon(
                                        Icons.arrow_downward,
                                        color: AppColor.black,
                                      ),
                                    )),
                                SizedBox(width: 8),
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
            SizedBox(height: 16),
            commonButton("Continue")
          ],
        ),
      ),
    );
  }
}
