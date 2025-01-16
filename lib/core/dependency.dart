
import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/driver/find_load_controller.dart';
import 'package:ootms/presentation/api/controllers/driver/google_map_controller.dart';
import 'package:ootms/presentation/api/controllers/load_details_controller.dart';
import 'package:ootms/presentation/api/controllers/notification_controller.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/update_profile_controller.dart';
import 'package:ootms/presentation/api/controllers/user/shipping_controller/pending_shipment_controller.dart';

class DependencyInjection extends Bindings  {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => LoadDetailsController(), fenix: true);
    Get.lazyPut(() => PendingShipmentController(), fenix: true);
    Get.lazyPut(() => FindLoadController(), fenix: true);
    Get.lazyPut(() => CustomMapController(), fenix: true);
  }
}