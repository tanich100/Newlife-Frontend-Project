import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';
import '../../../constants/app_url.dart';
import '../../models/adoption_post_model.dart';
import '../services/api_image_service.dart';

class AdoptionPostApi {
  final ApiService _apiService = ApiService();
  final ApiImageService _apiImageService = ApiImageService();

  Future<List<AdoptionPost>> getPosts() async {
    try {
      final response = await _apiService.get(AppUrl.adoptionPosts);
      print('API Response: ${response.data}');

      List<AdoptionPost> posts = (response.data as List)
          .map((json) => AdoptionPost.fromJson(json))
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

  Future<AdoptionPost> getPost(int id) async {
    try {
      final response =
          await _apiService.get('${AppUrl.adoptionPosts}/GetPost/$id');
      return AdoptionPost.fromJson(response.data);
    } catch (e) {
      print('Error in getPost: $e');
      rethrow;
    }
  }

  Future<List<int>> searchByImage(String petType, File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'petType': petType,
        'file': await MultipartFile.fromFile(
            imageFile.path), // Convert file to MultipartFile
      });
      final response = await _apiImageService.post('${AppUrl.searchByImage}',
          data: formData);
      return List<int>.from(response.data);
    } catch (e) {
      print('Error in getPost: $e');
      rethrow;
    }
  }

  // Future<List<int>> searchByText(String text) async {
  Future<List<int>> searchByText(String text) async {
    try {
      final response = await _apiImageService.get(
        '${AppUrl.searchByText + text}',
      );

      // Assuming response.data is already a List<dynamic>
      final List<dynamic> results = response.data;

      // Filter results with similarity > 0 and extract the postId values
      List<int> postIdList = results
          .where((result) => result['similarity'] > 0)
          .map<int>((result) => result['postId'])
          .toList();

      // Print the filtered postId list
      print("Id");
      print(postIdList);
      return postIdList;
      // Use the postIdList as needed
    } catch (e) {
      print('Error in getPost: $e');
      rethrow;
    }
  }

  // Future<List<AdoptionPost>> getUserPosts(int userId) async {
  //   try {
  //     final response =
  //         await _apiService.get('${AppUrl.adoptionPosts}/user/$userId');
  //     return (response.data as List)
  //         .map((json) => AdoptionPost.fromJson(json))
  //         .toList();
  //   } catch (e) {
  //     print('Error in getUserPosts: $e');
  //     rethrow;
  //   }
  // }

  Future<List<AdoptionPost>> getDogPosts() async {
    try {
      final response = await _apiService.get('${AppUrl.adoptionPosts}/Dogs');
      return (response.data as List)
          .map((json) => AdoptionPost.fromJson(json))
          .toList();
    } catch (e) {
      print('Error in getDogPosts: $e');
      rethrow;
    }
  }

  Future<List<AdoptionPost>> getCatPosts() async {
    try {
      final response = await _apiService.get('${AppUrl.adoptionPosts}/Cats');
      return (response.data as List)
          .map((json) => AdoptionPost.fromJson(json))
          .toList();
    } catch (e) {
      print('Error in getCatPosts: $e');
      rethrow;
    }
  }

  Future<List<AdoptionPost>> getSpecialCarePosts() async {
    try {
      final response =
          await _apiService.get('${AppUrl.adoptionPosts}/SpecialCare');
      return (response.data as List)
          .map((json) => AdoptionPost.fromJson(json))
          .toList();
    } catch (e) {
      print('Error in getSpecialCarePosts: $e');
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

  Future<List<AdoptionPost>> getRecommendedPosts(int userId) async {
    try {
      final response =
          await _apiService.get('${AppUrl.adoptionPosts}/recommended/$userId');
      return (response.data as List)
          .map((json) => AdoptionPost.fromJson(json))
          .toList();
    } catch (e) {
      print('Error in getRecommendedPosts: $e');
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
