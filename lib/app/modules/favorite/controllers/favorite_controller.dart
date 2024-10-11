import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/favorite_pets_model.dart';
import 'package:newlife_app/app/data/network/api/favorite_animal_api.dart';

class FavoriteController extends GetxController {
  final FavoriteAnimalApi _favoriteAnimalApi = FavoriteAnimalApi();
  final RxList<FavoriteAnimal> favoritePets = <FavoriteAnimal>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavoritePets();
  }

  Future<void> fetchFavoritePets() async {
    try {
      final favorites = await _favoriteAnimalApi.getFavoriteAnimals();
      favoritePets.assignAll(favorites);
      print('Fetched favorite pets: ${favoritePets.length}');
      favoritePets.forEach((pet) {
        print('Pet: ${pet.toJson()}');
      });
    } catch (e) {
      print('Error fetching favorite pets: $e');
    }
  }

  Future<void> removePet(FavoriteAnimal favorite) async {
    try {
      if (favorite.favoriteAnimalId != null) {
        await _favoriteAnimalApi
            .deleteFavoriteAnimal(favorite.favoriteAnimalId!);
        favoritePets.remove(favorite);
      } else {
        print('Error: favoriteAnimalId is null');
      }
    } catch (e) {
      print('Error removing favorite pet: $e');
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
