import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/data/network/api/find_owner_post_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';
import 'package:newlife_app/app/modules/home/views/recommended_pets.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final AdoptionPostApi adoptionPostApi = AdoptionPostApi();
  final FindOwnerPostApi findOwnerPostApi = FindOwnerPostApi();

  RxList<dynamic> allPets = <dynamic>[].obs;
  RxList<dynamic> filteredAllPets = <dynamic>[].obs;
  RxList<dynamic> recommendedPets = <dynamic>[].obs;

  var selectedTag = 'All'.obs;
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
    fetchRecommendedPets();
    tabController = TabController(length: categories.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setSelectedCategory(categories[tabController.index]);
        filterPetsByCategory();
      }
    });
  }

  Future<void> fetchAllPets() async {
    try {
      List<dynamic> pets = [];
      final adoptionPosts = await adoptionPostApi.getPosts();
      final findOwnerPosts = await findOwnerPostApi.getPosts();
      pets = [...adoptionPosts, ...findOwnerPosts];

      final userId = UserStorageService.getUserId();

      // กรองโพสต์ที่เป็นของตัวเองออก
      if (userId != null) {
        pets = pets.where((pet) {
          if (pet is AdoptionPost) {
            return pet.userId != userId;
          } else if (pet is FindOwnerPost) {
            return pet.userId != userId;
          }
          return true;
        }).toList();
      }

      filteredAllPets.value = pets;

      print(
          'Fetched ${filteredAllPets.length} total pets excluding user\'s own posts');
    } catch (e) {
      print('Error fetching pets: $e');
    }
  }

  Future<void> fetchRecommendedPets() async {
    try {
      final userId = UserStorageService.getUserId();
      if (userId != null) {
        List<AdoptionPost> recommendedPosts =
            await adoptionPostApi.getRecommendedPosts(userId);

        // กรองโพสต์ที่เป็นของตัวเองออก
        recommendedPosts =
            recommendedPosts.where((post) => post.userId != userId).toList();

        recommendedPets.value = recommendedPosts;
        print(
            'Fetched ${recommendedPets.length} recommended pets excluding user\'s own posts');
      }
    } catch (e) {
      print('Error fetching recommended pets: $e');
    }
  }

  void filterPetsByCategory() async {
    List<dynamic> pets = [];

    try {
      if (selectedCategory.value == 'สุนัข') {
        final adoptionDogs = await adoptionPostApi.getDogPosts();
        final findOwnerDogs = await findOwnerPostApi.getDogPosts();
        pets = [...adoptionDogs, ...findOwnerDogs];
      } else if (selectedCategory.value == 'แมว') {
        final adoptionCats = await adoptionPostApi.getCatPosts();
        final findOwnerCats = await findOwnerPostApi.getCatPosts();
        pets = [...adoptionCats, ...findOwnerCats];
      } else if (selectedCategory.value == 'สัตว์ดูแลพิเศษ') {
        pets = await adoptionPostApi.getSpecialCarePosts();
      } else {
        // เรียกข้อมูลทั้งหมดจาก API
        final adoptionPosts = await adoptionPostApi.getPosts();
        final findOwnerPosts = await findOwnerPostApi.getPosts();
        pets = [...adoptionPosts, ...findOwnerPosts];
      }

      filteredAllPets.value = pets; // อัปเดตข้อมูลที่กรองแล้ว
    } catch (e) {
      print('Error filtering pets by category: $e');
    }
  }

  void navigateToPetDetail(dynamic pet) {
    if (pet == null) {
      print('Pet is null, cannot navigate to detail');
      return;
    }

    if (pet is AdoptionPost) {
      Get.toNamed('/pets-detail', arguments: {'pet': pet, 'type': 'adoption'});
    } else if (pet is FindOwnerPost) {
      Get.toNamed('/pets-detail',
          arguments: {'pet': pet, 'type': 'find-owner'});
    } else {
      print('Unknown pet type, cannot navigate to detail');
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
    filterPetsByCategory();
  }

  void updateTag(String tag) {
    print('Selected tag: $tag');
  }

  void setLocation(String newLocation) {
    location.value = newLocation;
  }

  @override
  void onReady() {
    super.onReady();
  }
}
