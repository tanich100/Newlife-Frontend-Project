import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/pet_data.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
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

   late TabController tabController;
  final RxString selectedCategory = 'ทั้งหมด'.obs;
  final List<String> categories = ['ทั้งหมด', 'สุนัข', 'แมว', 'สัตว์สูญหาย', 'สัตว์ดูแลพิเศษ'];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: categories.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setSelectedCategory(categories[tabController.index]);
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
  }

  void updateTag(String tag) {
    print('Selected tag: $tag');
    // เพิ่มลอจิกการกรองหรืออัพเดทข้อมูลตาม tag ที่นี่
  }

  void setLocation(String newLocation) {
    location.value = newLocation;
  }      




  @override
  void onReady() {
    super.onReady();
  }

  
}
