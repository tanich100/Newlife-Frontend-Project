import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/favorite_pets_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/data/network/api/breed_api.dart';
import 'package:newlife_app/app/data/network/api/favorite_animal_api.dart';
import 'package:newlife_app/app/data/network/api/find_owner_post_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';

class PetsDetailController extends GetxController {
  final AdoptionPostApi adoptionPostApi = AdoptionPostApi();
  final FindOwnerPostApi findOwnerPostApi = FindOwnerPostApi();
  final FavoriteAnimalApi favoriteAnimalApi = FavoriteAnimalApi();
  final BreedApi breedApi = BreedApi();

  final isFavorite = false.obs;
  final currentImageIndex = 0.obs;
  final images = <String>[].obs;
  final Rx<dynamic> post = Rx<dynamic>(null);

  final animalType = ''.obs;
  final breedName = ''.obs;

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

  void sendAdoptionRequest() {
    // Implement the logic for sending an adoption request
    print('Adoption request sent for ${post.value.name}');
    Get.snackbar(
        'สำเร็จ', 'คุณได้ยืนยันการอุปการะน้อง ${post.value.name} แล้ว');
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
