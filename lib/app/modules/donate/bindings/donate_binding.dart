import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';

import '../controllers/donate_controller.dart';

class DonateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<DonateController>(
      () => DonateController(),
    );
  }
}
