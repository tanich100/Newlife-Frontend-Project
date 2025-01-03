import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newlife_app/app/data/network/api/user_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';
import 'package:newlife_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final UserApi _userApi = UserApi();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final GetStorage storage = GetStorage();

  Future<void> login() async {
    try {
      isLoading.value = true;
      final response = await _userApi.login(
        emailController.text,
        passwordController.text,
      );

      UserStorageService.saveUserData(
        userId: response.userId,
        name: response.name,
        email: response.email,
        profilePic: response.profilePic ?? '',
        token: response.token,
        interestedBreedIds: response.interestedBreedIds,
      );

      print('Logged in with userId: ${response.userId}');
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar('Error', 'Login failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
