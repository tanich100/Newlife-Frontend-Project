import 'package:get/get.dart';
import 'package:newlife_app/app/modules/postPet/controllers/provinces_controller.dart';

import '../controllers/post_pet_controller.dart';

class PostPetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostPetController>(
      () => PostPetController(),
    );
    Get.lazyPut<ProvinceController>(
      () => ProvinceController(),
    );
  }
}
