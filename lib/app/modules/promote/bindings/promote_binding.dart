import 'package:get/get.dart';

import '../controllers/promote_controller.dart';

class PromoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromoteController>(
      () => PromoteController(),
    );
  }
}
