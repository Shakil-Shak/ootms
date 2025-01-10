import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;
  valueIncrease() {
    currentIndex = 2;
    update();
  }

  void updateIndex(int index) {
    currentIndex = index;
    update(); 
  }
}
