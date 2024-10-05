import 'package:get/get.dart';
import 'package:newlife_app/app/data/pet_data.dart';

class FavoriteController extends GetxController {
  //TODO: Implement FavoriteController
  final RxList<Pet> favoritePets = <Pet>[].obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    favoritePets.addAll(pets.where((pet) => pet.id == 1 || pet.id == 2));
  }

  void removePet(Pet pet) {
    favoritePets.remove(pet);
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
