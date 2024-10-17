import 'dart:io';

import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/data/network/api/find_owner_post_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';
import 'package:newlife_app/app/modules/camera/views/result_view.dart';
import 'package:newlife_app/app/modules/camera/views/searching_view.dart';

class ImageSearchController extends GetxController {
  AdoptionPostApi adoptionPostApi = AdoptionPostApi();
  final FindOwnerPostApi findOwnerPostApi = FindOwnerPostApi();
  RxBool isSearching = false.obs;
  RxList<dynamic> filteredAllPets = <dynamic>[].obs;

  Future<void> getImageSearch(String petType, File file) async {
    // เริ่มค้นหา
    isSearching.value = true;
    Get.to(SearchingView());
    var Idlist = await adoptionPostApi.searchByImage(petType, file);
    print(Idlist);
    await fetchFromImageResult(Idlist);
    isSearching.value = false;
    Get.to(ResultView());
  }

  // Future<void> fetchFromImageResult(List<int> Idlist) async {
  //   try {
  //     List<dynamic> pets = [];
  //     final adoptionPosts = await adoptionPostApi.getPosts();
  //     final findOwnerPosts = await findOwnerPostApi.getPosts();
  //     pets = [...adoptionPosts, ...findOwnerPosts];
  //     final userId = UserStorageService.getUserId();

  //     if (userId != null) {
  //       pets = pets.where((pet) {
  //         int? postId;

  //         if (pet is AdoptionPost) {
  //           postId = pet.adoptionPostId;
  //         } else if (pet is FindOwnerPost) {
  //           postId = pet.adoptionPostId;
  //         }

  //         return postId != null && postId != userId && Idlist.contains(postId);
  //       }).toList();
  //     }

  //     filteredAllPets.value = pets;

  //     print(
  //         'Fetched ${filteredAllPets.length} total pets excluding user\'s own posts');
  //   } catch (e) {
  //     print('Error fetching pets: $e');
  //   }
  // }

  Future<void> fetchFromImageResult(List<int> Idlist) async {
    try {
      List<dynamic> pets = [];
      final adoptionPosts = await adoptionPostApi.getPosts();
      final findOwnerPosts = await findOwnerPostApi.getPosts();
      pets = [...adoptionPosts, ...findOwnerPosts];

      final userId = UserStorageService.getUserId();

      // Filter pets to include only those in the Idlist, and exclude those belonging to the user
      pets = pets.where((pet) {
        int? postId;

        if (pet is AdoptionPost) {
          postId = pet.adoptionPostId; 
        } else if (pet is FindOwnerPost) {
          postId = pet.adoptionPostId; 
        }

        // Return true if the postId is in Idlist and does not belong to the user
        return postId != null && Idlist.contains(postId);
      }).toList();

      print('Filtered pets');
      // print(pets);

      filteredAllPets.value = pets;
      print(filteredAllPets);
    } catch (e) {
      print('Error fetching or filtering posts: $e');
    }
  }
}
