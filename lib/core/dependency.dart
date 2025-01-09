 import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/load_details_controller.dart';
import 'package:ootms/presentation/api/controllers/notification_controller.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/update_profile_controller.dart';

class DependencyInjection extends Bindings  {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => LoadDetailsController(), fenix: true);
  }
}