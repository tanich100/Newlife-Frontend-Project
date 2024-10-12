import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/data/network/api/find_owner_post_api.dart';
import 'package:newlife_app/app/data/pet_data.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AdoptionPostApi adoptionPostApi = AdoptionPostApi();
  final FindOwnerPostApi findOwnerPostApi = FindOwnerPostApi();

  RxList<dynamic> allPets = <dynamic>[].obs;

  RxList<dynamic> filteredAllPets = <dynamic>[].obs;

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
  final List<String> categories = [
    'ทั้งหมด',
    'สุนัข',
    'แมว',
    'สัตว์สูญหาย',
    'สัตว์ดูแลพิเศษ'
  ];

  @override
  void onInit() {
    super.onInit();
    fetchAllPets();
    tabController = TabController(length: categories.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setSelectedCategory(categories[tabController.index]);
      }
    });
  }

  Future<void> fetchAllPets() async {
    try {
      final adoptionPosts = await adoptionPostApi.getPosts();
      final findOwnerPosts = await findOwnerPostApi.getPosts();

      allPets.value = [...adoptionPosts, ...findOwnerPosts];
      allPets.shuffle();

      print('Fetched ${allPets.length} total pets');
    } catch (e) {
      print('Error fetching pets: $e');
    }
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
