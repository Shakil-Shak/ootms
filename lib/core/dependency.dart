 import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_profile_controller/driver_profile_controller.dart';
import 'package:ootms/presentation/api/controllers/common/load_details_controller.dart';
import 'package:ootms/presentation/api/controllers/common/notification_controller.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/update_profile_controller.dart';
import 'package:ootms/presentation/api/controllers/user/shipping_controller/pending_shipment_controller.dart';

class DependencyInjection extends Bindings  {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => LoadDetailsController(), fenix: true);
    Get.lazyPut(() => PendingShipmentController(), fenix: true);
    Get.lazyPut(() => DriverProfileController(), fenix: true);
  }
}