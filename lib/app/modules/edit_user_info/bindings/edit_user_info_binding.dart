import 'package:get/get.dart';

import '../controllers/edit_user_info_controller.dart';

class EditUserInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditUserInfoController>(
      () => EditUserInfoController(),
    );
  }
}
