import 'package:get/get.dart';

import '../controllers/post_pet_controller.dart';

class PostPetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostPetController>(
      () => PostPetController(),
    );
  }
}
