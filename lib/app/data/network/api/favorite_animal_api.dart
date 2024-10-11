import 'package:dio/dio.dart';
import 'package:newlife_app/app/data/models/favorite_pets_model.dart';
import '../../../constants/app_url.dart';
import '../services/api_service.dart';

class FavoriteAnimalApi {
  final ApiService _apiService = ApiService();
  Future<List<FavoriteAnimal>> getFavoriteAnimals({int? userId}) async {
    try {
      final response = await _apiService.get(
        AppUrl.favoriteAnimals,
        queryParameters:
            userId != null ? {'userId': userId} : null, // ส่ง userId ไปใน query
      );
      print(response.data); // เพิ่มเพื่อดูข้อมูลที่ได้จาก API
      return (response.data as List)
          .map((json) => FavoriteAnimal.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<FavoriteAnimal> getFavoriteAnimalById(int id) async {
    try {
      final response = await _apiService.get('${AppUrl.favoriteAnimals}/$id');
      return FavoriteAnimal.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createFavoriteAnimal(FavoriteAnimal favoriteAnimal) async {
    try {
      await _apiService.post(AppUrl.favoriteAnimals,
          data: favoriteAnimal.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFavoriteAnimal(int id) async {
    try {
      await _apiService.delete('${AppUrl.favoriteAnimals}/$id');
    } catch (e) {
      rethrow;
    }
  }
}
