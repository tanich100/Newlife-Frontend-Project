import 'package:get/get.dart';

class PetsDetailController extends GetxController {
  //TODO: Implement PetsDetailController

  final count = 0.obs;

  final  isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void sendAdoptionRequest() {
    // Implement the logic for sending an adoption request
    print('Adoption request sent');
    Get.snackbar('Success', 'Adoption request sent successfully');
  }
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
