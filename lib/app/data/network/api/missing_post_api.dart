import 'package:dio/dio.dart';
import 'package:newlife_app/app/data/models/missing_post.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';
import '../../../constants/app_url.dart';


class MissingPostApi {
  final ApiService _apiService = ApiService();

  Future<List<MissingPost>> getPosts() async {
    try {
      final response = await _apiService.get(AppUrl.missingPosts);
      print('API Response: ${response.data}');

      List<MissingPost> posts = (response.data as List)
          .map((json) => MissingPost.fromJson(json))
          .toList();

      print('Parsed posts:');
      posts.forEach((post) {
        print('Post: ${post.toJson()}');
      });

      return posts;
    } catch (e) {
      print('Error in getPosts: $e');
      rethrow;
    }
  }

  Future<MissingPost> getPost(int id) async {
    try {
      final response = await _apiService
          .get('${AppUrl.missingPosts}/GetMissingPost/$id');
      print('Response data: ${response.data}');
      return MissingPost.fromJson(response.data);
    } catch (e) {
      print('Error in getPost: $e');
      rethrow;
    }
  }

  Future<List<MissingPost>> getDogPosts() async {
    try {
      final response = await _apiService.get('${AppUrl.missingPosts}/Dogs');
      List<MissingPost> posts = (response.data as List)
          .map((json) => MissingPost.fromJson(json))
          .toList();
      return posts;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MissingPost>> getCatPosts() async {
    try {
      final response = await _apiService.get('${AppUrl.missingPosts}/Cats');
      List<MissingPost> posts = (response.data as List)
          .map((json) => MissingPost.fromJson(json))
          .toList();
      return posts;
    } catch (e) {
      rethrow;
    }
  }

  Future<MissingPost> createPost(MissingPost post) async {
    try {
      final response = await _apiService
          .post('${AppUrl.missingPosts}/SavePost', data: post.toJson());
      return MissingPost.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<MissingPost> updatePost(int id, MissingPost post) async {
    try {
      final response = await _apiService.put('${AppUrl.missingPosts}/$id',
          data: post.toJson());
      return MissingPost.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _apiService.delete('${AppUrl.missingPosts}/$id');
    } catch (e) {
      rethrow;
    }
  }
}