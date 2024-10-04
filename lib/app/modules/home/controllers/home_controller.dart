import 'package:get/get.dart';
import 'package:newlife_app/app/data/pet_data.dart';

class HomeController extends GetxController {
  var selectedTag = 'All'.obs;

  List<Pet> get recommendedPets =>
      pets.where((pet) => pet.tag == 'Recommend').toList();
  List<Pet> get newArrivals =>
      pets.where((pet) => pet.tag == 'New Arrival').toList();
  List<Pet> get filteredPets => selectedTag.value == 'All'
      ? pets
      : pets
          .where((pet) =>
              pet.category.toLowerCase() == selectedTag.value.toLowerCase())
          .toList();

  
  final RxString location = ''.obs;

  void setLocation(String newLocation) {
    location.value = newLocation;
  }      

  void updateTag(String tag) {
    selectedTag.value = tag;
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
}
