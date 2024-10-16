import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/notification_adoption_request_model.dart';
import 'package:newlife_app/app/data/network/api/notification_adoption_request_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';

class NotificationController extends GetxController {
  NotificationAdoptionRequestApi notificationAdoptionRequestApi =
      NotificationAdoptionRequestApi();
  RxList<NotificationAdoptionRequest> notificationRequests =
      <NotificationAdoptionRequest>[].obs;

  // ดึงข้อมูลการแจ้งเตือนสำหรับเจ้าของโพสต์
  Future<void> getPostOwnerNotifications() async {
    try {
      final userId =
          UserStorageService.getUserId(); // ดึง userId จาก UserStorageService
      print("User ID: $userId"); // ตรวจสอบว่า userId ไม่เป็น null หรือผิดพลาด

      if (userId != null) {
        List<NotificationAdoptionRequest> fetchedNotifications =
            await notificationAdoptionRequestApi
                .getPostOwnerNotifications(userId);

        print(
            "Fetched Notifications: ${fetchedNotifications.length}"); // ตรวจสอบจำนวนข้อมูลที่ได้รับ

        notificationRequests.value = fetchedNotifications;
      } else {
        Get.snackbar('Error', 'ไม่สามารถดึงข้อมูลผู้ใช้ได้');
      }
    } catch (e) {
      print('Error fetching post owner notifications: $e');
    }
  }

  // ดึงข้อมูลการแจ้งเตือนสำหรับผู้ขอรับเลี้ยง
  Future<void> getRequesterNotifications() async {
    try {
      final userId =
          UserStorageService.getUserId(); // ดึง userId จาก UserStorageService
      if (userId != null) {
        List<NotificationAdoptionRequest> fetchedNotifications =
            await notificationAdoptionRequestApi
                .getRequesterNotifications(userId);
        notificationRequests.value = fetchedNotifications;
      } else {
        Get.snackbar('Error', 'ไม่สามารถดึงข้อมูลผู้ใช้ได้');
      }
    } catch (e) {
      print('Error fetching requester notifications: $e');
    }
  }

  // ฟังก์ชันสำหรับการอนุมัติคำขอ
  Future<void> approveRequest(int notiAdopReqId) async {
    try {
      await notificationAdoptionRequestApi
          .approveAdoptionRequest(notiAdopReqId);
      Get.snackbar('สำเร็จ', 'คำขอรับเลี้ยงได้รับการอนุมัติแล้ว');
    } catch (e) {
      print('Error approving request: $e');
      Get.snackbar('Error', 'ไม่สามารถอนุมัติคำขอได้');
    }
  }

  // ฟังก์ชันสำหรับการปฏิเสธคำขอ
  Future<void> denyRequest(int notiAdopReqId) async {
    try {
      await notificationAdoptionRequestApi.denyAdoptionRequest(notiAdopReqId);
      Get.snackbar('สำเร็จ', 'คำขอรับเลี้ยงถูกปฏิเสธแล้ว');
    } catch (e) {
      print('Error denying request: $e');
      Get.snackbar('Error', 'ไม่สามารถปฏิเสธคำขอได้');
    }
  }
}
