import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newlife_app/app/data/models/breed_model.dart';
import 'package:newlife_app/app/data/models/register_model.dart';
import 'package:newlife_app/app/data/network/api/breed_api.dart';
import 'package:newlife_app/app/data/network/api/user_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';

class RegisterController extends GetxController {
  final UserApi _userApi = UserApi();
  final BreedApi breedApi = BreedApi();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final telController = TextEditingController();
  final genderController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final careerController = TextEditingController();
  final numOfFamMembersController = TextEditingController();
  final sizeOfResidenceController = TextEditingController();
  final typeOfResidenceController = TextEditingController();
  final freeTimePerDayController = TextEditingController();
  final monthlyIncomeController = TextEditingController();
  var isHaveExperience = false.obs;
  final reasonForAdoptionController = TextEditingController();

  RxList<int> selectedBreedIds = <int>[].obs;
  RxList<Breed> allBreeds = <Breed>[].obs;

  final isLoading = false.obs;
  var profilePic = Rxn<File>();

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profilePic.value = File(pickedFile.path);
    }
  }

  Future<void> register() async {
    try {
      isLoading.value = true;

      final registerModel = RegisterModel(
        email: emailController.text.trim(),
        password: passwordController.text,
        name: nameController.text,
        lastName: lastNameController.text,
        tel: telController.text,
        gender: genderController.text,
        age: int.tryParse(ageController.text) ?? 0,
        address: addressController.text,
        career: careerController.text,
        numOfFamMembers: int.tryParse(numOfFamMembersController.text),
        sizeOfResidence: sizeOfResidenceController.text,
        typeOfResidence: typeOfResidenceController.text,
        freeTimePerDay: int.tryParse(freeTimePerDayController.text),
        monthlyIncome: int.tryParse(monthlyIncomeController.text),
        isHaveExperience: isHaveExperience.value,
        interestedBreedIds: selectedBreedIds,
      );

      final response = await _userApi.register(registerModel, profilePic.value);

      UserStorageService.saveUserData(
        userId: response.userId,
        name: response.name,
        email: response.email,
        profilePic: response.profilePic ?? '',
        token: response.token,
        interestedBreedIds: selectedBreedIds,
      );

      Get.snackbar('Success', 'Registration successful');
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error in registration: $e');
      Get.snackbar('Error', 'Registration failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBreeds() async {
    try {
      allBreeds.value = await breedApi.getAllBreed();
    } catch (e) {
      print('Error fetching breeds: $e');
    }
  }

  void setSelectedBreeds(List<int> breedIds) {
    selectedBreedIds.value = breedIds;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    telController.dispose();
    genderController.dispose();
    ageController.dispose();
    addressController.dispose();
    careerController.dispose();
    numOfFamMembersController.dispose();
    sizeOfResidenceController.dispose();
    typeOfResidenceController.dispose();
    freeTimePerDayController.dispose();
    super.onClose();
  }
}
