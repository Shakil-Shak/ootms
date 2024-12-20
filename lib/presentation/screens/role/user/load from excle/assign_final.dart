import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';

class AssignFinalScreen extends StatefulWidget {
  @override
  _AssignFinalScreenState createState() => _AssignFinalScreenState();
}

class _AssignFinalScreenState extends State<AssignFinalScreen> {
  String? selectedOption;
  List<bool> loadSelections = List.generate(10, (index) => false);

  void _showBottomSheet(
      BuildContext context, String option, Function()? onchanged) {
    setState(() {
      selectedOption = option;
    });

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
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
              SizedBox(height: 20),
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
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
                  SizedBox(width: 16),
                  // "Yes" Button
                  TextButton(
                    onPressed: onchanged,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade800,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
              SizedBox(height: 10),
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
          'Load Data',
          size: 21,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
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
                    title: commonText(
                      'Load - ${index + 1}',
                      fontWeight: FontWeight.bold,
                      size: 16,
                    ),
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
                            commonText('Rupatoli, Barishal.'),
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
                            commonText('Banasree, Dhaka'),
                          ],
                        ),
                      ],
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: Colors.blue,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            commonButton("Assign Load"),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
