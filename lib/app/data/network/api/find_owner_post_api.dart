import 'package:dio/dio.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';
import '../../../constants/app_url.dart';
import '../../models/find_owner_post_model.dart';

class FindOwnerPostApi {
  final ApiService _apiService = ApiService();

  Future<List<FindOwnerPost>> getPosts() async {
    try {
      final response = await _apiService.get(AppUrl.findOwnerPosts);
      return (response.data as List)
          .map((json) => FindOwnerPost.fromJson(json))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<FindOwnerPost> getPost(int id) async {
    try {
      final response = await _apiService.get('${AppUrl.findOwnerPosts}/$id');
      return FindOwnerPost.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<FindOwnerPost> createPost(FindOwnerPost post) async {
    try {
      final response = await _apiService
          .post('${AppUrl.findOwnerPosts}/SavePost', data: post.toJson());
      return FindOwnerPost.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<FindOwnerPost> updatePost(int id, FindOwnerPost post) async {
    try {
      final response = await _apiService.put('${AppUrl.findOwnerPosts}/$id',
          data: post.toJson());
      return FindOwnerPost.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await _apiService.delete('${AppUrl.findOwnerPosts}/$id');
    } catch (e) {
      rethrow;
    }
  }
}
