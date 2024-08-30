import 'package:get/get.dart';

import '../controllers/pets_detail_controller.dart';

class PetsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetsDetailController>(
      () => PetsDetailController(),
    );
  }
}
