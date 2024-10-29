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
  final isHaveExperienceEditable = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      isLoading.value = true;
      final userDetails = await userApi.getUserProfile(userId);
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

        // แสดง Dialog ยืนยันการแก้ไขข้อมูล
        final confirm = await Get.dialog<bool>(
          AlertDialog(
            backgroundColor: const Color.fromARGB(255, 226, 184, 31),
            title: Center(child: Text('ยืนยันข้อมูล')),
            content: Text('คุณต้องการยืนยันข้อมูลการอุปการะใช่หรือไม่?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: TextButton(
                      child:
                          Text('ยกเลิก', style: TextStyle(color: Colors.black)),
                      onPressed: () => Get.back(result: false),
                    ),
                  ),
                  Container(
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: TextButton(
                      child:
                          Text('ยืนยัน', style: TextStyle(color: Colors.black)),
                      onPressed: () => Get.back(result: true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

        if (confirm == true) {
          await submitAdoptionRequest();
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

  Future<void> submitAdoptionRequest() async {
    try {
      // สร้างคำขออุปการะ
      final requestDto = AdoptionRequestDto(
        userId: userId,
        adoptionPostId: postId,
        reasonForAdoption: reasonForAdoption.value,
        updateUserInfo: true,
        userUpdate: userUpdateDto.value,
      );

      await adoptionRequestApi.createAdoptionRequest(requestDto);

      // แสดง Dialog แจ้งสถานะการอุปการะ
      await Get.dialog(
        AlertDialog(
          backgroundColor: const Color.fromARGB(255, 226, 184, 31),
          title: Center(child: Text('แจ้งสถานะการอุปการะ')),
          content: Text(
            'คุณได้ทำการอุปการะน้อง $postName สำเร็จแล้ว\nโปรดรอการอนุมัติจากเจ้าของโพสต์',
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: Container(
                width: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: TextButton(
                  child: Text('ตกลง', style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Get.until((route) => route.isFirst); // กลับไปหน้า Home
                  },
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      Get.snackbar('Error', 'ไม่สามารถส่งคำขออุปการะได้');
    }
  }
}
