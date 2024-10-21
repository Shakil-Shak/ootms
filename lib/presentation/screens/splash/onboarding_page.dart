// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ootms/core/constants/color/app_color.dart';
import 'package:ootms/presentation/components/common_button.dart';
import 'package:ootms/presentation/components/common_text.dart';
import 'package:ootms/presentation/screens/auth/sign_in_sign_up_chosser.dart';

import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  final PageController _pageController = PageController();
  bool user;
  OnboardingScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardingProvider>(
        builder: (context, onboardingProvider, child) {
          return Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    onboardingProvider.setPage(index);
                  },
                  children: [
                    OnboardingPage(
                      imagePath: (user)
                          ? 'assets/images/onborder1.png'
                          : 'assets/images/onbording1d.png',
                      title: "Welcome to\n“OOTMS”",
                      description: (user)
                          ? "Simplify Your Shipment Process with “OOTMS”."
                          : "Make your job easier with instant load matching, real-time updates, and seamless communication.",
                    ),
                    OnboardingPage(
                      imagePath: 'assets/images/onborder2.png',
                      title: (user)
                          ? "“Effortless Load Posting”"
                          : "“Accept Loads that Fit Your Schedule”",
                      description: (user)
                          ? "For shippers: Post your load details and let drivers pick it up."
                          : "Accept loads that match your availability and equipment.",
                    ),
                    OnboardingPage(
                      imagePath: (user)
                          ? 'assets/images/onborder3.png'
                          : 'assets/images/obbording3d.png',
                      title: (user)
                          ? "“Track Your Freight with Real-Time Location Updates”"
                          : "“Stay Connected with Shippers”",
                      description: (user)
                          ? "Stay informed about your shipment’s exact location as it moves through the supply chain."
                          : "Chat directly with shippers to confirm delivery details, send updates, and manage changes.",
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: 8,
                    width: onboardingProvider.currentPage == index
                        ? 21
                        : 13, // Adjust the size of the active dot
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: onboardingProvider.currentPage == index
                          ? AppColor.primaryColor
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 16.0),
                child: onboardingProvider.currentPage == 2
                    ? commonButton(
                        "Get Started",
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignInSignUpChosserPage(user: user))),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              // Handle skip action
                              _pageController.jumpToPage(2);
                            },
                            child: commonText("Skip"),
                          ),
                          SizedBox(
                            width: 130,
                            child: commonButton(
                              "Next",
                              onTap: () {
                                // Move to next page
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({super.key, 
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 24.0),
          commonText(
            title,
            textAlign: TextAlign.center,
            size: 20,
            color: AppColor.black,
            isBold: true,
          ),
          const SizedBox(height: 16.0),
          commonText(
            description,
            textAlign: TextAlign.center,
            size: 16,
            color: AppColor.black,
          ),
        ],
      ),
    );
  }
}

class OnboardingProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
