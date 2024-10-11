import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/favorite_pets_model.dart';
import '../../../constants/app_url.dart';
import '../services/api_service.dart';

class FavoriteAnimalApi {
  final ApiService _apiService = ApiService();

  Future<List<FavoriteAnimal>> getFavoriteAnimals() async {
    try {
      final response = await _apiService.get(AppUrl.favoriteAnimals);
      print('Raw API Response: ${response.data}');
      final List<FavoriteAnimal> favorites =
          (response.data as List).map((json) {
        print('Processing JSON: $json');
        return FavoriteAnimal.fromJson(json);
      }).toList();
      return favorites;
    } catch (e) {
      print('Error in getFavoriteAnimals: $e');
      rethrow;
    }
  }

  Future<AdoptionPost?> getAdoptionPostById(int id) async {
    try {
      final response = await _apiService.get('${AppUrl.adoptionPosts}/$id');
      return AdoptionPost.fromJson(response.data);
    } catch (e) {
      print('Error in getAdoptionPostById: $e');
      return null;
    }
  }

  Future<void> createFavoriteAnimal(FavoriteAnimal favoriteAnimal) async {
    try {
      await _apiService.post(AppUrl.favoriteAnimals,
          data: favoriteAnimal.toJson());
    } catch (e) {
      print('Error in createFavoriteAnimal: $e');
      rethrow;
    }
  }

  Future<void> deleteFavoriteAnimal(int id) async {
    try {
      await _apiService.delete('${AppUrl.favoriteAnimals}/$id');
    } catch (e) {
      print('Error in deleteFavoriteAnimal: $e');
      rethrow;
    }
  }
}
