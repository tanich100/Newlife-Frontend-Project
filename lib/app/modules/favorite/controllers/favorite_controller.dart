import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/favorite_pets_model.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/data/network/api/favorite_animal_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';

class FavoriteController extends GetxController {
  final FavoriteAnimalApi _favoriteAnimalApi = FavoriteAnimalApi();
  final AdoptionPostApi _adoptionPostApi = AdoptionPostApi();
  final RxList<AdoptionPost> favoritePosts = <AdoptionPost>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavoritePosts();
  }

  Future<void> fetchFavoritePosts() async {
    try {
      final userId = UserStorageService.getUserId();
      if (userId == null) return;

      final favorites = await _favoriteAnimalApi.getUserFavorites(userId);
      final List<AdoptionPost> adoptionPosts = [];

      for (var favorite in favorites) {
        // Use _adoptionPostApi to fetch the post
        final post = await _adoptionPostApi.getPost(favorite.adoptionPostId);
        if (post != null) {
          adoptionPosts.add(post);
        }
      }

      favoritePosts.assignAll(adoptionPosts);
    } catch (e) {
      print('Error fetching favorite posts: $e');
    }
  }

  Future<void> removeFavorite(AdoptionPost post) async {
    try {
      // Fetch the list of favorites
      final favorites = await _favoriteAnimalApi
          .getUserFavorites(UserStorageService.getUserId()!);

      // Use a default FavoriteAnimal instead of returning null
      final FavoriteAnimal favoriteToRemove = favorites.firstWhere(
        (favorite) => favorite.adoptionPostId == post.adoptionPostId,
        orElse: () => FavoriteAnimal(
          // Provide a default object
          favoriteAnimalId: 0, // Default values
          adoptionPostId: 0, // Default values
          userId: 0, // Default values
          dateAdded: DateTime.now(), // Default date
        ),
      );

      // Check if the favoriteToRemove is valid before proceeding
      if (favoriteToRemove.favoriteAnimalId != 0) {
        await _favoriteAnimalApi
            .deleteFavorite(favoriteToRemove.favoriteAnimalId!);
        favoritePosts
            .removeWhere((item) => item.adoptionPostId == post.adoptionPostId);
      } else {
        print('Error: Favorite not found for this post');
      }
    } catch (e) {
      print('Error removing favorite: $e');
    }
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
