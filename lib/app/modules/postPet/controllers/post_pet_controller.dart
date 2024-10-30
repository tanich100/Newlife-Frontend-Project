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

  // Future<void> createAdoptionPost(AdoptionPost post) async {
  //   try {
  //     // ปริ้นค่าของโพสต์ที่ถูกส่งมา
  //     print('Creating adoption post with the following details:');
  //     print('Name: ${post.name} (Type: ${post.name.runtimeType})');
  //     print('Age: ${post.age} (Type: ${post.age.runtimeType})');
  //     print('Sex: ${post.sex} (Type: ${post.sex.runtimeType})');
  //     print('Needs Attention: ${post.isNeedAttention} (Type: ${post.isNeedAttention.runtimeType})');
  //     print('Breed ID: ${post.breedId} (Type: ${post.breedId.runtimeType})');
  //     print('Province ID: ${post.provinceId} (Type: ${post.provinceId.runtimeType})');
  //     print('District ID: ${post.districtId} (Type: ${post.districtId.runtimeType})');
  //     print('Subdistrict ID: ${post.subdistrictId} (Type: ${post.subdistrictId.runtimeType})');
  //     print('Address Details: ${post.addressDetails} (Type: ${post.addressDetails.runtimeType})');
  //     print('Image File Names: ${post.imageFileNames} (Type: ${post.imageFileNames.runtimeType})');


  //     // สร้างโพสต์
  //     final createdPost = await _adoptionPostApi.createPost(post);
  //     if (createdPost.adoptionPostId == null) {
  //       throw Exception('ไม่สามารถสร้างโพสต์ได้: ไม่ได้รับ ID โพสต์');
  //     }

  //     // อัปโหลดรูปภาพ
  //     try {
  //       await uploadImages(createdPost.adoptionPostId!);
  //     } catch (uploadError) {
  //       // จัดการข้อผิดพลาดในการอัปโหลดรูปภาพโดยเฉพาะ
  //       Get.snackbar('คำเตือน',
  //           'บันทึกโพสต์สำเร็จ แต่ไม่สามารถอัปโหลดรูปภาพได้: $uploadError');
  //       // อาจพิจารณาลบโพสต์หรือทำการแก้ไขเพิ่มเติมตามความเหมาะสม
  //     }

  //     Get.snackbar('สำเร็จ', 'บันทึกข้อมูลและอัปโหลดรูปภาพเรียบร้อยแล้ว');

  //     // พิจารณาใช้ Get.offNamed แทน Get.offAllNamed หากไม่ต้องการปิดทุกหน้าจอ
  //     Get.offNamed('/profile', arguments: createdPost);
  //   } catch (e) {
  //     Get.snackbar('ผิดพลาด', 'ไม่สามารถบันทึกข้อมูลได้: $e');
  //     // พิจารณาเพิ่ม logging หรือการรายงานข้อผิดพลาดที่นี่
  //     // print('Error in createAdoptionPost: $e');
  //   }
  // }

  Future<void> createAdoptionPost(AdoptionPost post) async {
  try {
    // ปริ้นค่าของโพสต์ที่ถูกส่งมา
    print('Creating adoption post with the following details:');
    print('Name: ${post.name} (Type: ${post.name.runtimeType})');
    print('Age: ${post.age} (Type: ${post.age.runtimeType})');
    print('Sex: ${post.sex} (Type: ${post.sex.runtimeType})');
    print('Needs Attention: ${post.isNeedAttention} (Type: ${post.isNeedAttention.runtimeType})');
    print('Breed ID: ${post.breedId} (Type: ${post.breedId.runtimeType})');
    print('Province ID: ${post.provinceId} (Type: ${post.provinceId.runtimeType})');
    print('District ID: ${post.districtId} (Type: ${post.districtId.runtimeType})');
    print('Subdistrict ID: ${post.subdistrictId} (Type: ${post.subdistrictId.runtimeType})');
    print('Address Details: ${post.addressDetails} (Type: ${post.addressDetails.runtimeType})');
    print('Image File Names: ${post.imageFileNames} (Type: ${post.imageFileNames.runtimeType})');

    // สร้างโพสต์
    final createdPost = await _adoptionPostApi.createPost(post);
    if (createdPost.adoptionPostId == null) {
      throw Exception('ไม่สามารถสร้างโพสต์ได้: ไม่ได้รับ ID โพสต์');
    }

    // อัปโหลดรูปภาพ
    if (selectedImages.isNotEmpty) {
      try {
        await uploadImages(createdPost.adoptionPostId!);
      } catch (uploadError) {
        Get.snackbar('คำเตือน',
            'บันทึกโพสต์สำเร็จ แต่ไม่สามารถอัปโหลดรูปภาพได้: $uploadError');
      }
    }

    Get.snackbar('สำเร็จ', 'บันทึกข้อมูลและอัปโหลดรูปภาพเรียบร้อยแล้ว');
    Get.offNamed('/profile', arguments: createdPost);
    
  } catch (e) {
    Get.snackbar('ผิดพลาด', 'ไม่สามารถบันทึกข้อมูลได้: $e');
  }
}

//   Future<void> createAdoptionPost(AdoptionPost post) async {
//  try {
//    // 1. ตรวจสอบข้อมูลที่จำเป็น
//    if (post.name == null || post.name!.isEmpty) {
//      throw Exception('กรุณากรอกชื่อ');
//    }
//    if (post.sex == null || post.sex!.isEmpty) {
//      throw Exception('กรุณาเลือกเพศ');
//    }
//    if (post.breedId == null) {
//      throw Exception('กรุณาเลือกสายพันธุ์');
//    }
//    if (post.provinceId == null || post.districtId == null || post.subdistrictId == null) {
//      throw Exception('กรุณากรอกข้อมูลที่อยู่ให้ครบถ้วน');
//    }

//    // 2. Log ข้อมูลก่อนส่ง API
//    print('=== Creating Adoption Post ===');
//    print('Post Details:');
//    print('''
//    Name: ${post.name} (${post.name.runtimeType})
//    Age: ${post.age} (${post.age.runtimeType})
//    Sex: ${post.sex} (${post.sex.runtimeType})
//    Breed ID: ${post.breedId} (${post.breedId.runtimeType})
//    Need Special Care: ${post.isNeedAttention} (${post.isNeedAttention.runtimeType})
//    Province ID: ${post.provinceId} (${post.provinceId.runtimeType})
//    District ID: ${post.districtId} (${post.districtId.runtimeType})
//    Subdistrict ID: ${post.subdistrictId} (${post.subdistrictId.runtimeType})
//    Address: ${post.addressDetails} (${post.addressDetails.runtimeType})
//    Images: ${post.imageFileNames.length} files
//    ''');

//    // 3. เรียก API สร้างโพสต์
//    print('Calling API to create post...');
//    final createdPost = await _adoptionPostApi.createPost(post);
//    print('API Response: ${createdPost.toJson()}');

//    // 4. ตรวจสอบ response
//    if (createdPost.adoptionPostId == null) {
//      throw Exception('ไม่สามารถสร้างโพสต์ได้: ไม่ได้รับ ID โพสต์');
//    }

//    // 5. อัปโหลดรูปภาพ
//    if (selectedImages.isNotEmpty) {
//      print('Uploading ${selectedImages.length} images...');
//      try {
//        await uploadImages(createdPost.adoptionPostId!);
//        print('All images uploaded successfully');
//      } catch (uploadError) {
//        print('Error uploading images: $uploadError');
//        Get.snackbar(
//          'คำเตือน',
//          'บันทึกโพสต์สำเร็จ แต่ไม่สามารถอัปโหลดรูปภาพได้: $uploadError',
//          duration: Duration(seconds: 5)
//        );
//      }
//    }

//    print('=== Post Creation Completed ===');
//    Get.snackbar('สำเร็จ', 'บันทึกข้อมูลและอัปโหลดรูปภาพเรียบร้อยแล้ว');
//    Get.offNamed('/profile', arguments: createdPost);

//  } catch (e) { 
//    print('=== Error Creating Post ===');
//    print('Error type: ${e.runtimeType}');
//    print('Error details: $e');
   
//    Get.snackbar(
//      'ผิดพลาด',
//      'ไม่สามารถบันทึกข้อมูลได้: ${e.toString()}',
//      duration: Duration(seconds: 5)
//    );
//  }
// }

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

  Future<void> createPost(String postType, String description,
      String phoneNumber, String lineId, List<File> images) async {
    if (images.isEmpty) {
      // ใช้ images แทน selectedImages เพื่อเช็คว่ามีรูปภาพไหม
      Get.snackbar('ข้อผิดพลาด', 'กรุณาเพิ่มรูปภาพก่อนดำเนินการต่อ');
      return;
    }

    // ดึงชื่อไฟล์จาก List<File>
    List<String> imageFileNames =
        images.map((file) => file.path.split('/').last).toList();

    // สร้างโพสต์ข้อมูล
    AdoptionPost postData = AdoptionPost(
      postStatus: postType,
      description: description,
      tel: phoneNumber,
      imageFileNames: imageFileNames, // เก็บชื่อไฟล์ลงใน postData
    );

    // ปริ้นข้อมูลโพสต์
    // print('Creating new adoption post: ${postData.toString()}');
    // print('Post Type: $postType');
    // print('Description: $description');
    // print('Phone Number: $phoneNumber');
    // print('Line ID: $lineId');
    // print('Image File Names: $imageFileNames');
    
    // นำข้อมูลไปยังหน้าถัดไป
    Get.to(() => NewPostPageDetail(
          selectedPost: postData,
          selectedImages: images.toList(), // ส่ง images ไปยัง NewPostPageDetail
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
