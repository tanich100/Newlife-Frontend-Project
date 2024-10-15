import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/favorite_pets_model.dart';
import '../../../constants/app_url.dart';
import '../services/api_service.dart';

class FavoriteAnimalApi {
  final ApiService _apiService = ApiService();

  // Future<List<FavoriteAnimal>> getFavoriteAnimals() async {
  //   try {
  //     final response = await _apiService.get(AppUrl.favoriteAnimals);
  //     return (response.data as List)
  //         .map((json) => FavoriteAnimal.fromJson(json))
  //         .toList();
  //   } catch (e) {
  //     print('Error in getFavoriteAnimals: $e');
  //     rethrow;
  //   }
  // }

  Future<AdoptionPost?> getAdoptionPostById(int postId) async {
    try {
      final response = await _apiService.get('${AppUrl.adoptionPosts}/$postId');
      return AdoptionPost.fromJson(response.data);
    } catch (e) {
      print('Error in getAdoptionPostById: $e');
      return null; // Return null if there's an error
    }
  }

  Future<List<FavoriteAnimal>> getUserFavorites(int userId) async {
    try {
      final response =
          await _apiService.get('${AppUrl.favoriteAnimals}/user/$userId');
      return (response.data as List)
          .map((json) => FavoriteAnimal.fromJson(json))
          .toList();
    } catch (e) {
      print('Error in getUserFavorites: $e');
      rethrow;
    }
  }

  Future<FavoriteAnimal> createFavorite(FavoriteAnimal favoriteAnimal) async {
    try {
      final response = await _apiService.post(AppUrl.favoriteAnimals,
          data: favoriteAnimal.toJson());
      return FavoriteAnimal.fromJson(response.data);
    } catch (e) {
      print('Error in createFavorite: $e');
      rethrow;
    }
  }

  Future<FavoriteAnimal> updateFavorite(
      int id, FavoriteAnimal favoriteAnimal) async {
    try {
      final response = await _apiService.put('${AppUrl.favoriteAnimals}/$id',
          data: favoriteAnimal.toJson());
      return FavoriteAnimal.fromJson(response.data);
    } catch (e) {
      print('Error in updateFavorite: $e');
      rethrow;
    }
  }

  Future<void> deleteFavorite(int id) async {
    try {
      await _apiService.delete('${AppUrl.favoriteAnimals}/$id');
    } catch (e) {
      print('Error in deleteFavorite: $e');
      rethrow;
    }
  }
}
