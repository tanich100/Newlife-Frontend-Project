import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';

class PostPetController extends GetxController {
  //TODO: Implement PostPetController
  AdoptionPostApi adoptionPostApi = AdoptionPostApi();
  var adoptionPostList = <AdoptionPost>[].obs;

  final count = 0.obs;
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

  Future<void> getNewPet() async {
    adoptionPostList.value = [];
    adoptionPostList.value = await adoptionPostApi.getNewPet();
  }

  void increment() => count.value++;
}
