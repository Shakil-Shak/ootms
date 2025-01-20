import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;
  valueIncrease({int? value}) {
    currentIndex =value == null? 2:value;
    update();
  }

  void updateIndex(int index) {
    currentIndex = index;
    update(); 
  }
}
