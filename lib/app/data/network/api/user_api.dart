import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/login_model.dart';
import 'package:newlife_app/app/data/models/register_model.dart';
import 'package:newlife_app/app/data/models/user_profile_model.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';

class UserApi {
  final ApiService _apiService = ApiService();

// Register
  Future<LoginResponseModel> register(
      RegisterModel registerModel, File? profilePicFile) async {
    try {
      FormData formData = FormData.fromMap(registerModel.toJson());

      if (profilePicFile != null) {
        formData.files.add(MapEntry(
          'ProfilePic',
          await MultipartFile.fromFile(profilePicFile.path,
              filename: 'profile_pic.jpg'),
        ));
      }

      // ส่งข้อมูลไปยัง API
      final response =
          await _apiService.post('${AppUrl.user}/register', data: formData);

      // ใช้ LoginResponseModel ในการตอบกลับหลังจากการลงทะเบียนสำเร็จ
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      print('Error in register: $e');
      rethrow;
    }
  }

// Login
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        '${AppUrl.user}/login',
        data: {
          'Email': email,
          'Password': password,
        },
      );
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      print('Error in login: $e');
      rethrow;
    }
  }

  // User Profile get by userId
  Future<LoginResponseModel> getUserProfile(int userId) async {
    try {
      final response = await _apiService.get('${AppUrl.user}/$userId');
      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load user profile');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      rethrow;
    }
  }
}
