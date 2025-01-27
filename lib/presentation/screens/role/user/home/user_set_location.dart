
import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/create_load_map_controller.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/profile_controller.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/screens/role/user/create_load/create_load_map_screen.dart';
import 'package:provider/provider.dart';

class UserSetLocationPage extends StatelessWidget {
  const UserSetLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        centerTitle: true,
        title: commonText(
          'Set Your Location',
          size: 18,
          isBold: true,
          color: Colors.black,
        ),
      ),
      body: Consumer<ProfileController>(builder: (context, value, child) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 16,
            ),
            // Location Options
            Expanded(
              child: ListView(
                children: [
                  // Set on Map Option
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration:
                    const BoxDecoration(color: AppColor.white, boxShadow: [
                      BoxShadow(blurRadius: 3, color: Colors.black38),
                    ]),
                    child: ListTile(
                      leading: Image.asset("assets/icons/user home page/pin.png"),
                      title: commonText('Set On Map', size: 16, isBold: true),
                      onTap: () async {
                        CreateLoadMapController.instance.marker.clear();
                        Map data = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CreateLoadMapScreen(), // Show the LocationScreen
                          ),
                        );
                        value.currentLocation = "${data['address']}, ${data['city']}, ${data['state']}, ${data['zip']}";
                        value.setMapLocation(address: "${data['address']}, ${data['city']}, ${data['state']}, ${data['zip']}");
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // My Current Location Option
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration:
                    const BoxDecoration(color: AppColor.white, boxShadow: [
                      BoxShadow(blurRadius: 3, color: Colors.black38),
                    ]),
                    child: ListTile(
                      leading: Image.asset("assets/icons/user home page/pin.png"),
                      title: commonText('My Current Location',
                          size: 16, isBold: true),
                      onTap: () {
                        Provider.of<ProfileController>(context, listen: false)
                            .getCurrentLocation();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },),
    );
  }
}
