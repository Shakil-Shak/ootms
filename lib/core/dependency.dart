import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_profile_controller/driver_profile_controller.dart';
import 'package:ootms/presentation/api/controllers/Driver/load_request_controller/load_request_controller.dart';
import 'package:ootms/presentation/api/controllers/common/load_details_controller.dart';
import 'package:ootms/presentation/api/controllers/common/notification_controller.dart';

import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/driver/find_load_controller.dart';
import 'package:ootms/presentation/api/controllers/driver/google_map_controller.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/update_profile_controller.dart';
import 'package:ootms/presentation/api/controllers/user/shipping_controller/pending_shipment_controller.dart';

import '../presentation/api/controllers/Driver/driver_currentshiping_controller/shipment_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => LoadDetailsController(), fenix: true);
    Get.lazyPut(() => PendingShipmentController(), fenix: true);
    Get.lazyPut(() => DriverProfileController(), fenix: true);
    Get.lazyPut(() => DriverShipmentController(), fenix: true);
    Get.lazyPut(() => DriverLoadRequest(), fenix: true);
    Get.lazyPut(() => FindLoadController(), fenix: true);
    Get.lazyPut(() => CustomMapController(), fenix: true);
    Get.lazyPut(() => DriverProfileController(), fenix: true);
  }
}
