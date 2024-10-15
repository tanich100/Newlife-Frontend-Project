import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/data/network/api/breed_api.dart';
import 'package:newlife_app/app/data/network/api/find_owner_post_api.dart';
import 'package:newlife_app/app/data/network/api/user_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';
import 'package:newlife_app/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;

  final UserApi _userApi = UserApi();
  final AdoptionPostApi _adoptionPostApi = AdoptionPostApi();
  final FindOwnerPostApi _findOwnerPostApi = FindOwnerPostApi();
  final BreedApi _breedApi = BreedApi();

  RxString userName = ''.obs;
  RxString profileImage = ''.obs;
  RxList<dynamic> userPosts = <dynamic>[].obs;

  final Rx<dynamic> selectedPost = Rx<dynamic>(null);
  final images = <String>[].obs;
  final currentImageIndex = 0.obs;
  final animalType = ''.obs;
  final breedName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
    fetchUserPosts();
  }

  void fetchUserProfile() {
    try {
      userName.value = UserStorageService.getUserName() ?? '';
      profileImage.value = UserStorageService.getProfilePic() ?? '';
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  Future<void> fetchUserPosts() async {
    isLoading.value = true;
    try {
      int? userId = UserStorageService.getUserId();

      if (userId == null) {
        throw Exception('User ID not found in storage');
      }

      List<AdoptionPost> adoptionPosts = await _adoptionPostApi.getPosts();
      List<FindOwnerPost> findOwnerPosts = await _findOwnerPostApi.getPosts();

      // ดึงโพสต์ของ CurrentUser
      userPosts.value = [
        ...adoptionPosts.where((post) => post.userId == userId),
        ...findOwnerPosts.where((post) => post.userId == userId)
      ];

      // ตรวจสอบและเรียงลำดับตาม createAt โดยตรวจสอบ null ก่อน
      userPosts.sort((a, b) {
        final dateA = a.createAt ?? DateTime.now();
        final dateB = b.createAt ?? DateTime.now();
        return dateB.compareTo(dateA);
      });
    } catch (e) {
      print('Error fetching user posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> selectPost(dynamic post) async {
    selectedPost.value = post;
    await fetchPostDetails(post);
    updateImages();

    // เพิ่มการอัปเดต animalType และ breedName
    if (post is AdoptionPost || post is FindOwnerPost) {
      await fetchBreedInfo(post.breedId);
    }
  }

  Future<void> fetchPostDetails(dynamic post) async {
    try {
      if (post is AdoptionPost) {
        final fetchedPost =
            await _adoptionPostApi.getPost(post.adoptionPostId!);
        selectedPost.value = fetchedPost;
        await fetchBreedInfo(fetchedPost.breedId);
      } else if (post is FindOwnerPost) {
        final fetchedPost =
            await _findOwnerPostApi.getPost(post.findOwnerPostId!);
        selectedPost.value = fetchedPost;
        await fetchBreedInfo(fetchedPost.breedId);
      }
    } catch (e) {
      print('Error fetching post details: $e');
      Get.snackbar(
          'Error', 'ไม่สามารถโหลดข้อมูลสัตว์เลี้ยงได้ กรุณาลองใหม่อีกครั้ง');
    }
  }

  Future<void> fetchBreedInfo(int? breedId) async {
    if (breedId == null) {
      animalType.value = 'ไม่ทราบ';
      breedName.value = 'ไม่ทราบสายพันธุ์';
      return;
    }

    try {
      final breed = await _breedApi.getBreed(breedId);
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
    if (selectedPost.value is AdoptionPost) {
      AdoptionPost post = selectedPost.value;
      images.addAll([
        post.image1,
        post.image2,
        post.image3,
        post.image4,
        post.image5,
        post.image6,
        post.image7,
        post.image8,
        post.image9,
        post.image10,
      ].where((image) => image != null).cast<String>());
    } else if (selectedPost.value is FindOwnerPost) {
      FindOwnerPost post = selectedPost.value;
      images.addAll([
        post.image1,
        post.image2,
        post.image3,
        post.image4,
        post.image5,
        post.image6,
        post.image7,
        post.image8,
        post.image9,
        post.image10,
      ].where((image) => image != null && image.isNotEmpty).cast<String>());
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

  void logout() {
    UserStorageService.clearUserData();
    Get.offAllNamed(Routes.LOGIN);
  }
}
