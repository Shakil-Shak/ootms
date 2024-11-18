import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/assign_preferred_driver.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/assign_final.dart';

class AssignLoadsScreen extends StatefulWidget {
  @override
  _AssignLoadsScreenState createState() => _AssignLoadsScreenState();
}

class _AssignLoadsScreenState extends State<AssignLoadsScreen> {
  String? selectedOption;
  List<bool> loadSelections = List.generate(10, (index) => false);

  void _showBottomSheet(
      BuildContext context, String option, Function()? onchanged) {
    setState(() {
      selectedOption = option;
    });

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
                    onPressed: onchanged,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: commonText(
          'Assign Loads',
          size: 21,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: loadSelections.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  value: loadSelections[index],
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _showBottomSheet(
                          context,
                          'You selected Load - ${index + 1}',
                          () {
                            setState(() {
                              loadSelections[index] = value ?? false;
                              Navigator.pop(context);
                            });
                          },
                        );
                      } else {
                        loadSelections[index] = value ?? false;
                      }
                    });
                  },
                  title: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: commonText(
                          'Load - ${index + 1}',
                          fontWeight: FontWeight.bold,
                          size: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
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
                                commonText('Rupatoli, Barishal.'),
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
                                commonText('Banasree, Dhaka'),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.blue,
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          commonButton(
            "Assign to Driver",
            borderRadious: 16,
            onTap: () {
              // animetedNavigationPush(AssignFinalScreen(), context);
            },
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1)),
            child: commonIconButton(onTap: () {
              // animetedNavigationPush(AssignPreferredDriver(), context);
            }, "Assign to Another Driver", const Icon(Icons.add),
                textColor: AppColor.black, color: Colors.transparent),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
