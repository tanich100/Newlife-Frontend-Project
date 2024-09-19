import 'package:get/get.dart';

import '../controllers/adopted_history_controller.dart';

class AdoptedHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdoptedHistoryController>(
      () => AdoptedHistoryController(),
    );
  }
}
