import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/driver/home/driver_map2.dart';

class DriverMapPage extends StatefulWidget {
  @override
  _DriverMapPageState createState() => _DriverMapPageState();
}

class _DriverMapPageState extends State<DriverMapPage> {
  final String apiKey =
      'AIzaSyAJrp3VvbO4E4jo7HRgqsk7EP8mPIZStxQ'; // Replace with your Geoapify API key
  MapController mapController = MapController();
  LatLng? _markerPosition =
      LatLng(23.627556, 90.5212385); // Default marker position
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  // Function to trigger the bottom sheet with location details
  void _showLocationDetails(LatLng position) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              width: MediaQuery.of(context).size.width, // Full width
              height: MediaQuery.of(context).size.height *
                  0.9, // 70% of screen height
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    commonText("Shipping Details", size: 16, isBold: true),
                    SizedBox(
                      height: 10,
                    ),
                    loadDetailsCard(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        commonText("Live tracking", size: 18, isBold: true),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            animetedNavigationPush(DriverMap2Page(), context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1)),
                            child: commonText("Track on map",
                                color: AppColor.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 5,
                      color: AppColor.white,
                      child: Container(
                        height: 240,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            commonText("Map", size: 24, isBold: true),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Handle marker or map tap and show the bottom sheet
  void _onMarkerTap(LatLng position) {
    setState(() {
      _markerPosition = position;
    });
    _showLocationDetails(position); // Show bottom sheet on marker tap
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
                onTap: (tapPosition, point) {
                  _onMarkerTap(point); // Trigger bottom sheet on map tap
                },
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
                          _onMarkerTap(_markerPosition!);
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

          // Search Bar
          Positioned(
            top: 50,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search your location',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Icon(Icons.search),
                ],
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

  Widget loadDetailsCard() {
    return Card(
      color: AppColor.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Load details and status
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText("John Doe's Load", size: 16, isBold: true),
                SizedBox(height: 4),
                commonText(
                  '7421477-475645',
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
            Divider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText(
                              'From',
                              color: Colors.grey,
                            ),
                            commonText('Rupatoli, Barishal',
                                size: 14, isBold: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            commonText(
                              'To',
                              color: Colors.grey,
                            ),
                            commonText('Banasree, Dhaka',
                                size: 14, isBold: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: commonText(
                    'In transit',
                    size: 14,
                    isBold: true,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Shipment progress
            shipmentStep(
              title: 'In transit at sorting center',
              location: 'Dhaka',
              dateTime: '2024-07-16 | 08:00 AM',
            ),
            shipmentStep(
              title: 'Dispatched',
              location: 'London',
              dateTime: '2024-07-15 | 02:30 PM',
            ),
            shipmentStep(
              title: 'Picked up',
              location: 'Barishal',
              dateTime: '2024-07-14 | 10:00 AM',
            ),
          ],
        ),
      ),
    );
  }

  Widget shipmentStep(
      {required String title,
      required String location,
      required String dateTime}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.location_on, color: Colors.red, size: 24),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonText(title, size: 14, isBold: true),
                SizedBox(height: 4),
                Row(
                  children: [
                    commonText(
                      location,
                      color: Colors.black87,
                    ),
                    SizedBox(width: 5),
                    commonText(
                      '|',
                      color: Colors.black87,
                    ),
                    SizedBox(width: 5),
                    commonText(
                      dateTime,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
