import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';

import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/modules/postPet/views/new_post_detail_page.dart';
import 'package:path_provider/path_provider.dart';

import '../../../data/models/post_model.dart';

class PostPetController extends GetxController {
  AdoptionPostApi adoptionPostApi = AdoptionPostApi();
  final adoptionPostList = <AdoptionPost>[].obs;
  final RxList<File> selectedImages = <File>[].obs;
  final int maxImages = 5;
    Rx<String> selectedSex = ''.obs;

  final ImagePicker _picker = ImagePicker();

  final AdoptionPostApi _adoptionPostApi = AdoptionPostApi();

  bool get isMaxImagesSelected => selectedImages.length >= maxImages;

  

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getNewPet(); 

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Future<void> createAdoptionPost(AdoptionPost post) async {
  //   try {
  //     final createdPost = await _adoptionPostApi.createPost(post);
  //     Get.snackbar('สำเร็จ', 'บันทึกข้อมูลเรียบร้อยแล้ว');
  //     // Additional logic after successful creation
  //   } catch (e) {
  //     Get.snackbar('ผิดพลาด', 'ไม่สามารถบันทึกข้อมูลได้: $e');
  //   }
  // }

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

//  Future<void> uploadImages() async {
//   for (var image in selectedImages) {
//     // แทนที่จะอัปโหลดให้พิมพ์ชื่อไฟล์
//     print('Image selected for upload: ${image.path}');
    
//     // คุณสามารถจำลองการอัปโหลดโดยการหน่วงเวลา
//     await Future.delayed(Duration(seconds: 1));
//   }
//   print('All images processed successfully');
  
//   // หลังจากการประมวลผลเสร็จสิ้น คุณอาจต้องการล้างรายการภาพที่เลือก
//   selectedImages.clear();
// }

Future<void> createAdoptionPost(AdoptionPost post) async {
  try {
    final createdPost = await _adoptionPostApi.createPost(post);
    await uploadImages(createdPost.adoptionPostId!);
    Get.snackbar('สำเร็จ', 'บันทึกข้อมูลและอัปโหลดรูปภาพเรียบร้อยแล้ว');
    Get.offAllNamed('/profile', arguments: createdPost);
  } catch (e) {
    Get.snackbar('ผิดพลาด', 'ไม่สามารถบันทึกข้อมูลได้: $e');
  }
}

Future<void> uploadImages(int postId) async {
  try {
    for (var image in selectedImages) {
      await _adoptionPostApi.uploadImage(postId, image);
    }
    print('All images uploaded successfully');
    selectedImages.clear();
  } catch (e) {
    print('Error uploading images: $e');
    Get.snackbar('ข้อผิดพลาด', 'ไม่สามารถอัปโหลดรูปภาพได้: $e');
  }
}


  Future<void> createPost(String postType, String description, String phoneNumber, String lineId) async {
  if (selectedImages.isEmpty) {
    Get.snackbar('ข้อผิดพลาด', 'กรุณาเพิ่มรูปภาพก่อนดำเนินการต่อ');
    return;
  }

   AdoptionPost postData = AdoptionPost(
    postStatus: postType,
    description: description,
    tel: phoneNumber,
    // ไม่มีฟิลด์สำหรับ Line ID ใน AdoptionPost ดังนั้นเราจะรวมไว้ใน description
    // description: description + '\nLine ID: ' + lineId,
  );

  print('Creating new adoption post: ${postData.toString()}');

  Get.to(() => NewPostPageDetail(
    selectedPost: postData,
    selectedImages: selectedImages.toList(),
  ));
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
      // selectedImages.clear(); // ล้างรายการหลังจากบันทึกเสร็จแล้ว
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
