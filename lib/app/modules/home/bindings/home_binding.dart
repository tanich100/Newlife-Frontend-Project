import 'package:get/get.dart';
import 'package:newlife_app/app/modules/notification/controllers/notification_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(NotificationController(), permanent: true);
  }
}
