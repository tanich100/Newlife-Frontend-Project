import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';

import '../controllers/adopted_history_controller.dart';

class AdoptedHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdoptedHistoryController>(
      () => AdoptedHistoryController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
