import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:path_provider/path_provider.dart';

class PostPetController extends GetxController {
  AdoptionPostApi adoptionPostApi = AdoptionPostApi();
  final adoptionPostList = <AdoptionPost>[].obs;
  final RxList<File> selectedImages = <File>[].obs;
  final int maxImages = 5;

  final ImagePicker _picker = ImagePicker();

  bool get isMaxImagesSelected => selectedImages.length >= maxImages;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // ฟังก์ชันเลือกภาพ
  Future<void> pickImages() async {
    if (isMaxImagesSelected) {
      Get.snackbar('ข้อจำกัด', 'ไม่สามารถเลือกภาพได้เกิน $maxImages รูป',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      final currentCount = selectedImages.length;
      final remainingSlots = maxImages - currentCount;

      final imagesToAdd =
          images.take(remainingSlots).map((xFile) => File(xFile.path)).toList();

      selectedImages.addAll(imagesToAdd);

      if (images.length > remainingSlots) {
        Get.snackbar(
          'ข้อจำกัด',
          'สามารถเพิ่มได้เพียง $remainingSlots รูปเท่านั้น จาก ${images.length} รูปที่เลือก',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }

  // ฟังก์ชันลบภาพ
  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> getNewPet() async {
    adoptionPostList.value = [];
    adoptionPostList.value = await adoptionPostApi.getNewPet();
  }

  void updateSelectedImages(List<File> images) {
    // ตรวจสอบจำนวนรูปภาพก่อนที่จะอัปเดต
    if (selectedImages.length + images.length <= maxImages) {
      selectedImages.assignAll([...selectedImages, ...images]);
    } else {
      final remainingSlots = maxImages - selectedImages.length;
      Get.snackbar(
        'ข้อจำกัด',
        'สามารถเพิ่มได้เพียง $remainingSlots รูปเท่านั้น',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> uploadImages() async {
    for (var image in selectedImages) {
      // Simulating upload process
      await Future.delayed(Duration(seconds: 1));
      print('Uploading image: ${image.path}');
    }
    print('All images uploaded successfully');
    // After successful upload, you might want to clear the selected images
    selectedImages.clear();
  }

  Future<void> createAdoptionPost(AdoptionPost newPost) async {
    await uploadImages(); // Upload images first
    // Then create the post with image URLs
    print('Creating new adoption post: ${newPost.toString()}');
    // After successful creation, you might want to refresh the list
    await getNewPet();
  }

  // ฟังก์ชันบันทึกภาพ
  Future<void> saveImages() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      for (var image in selectedImages) {
        final String fileName =
            DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
        final File savedImage = await image.copy('${directory.path}/$fileName');
        print('Saved image: ${savedImage.path}');
      }
      Get.snackbar(
        'สำเร็จ',
        'บันทึกรูปภาพเรียบร้อยแล้ว',
        snackPosition: SnackPosition.BOTTOM,
      );
      selectedImages.clear(); // ล้างรายการหลังจากบันทึกเสร็จแล้ว
    } catch (e) {
      print('Error saving images: $e');
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถบันทึกรูปภาพได้',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void increment() => count.value++;
}
