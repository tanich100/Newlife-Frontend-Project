import 'package:get/get.dart';
import 'package:newlife_app/app/modules/adoptionHistory/controllers/adoption_history_controller.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';

class AdoptionHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdoptionHistoryController>(
      () => AdoptionHistoryController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
