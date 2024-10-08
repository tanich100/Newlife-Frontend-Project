import 'package:dio/dio.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';
import '../../../constants/app_url.dart';
import '../../models/adoption_post_model.dart';

class AdoptionPostApi {
  final ApiService _apiService = ApiService();

  Future<List<AdoptionPost>> getPosts() async {
    try {
      final response = await _apiService.get(AppUrl.adoptionPosts);
      return (response.data as List)
          .map((json) => AdoptionPost.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<AdoptionPost> getPost(int id) async {
    try {
      final response = await _apiService.get('${AppUrl.adoptionPosts}/$id');
      return AdoptionPost.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<AdoptionPost>> getNewPet() async {
    try {
      final response = await _apiService
          .get(AppUrl.baseUrl + AppUrl.adoptionPosts + '/GetNewPet');
      return (response.data as List)
          .map((json) => AdoptionPost.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<AdoptionPost> createPost(AdoptionPost post) async {
    try {
      final response = await _apiService
          .post('${AppUrl.adoptionPosts}/SavePost', data: post.toJson());
      if (response.statusCode == 200) {
        return AdoptionPost.fromJson(response.data);
      } else {
        throw Exception('Failed to create post: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error in createPost: $e');
      rethrow;
    }
  }

  Future<AdoptionPost> updatePost(int id, AdoptionPost post) async {
    try {
      final response = await _apiService.put('${AppUrl.adoptionPosts}/$id',
          data: post.toJson());
      return AdoptionPost.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _apiService.delete('${AppUrl.adoptionPosts}/$id');
    } catch (e) {
      rethrow;
    }
  }
}
