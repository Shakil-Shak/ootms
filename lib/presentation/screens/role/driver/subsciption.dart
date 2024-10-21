import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  PageController _pageController =
      PageController(viewportFraction: 0.8); // Carousel controller
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  List<String> mysubscription = [];

  @override
  void dispose() {
    _tabController?.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: commonText("Subscription", isBold: true, size: 21),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TabBar
          Container(
            decoration: BoxDecoration(
              color: Color(
                  0xFF2D4E68), // Background color for the TabBar container
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                color: Colors.grey[300], // Indicator color
                borderRadius: BorderRadius.circular(16),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text(
                    "All Packages",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: (_tabController!.index == 0)
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: commonText(
                    "My Package",
                    size: 16,
                    fontWeight: FontWeight.bold,
                    color: (_tabController!.index == 1)
                        ? Colors.black
                        : Colors.white,
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 20),

          (_tabController!.index == 1 && mysubscription.isEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: commonText("You don’t have any chosen package.",
                      isBold: true, size: 14),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: commonText(
                      "Choose your preferred package and\nupload your stories.",
                      isBold: true,
                      size: 14),
                ),

          const SizedBox(height: 20),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [allSubscription(), mySubscription()],
            ),
          ),
        ],
      ),
    );
  }

  Widget mySubscription() {
    return (mysubscription.isEmpty)
        ? Image.asset("assets/images/No Result 1.png")
        : CarouselSlider.builder(
            itemCount: mysubscription.length,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: subscriptionCard(),
              );
            },
            options: CarouselOptions(
              height: 450, // Adjust this according to your needs
              enlargeCenterPage: true,
              autoPlay: true, // Automatic sliding
              autoPlayInterval: Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          );
  }

  Widget allSubscription() {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, index, realIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: subscriptionCard(),
        );
      },
      options: CarouselOptions(
        height: 450, // Adjust this according to your needs
        enlargeCenterPage: true,
        autoPlay: true, // Automatic sliding
        autoPlayInterval: Duration(seconds: 5),
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget subscriptionCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Most Popular Tag
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: commonText("Most Popular", color: Colors.blue),
          ),
          const SizedBox(height: 10),

          // Plan Title
          commonText(
            "Advance",
            size: 22,
            isBold: true,
            color: Colors.black,
          ),

          // Price
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "\$09",
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: " per month",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Features (Checkmarks)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Buy Now Button

          commonIconButton(
            "Buy Now",
            isRight: true,
            const Icon(
              Icons.arrow_forward,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}