import 'dart:io';
import 'package:dio/dio.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/login_model.dart';
import 'package:newlife_app/app/data/models/register_model.dart';
import 'package:newlife_app/app/data/models/user_profile_model.dart';
import 'package:newlife_app/app/data/models/user_update_dto.dart';
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
  Future<UserProfileModel> getUserProfile(int userId) async {
    try {
      final response = await _apiService.get(
        '${AppUrl.user}/$userId',
        options: Options(
          responseType: ResponseType.json,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserProfileModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to get user details: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      rethrow;
    }
  }

  Future<UserProfileModel> getUserDetaileForAdoption(int userId) async {
    try {
      final response = await _apiService.get(
        '${AppUrl.user}/getUserDetailsForAdoption/$userId',
        options: Options(
          responseType: ResponseType.json,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserProfileModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to get user details: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      print('Dio error in getUserDetaileForAdoption: ${e.message}');
      print('Response: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Error in getUserDetaileForAdoption: $e');
      rethrow;
    }
  }

// Update User
  Future<void> updateUser(int userId, UserUpdateDto userUpdateDto) async {
    try {
      await _apiService.patch(
        '${AppUrl.user}/UpdateUser/$userId',
        data: userUpdateDto.toJson(),
        options: Options(
          contentType: 'application/json',
        ),
      );
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }
}
