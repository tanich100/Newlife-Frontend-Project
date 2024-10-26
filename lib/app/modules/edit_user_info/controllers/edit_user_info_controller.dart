import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_request_dto.dart';
import 'package:newlife_app/app/data/models/user_update_dto.dart';
import 'package:newlife_app/app/data/network/api/adoption_request_post.dart';
import 'package:newlife_app/app/data/network/api/user_api.dart';
import 'package:newlife_app/app/modules/petsDetail/views/confirm_dialog.dart';

class EditUserInfoController extends GetxController {
  final UserApi userApi = UserApi();
  final AdoptionRequestApi adoptionRequestApi = AdoptionRequestApi();

  final formKey = GlobalKey<FormState>();
  final userId = Get.arguments['userId'];
  final postId = Get.arguments['postId'];
  final postName = Get.arguments['postName'];

  final reasonForAdoption = ''.obs;
  var userUpdateDto = UserUpdateDto().obs;
  final isLoading = true.obs;

  // สถานะการเปิด/ปิดการแก้ไขของฟิลด์แต่ละฟิลด์
  final isNameEditable = false.obs;
  final isLastNameEditable = false.obs;
  final isTelEditable = false.obs;
  final isGenderEditable = false.obs;
  final isAgeEditable = false.obs;
  final isAddressEditable = false.obs;
  final isCareerEditable = false.obs;
  final isFamMembersEditable = false.obs;
  final isSizeOfResidenceEditable = false.obs;
  final isTypeOfResidenceEditable = false.obs;
  final isFreeTimeEditable = false.obs;
  final isMonthlyIncomeEditable = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      isLoading.value = true;
      final userDetails = await userApi.getUserDetaileForAdoption(userId);
      if (userDetails != null) {
        userUpdateDto.value = userDetails.toUpdateDto();
      }
    } catch (e) {
      print('Error in fetchUserDetails: $e');
      Get.snackbar('Error', 'ไม่สามารถโหลดข้อมูลผู้ใช้ได้');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUserAndSubmit() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState?.save();

        if (userUpdateDto.value != null) {
          print('Updating user with data: ${userUpdateDto.value!.toJson()}');
          await userApi.updateUser(userId, userUpdateDto.value!);

          // อัพเดทข้อมูลสำเร็จ
          Get.snackbar(
            'สำเร็จ',
            'อัพเดทข้อมูลเรียบร้อยแล้ว',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // แสดง ConfirmDialog หลังจากอัปเดตข้อมูลเสร็จ
          _showConfirmDialog();
        } else {
          Get.snackbar('Error', 'ไม่พบข้อมูลผู้ใช้สำหรับอัพเดท');
        }
      }
    } catch (e) {
      print('Error in updateUserAndSubmit: $e');
      Get.snackbar(
        'Error',
        'ไม่สามารถอัพเดทข้อมูลได้: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _showConfirmDialog() async {
    final result = await Get.dialog<bool>(
      ConfirmDialogView(petName: postName), // นำชื่อโพสต์มาแสดงใน Dialog
      barrierDismissible: false,
    );

    if (result == true) {
      submitAdoptionRequest(); // เรียกฟังก์ชันเพื่อส่งคำขออุปการะ
    }
  }

  void submitAdoptionRequest() async {
    try {
      final requestDto = AdoptionRequestDto(
        userId: userId,
        adoptionPostId: postId,
        reasonForAdoption: reasonForAdoption.value, // ข้อมูลเหตุผลในการอุปการะ
        updateUserInfo: true, // บอกให้ฝั่ง Backend รู้ว่ามีการอัปเดตข้อมูล
        userUpdate: userUpdateDto.value, // ส่งข้อมูลที่อัปเดตไปพร้อมกับ request
      );

      await adoptionRequestApi.createAdoptionRequest(requestDto);

      // แจ้งว่าคำขออุปการะสำเร็จ
      Get.snackbar('สำเร็จ', 'ส่งคำขออุปการะเรียบร้อยแล้ว');
      Get.back(); // กลับไปหน้าก่อนหน้า
    } catch (e) {
      Get.snackbar('Error', 'ไม่สามารถส่งคำขออุปการะได้');
    }
  }
}
