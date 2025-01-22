import 'package:get/get.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_currentshiping_controller/driver_shiping_history.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_find_load_controller.dart';
import 'package:ootms/presentation/api/controllers/Driver/equipment_controller/equipment_controller.dart';
import 'package:ootms/presentation/api/controllers/Driver/on_duity_controller/on_duity_controller.dart';
import 'package:ootms/presentation/api/controllers/driver/find_load_controller.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/create_load_map_controller.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/google_map_controller.dart';
import 'package:ootms/presentation/api/controllers/Driver/driver_profile_controller/driver_profile_controller.dart';
import 'package:ootms/presentation/api/controllers/Driver/load_request_controller/load_request_controller.dart';
import 'package:ootms/presentation/api/controllers/common/load_details_controller.dart';
import 'package:ootms/presentation/api/controllers/common/notification_controller.dart';
import 'package:ootms/presentation/api/controllers/mapControllers/live_tracking_controller.dart';
import 'package:ootms/presentation/api/controllers/user/load_controller/assign_load_controller.dart';
import 'package:ootms/presentation/api/controllers/user/nearest_driver_controller/find_nearest_driver_controller.dart';
import 'package:ootms/presentation/api/controllers/user/prefered_driver_controller/prefered_driver_controller.dart';
import 'package:ootms/presentation/api/controllers/user/profile_controller/update_profile_controller.dart';
import 'package:ootms/presentation/api/controllers/user/shipping_controller/pending_shipment_controller.dart';

import '../presentation/api/controllers/Driver/driver_currentshiping_controller/shipment_controller.dart';
import '../presentation/api/controllers/user/profile_controller/user_getx_profile_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateProfileController(), fenix: true);
    Get.lazyPut(() => NotificationController(), fenix: true);
    Get.lazyPut(() => LoadDetailsController(), fenix: true);
    Get.lazyPut(() => PendingShipmentController(), fenix: true);
    Get.lazyPut(() => FindLoadController(), fenix: true);
    Get.lazyPut(() => CustomMapController(), fenix: true);
    Get.lazyPut(() => CreateLoadMapController(), fenix: true);
    Get.lazyPut(() => DriverProfileController(), fenix: true);
    Get.lazyPut(() => DriverShipmentController(), fenix: true);
    Get.lazyPut(() => DriverLoadRequest(), fenix: true);
    Get.lazyPut(() => DriverProfileController(), fenix: true);
    Get.lazyPut(() => UserGetxProfileController(), fenix: true);
    Get.lazyPut(() => FindNearestDriverController(), fenix: true);
    Get.lazyPut(() => PreferedDriverController(), fenix: true);
    Get.lazyPut(() => AssignLoadController(), fenix: true);
    Get.lazyPut(() => LiveTrackingController(), fenix: true);
    Get.lazyPut(() => EquipmentController(), fenix: true);
    Get.lazyPut(() => OnduityController(), fenix: true);
    Get.lazyPut(() => DriverFindLoadController(), fenix: true);
    Get.lazyPut(() => DriverShipingHistory(), fenix: true);
  }
}
