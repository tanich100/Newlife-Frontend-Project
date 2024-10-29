import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/adoption_request_dto.dart';
import 'package:newlife_app/app/data/models/favorite_pets_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/data/models/user_update_dto.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/data/network/api/adoption_request_post.dart';
import 'package:newlife_app/app/data/network/api/breed_api.dart';
import 'package:newlife_app/app/data/network/api/favorite_animal_api.dart';
import 'package:newlife_app/app/data/network/api/find_owner_post_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';
import 'package:newlife_app/app/modules/petsDetail/views/confirm_dialog.dart';

class PetsDetailController extends GetxController {
  final AdoptionPostApi adoptionPostApi = AdoptionPostApi();
  final FindOwnerPostApi findOwnerPostApi = FindOwnerPostApi();
  final FavoriteAnimalApi favoriteAnimalApi = FavoriteAnimalApi();
  final AdoptionRequestApi adoptionRequestApi = AdoptionRequestApi();
  final BreedApi breedApi = BreedApi();

  final reasonForAdoption = ''.obs;
  var userUpdateDto = UserUpdateDto().obs;

  final isFavorite = false.obs;
  final currentImageIndex = 0.obs;
  final images = <String>[].obs;
  final Rx<dynamic> post = Rx<dynamic>(null);
  final animalType = ''.obs;
  final breedName = ''.obs;
  final isRequestButtonEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments != null && arguments['pet'] != null) {
      fetchPostDetails(arguments['pet']);
    }
  }

  void fetchPostDetails(dynamic pet) async {
    try {
      if (pet is AdoptionPost) {
        final fetchedPost = await adoptionPostApi.getPost(pet.adoptionPostId!);
        post.value = fetchedPost;
        await fetchBreedInfo(fetchedPost.breedId);
      } else if (pet is FindOwnerPost) {
        final fetchedPost =
            await findOwnerPostApi.getPost(pet.findOwnerPostId!);
        post.value = fetchedPost;
        await fetchBreedInfo(fetchedPost.breedId);
      }
      updateImages();
      checkFavoriteStatus();
    } catch (e) {
      print('Error fetching post details: $e');
      Get.snackbar(
          'Error', 'ไม่สามารถโหลดข้อมูลสัตว์เลี้ยงได้ กรุณาลองใหม่อีกครั้ง');
    }
  }

  void disableRequestButton() {
    isRequestButtonEnabled.value = false;
  }

  void enableRequestButton() {
    isRequestButtonEnabled.value = true;
  }

  void submitAdoptionRequest() async {
    try {
      disableRequestButton();
      final userId = UserStorageService.getUserId();
      if (userId == null) return;

      final requestDto = AdoptionRequestDto(
        userId: userId,
        adoptionPostId: post.value.adoptionPostId,
        reasonForAdoption: reasonForAdoption.value,
        updateUserInfo: true,
        userUpdate: userUpdateDto.value,
      );

      await adoptionRequestApi.createAdoptionRequest(requestDto);
      Get.snackbar('สำเร็จ', 'ส่งคำขออุปการะเรียบร้อยแล้ว');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'ไม่สามารถส่งคำขออุปการะได้');
    } finally {
      enableRequestButton();
    }
  }

  Future<bool> checkDuplicateRequest(int userId, int adoptionPostId) async {
    try {
      final response = await adoptionRequestApi.getUserAdoptionHistory(userId);
      return response
          .any((request) => request.adoptionPostId == adoptionPostId);
    } catch (e) {
      print('Error checking duplicate request: $e');
      return false;
    }
  }

  void goToEditUserInfoPage() async {
    try {
      final userId = UserStorageService.getUserId();
      if (userId == null) {
        Get.snackbar('Error', 'กรุณาเข้าสู่ระบบก่อน');
        return;
      }

      final hasDuplicateRequest =
          await checkDuplicateRequest(userId, post.value.adoptionPostId);
      if (hasDuplicateRequest) {
        Get.snackbar(
            'แจ้งเตือน', 'คุณได้ส่งคำขออุปการะสัตว์เลี้ยงตัวนี้ไปแล้ว');
        return;
      }

      // เปิดหน้าแก้ไขข้อมูล
      final result = await Get.toNamed('/edit-user-info', arguments: {
        'userId': userId,
        'postId': post.value.adoptionPostId,
        'postName': post.value.name,
      });

      // ถ้าบันทึกข้อมูลแล้วให้แสดง ConfirmDialog เพื่อยืนยันการอุปการะ
      if (result == true) {
        _showConfirmDialog();
      }
    } catch (e) {
      Get.snackbar('Error', 'เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
    }
  }

  void _showConfirmDialog() async {
    final result = await Get.dialog<bool>(
      ConfirmDialogView(petName: post.value.name ?? 'สัตว์เลี้ยง'),
      barrierDismissible: false,
    );

    if (result == true) {
      submitAdoptionRequest(); // ส่งคำขออุปการะ
    }
  }

  void checkFavoriteStatus() async {
    try {
      final userId = UserStorageService.getUserId();
      if (userId != null) {
        final favorites = await favoriteAnimalApi.getUserFavorites(userId);
        isFavorite.value = favorites.any(
            (favorite) => favorite.adoptionPostId == post.value.adoptionPostId);
      }
    } catch (e) {
      print('Error checking favorite status: $e');
    }
  }

  Future<void> fetchBreedInfo(int? breedId) async {
    if (breedId == null) {
      animalType.value = 'ไม่ทราบ';
      breedName.value = 'ไม่ทราบสายพันธุ์';
      return;
    }

    try {
      final breed = await breedApi.getBreed(breedId);
      animalType.value = breed.animalType;
      breedName.value = breed.breedName;
    } catch (e) {
      print('Error fetching breed info: $e');
      animalType.value = 'ไม่ทราบ';
      breedName.value = 'ไม่ทราบสายพันธุ์';
    }
  }

  void updateImages() {
    images.clear();
    if (post.value is AdoptionPost) {
      AdoptionPost adoptionPost = post.value;
      images.addAll([
        adoptionPost.image1,
        adoptionPost.image2,
        adoptionPost.image3,
        adoptionPost.image4,
        adoptionPost.image5,
        adoptionPost.image6,
        adoptionPost.image7,
        adoptionPost.image8,
        adoptionPost.image9,
        adoptionPost.image10,
      ].where((image) => image != null).cast<String>());
    } else if (post.value is FindOwnerPost) {
      FindOwnerPost findOwnerPost = post.value;
      images.addAll([
        findOwnerPost.image1,
        findOwnerPost.image2,
        findOwnerPost.image3,
        findOwnerPost.image4,
        findOwnerPost.image5,
        findOwnerPost.image6,
        findOwnerPost.image7,
        findOwnerPost.image8,
        findOwnerPost.image9,
        findOwnerPost.image10,
      ].where((image) => image != null && image.isNotEmpty).cast<String>());
    }
  }

  void toggleFavorite() async {
    try {
      final userId = UserStorageService.getUserId();
      if (userId == null) return;

      if (isFavorite.value) {
        await favoriteAnimalApi.deleteFavorite(post.value.adoptionPostId!);
        isFavorite.value = false;
      } else {
        final newFavorite = FavoriteAnimal(
          userId: userId,
          adoptionPostId: post.value.adoptionPostId,
          dateAdded: DateTime.now(),
        );
        await favoriteAnimalApi.createFavorite(newFavorite);
        isFavorite.value = true;
      }
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  void nextImage() {
    if (currentImageIndex.value < images.length - 1) {
      currentImageIndex.value++;
    }
  }

  void previousImage() {
    if (currentImageIndex.value > 0) {
      currentImageIndex.value--;
    }
  }
}
