import 'package:get/get.dart';
import '../controllers/adoption_history_controller.dart';

class AdoptionHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdoptionHistoryController>(
      () {
        // Retrieve postId from Get.arguments
        final Map<String, dynamic> args = Get.arguments;
        final int postId = args['postId'] ?? 0;

        // Create and return the controller with the postId
        return AdoptionHistoryController(postId);
      },
    );
  }
}
