import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ootms/core/constants/color/app_color.dart';

class UserMap2Page extends StatefulWidget {
  @override
  _UserMap2PageState createState() => _UserMap2PageState();
}

class _UserMap2PageState extends State<UserMap2Page> {
  final String apiKey =
      'AIzaSyAJrp3VvbO4E4jo7HRgqsk7EP8mPIZStxQ'; // Replace with your Geoapify API key
  MapController mapController = MapController();
  LatLng? _markerPosition =
      LatLng(23.627556, 90.5212385); // Default marker position

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Map with marker
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.colorBurn),
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onTap: (tapPosition, point) {},
                initialCenter: (_markerPosition != null)
                    ? _markerPosition!
                    : LatLng(23.627556, 90.5212385),
                maxZoom: 21.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  additionalOptions: {
                    'apiKey': apiKey,
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 25.0,
                      height: 25.0,
                      point: (_markerPosition != null)
                          ? _markerPosition!
                          : LatLng(23.627556, 90.5212385),
                      child: InkWell(
                        onTap: () {
                          mapController.move(_markerPosition!, 11);
                          setState(() {});
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 255, 1),
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 1,
                                    )
                                  ],
                                  border: Border.all(
                                      width: 5, color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: 30,
            right: 20,
            child: InkWell(
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 1)],
                    shape: BoxShape.circle,
                    color: AppColor.white),
                child: Image.asset("assets/icons/message.png"),
              ),
            ),
          ),
          Positioned(
            top: 90,
            right: 20,
            child: InkWell(
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 1)],
                    shape: BoxShape.circle,
                    color: AppColor.white),
                child: const Icon(Icons.call),
              ),
            ),
          ),
          // Back button
          Positioned(
            top: 10,
            left: 16,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const CircleAvatar(
                maxRadius: 16,
                backgroundColor: AppColor.white,
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
