 import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/update_profile_controller.dart';

class DependencyInjection extends Bindings  {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController(), fenix: true);
  }
}