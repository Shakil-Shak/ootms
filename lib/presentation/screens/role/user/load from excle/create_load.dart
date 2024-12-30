import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/load%20from%20excle/load_data.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Create_load_XL extends StatefulWidget {
  const Create_load_XL({super.key});

  @override
  State<Create_load_XL> createState() => _Create_load_XLState();
}

class _Create_load_XLState extends State<Create_load_XL> {
  @override
  Widget build(BuildContext context) {
    Future<void> _importExcel() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
      );

      if (result != null) {
        final file = File(result.files.single.path!);
        final bytes = file.readAsBytesSync();
        final excel = Excel.decodeBytes(bytes);
        animetedNavigationPush(LoadDataScreen(), context);

        // setState(() {
        //   _columns = [];
        //   _rows = [];

        //   final table = excel.tables.values.first;
        //   _columns = table.rows.first.map((e) => e?.toString() ?? '').toList();
        //   _rows = table.rows
        //       .skip(1) // Skip the header row
        //       .map((row) => row.map((e) => e?.toString() ?? '').toList())
        //       .toList();
        // });
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: commonText("Create Load", size: 21, isBold: true),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            commonIconButton(
              "Download the Excel Form",
              onTap: () {
                animetedNavigationPush(LoadDataScreen(), context);
              },
              color: AppColor.primaryColorLight,
              textColor: AppColor.black,
              const FaIcon(FontAwesomeIcons.fileExcel),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: _importExcel,
              child: DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: const [7, 7],
                radius: const Radius.circular(10),
                color: AppColor.black,
                strokeWidth: 1,
                child: SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cloud_upload_outlined,
                        color: Colors.grey,
                        size: 80,
                      ),
                      commonText("Upload the Excel Sheet",
                          size: 14, fontWeight: FontWeight.w500)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
