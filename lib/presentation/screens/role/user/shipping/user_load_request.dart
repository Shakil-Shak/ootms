import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/navigation/animeted_navigation.dart';
import 'package:ootms/presentation/screens/role/user/shipping/user_load_request_details.dart';

class UserLoadRequestPage extends StatefulWidget {
  final bool isFromDrawer;
  const UserLoadRequestPage({super.key, this.isFromDrawer = false});

  @override
  State<UserLoadRequestPage> createState() => _UserLoadRequestPageState();
}

class _UserLoadRequestPageState extends State<UserLoadRequestPage>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> loadRequests = [
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'availability': 'The truck is fully available.',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'availability': 'The truck is fully available.',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'availability': 'The truck is fully available.',
      'driverImage': 'https://i.pravatar.cc/100',
    },
    {
      'driverName': 'Sabbir Ahmed',
      'truckInfo': '48-foot trailer—24 pallets.',
      'availability': 'The truck is fully available.',
      'driverImage': 'https://i.pravatar.cc/100',
    },
  ];

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController!.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: commonText('Load Request', size: 21, isBold: true),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Visibility(
            visible: widget.isFromDrawer,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2D4E68),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                controller: _tabController,
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(
                  color: AppColor.primaryColorLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                    child: FittedBox(
                      child: commonText(
                        "Load Request",
                        textAlign: TextAlign.center,
                        isBold: true,
                        size: 18,
                        color: (_tabController!.index == 0)
                            ? AppColor.black
                            : AppColor.white,
                      ),
                    ),
                  ),
                  Tab(
                    child: FittedBox(
                      child: commonText(
                        "My Request",
                        textAlign: TextAlign.center,
                        isBold: true,
                        size: 18,
                        color: (_tabController!.index == 1)
                            ? AppColor.black
                            : AppColor.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              padding: const EdgeInsets.all(16.0),
              itemCount: loadRequests.length,
              itemBuilder: (context, index) {
                final request = loadRequests[index];

                return Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(request['driverImage']),
                      radius: 24,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          commonText(request['driverName'],
                              size: 16, isBold: true),
                          const SizedBox(
                            height: 4,
                          ),
                          commonText(request['truckInfo'], size: 14),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.circle,
                                  size: 12, color: Colors.green),
                              const SizedBox(width: 4),
                              commonText(request['availability'], size: 14),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 40,
                            child: Row(
                              children: [
                                Expanded(
                                  child: commonButton(
                                    "Cancel",
                                    isBold: false,
                                    borderRadious: 10,
                                    onTap: () {
                                      // Add your cancel action
                                    },
                                    color: AppColor.primaryColorLight
                                        .withOpacity(0.5),
                                    textColor: AppColor.black,
                                  ),
                                ),
                                Expanded(
                                  child: commonButton("Accept Load", onTap: () {
                                    animetedNavigationPush(
                                        UserLoadRequestDetailsPage(), context);
                                  }, borderRadious: 10, isBold: false),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
