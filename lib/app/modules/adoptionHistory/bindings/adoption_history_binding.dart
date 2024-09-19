import 'package:get/get.dart';

import '../controllers/adoption_history_controller.dart';

class AdoptionHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdoptionHistoryController>(
      () => AdoptionHistoryController(),
    );
  }
}
