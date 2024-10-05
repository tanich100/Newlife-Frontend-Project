import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';

import '../controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }
}
