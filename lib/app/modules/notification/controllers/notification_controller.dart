import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/notification_adoption_request_model.dart';
import 'package:newlife_app/app/data/network/api/notification_adoption_request_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';

class NotificationController extends GetxController {
  NotificationAdoptionRequestApi notificationAdoptionRequestApi =
      NotificationAdoptionRequestApi();
  RxList<NotificationAdoptionRequest> notificationRequests =
      <NotificationAdoptionRequest>[].obs;

  Future<void> getPostOwnerNotifications() async {
    try {
      final userId = UserStorageService.getUserId();
      if (userId != null) {
        List<NotificationAdoptionRequest> fetchedNotifications =
            await notificationAdoptionRequestApi
                .getPostOwnerNotifications(userId);
        notificationRequests.value = fetchedNotifications;
      } else {
        Get.snackbar('Error', 'ไม่สามารถดึงข้อมูลผู้ใช้ได้');
      }
    } catch (e) {
      print('Error fetching post owner notifications: $e');
    }
  }

  Future<void> getRequesterNotifications() async {
    try {
      final userId = UserStorageService.getUserId();
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

  Future<dynamic> fetchAdoptionRequestDetails(int requestId) async {
    try {
      final requestDetails = await notificationAdoptionRequestApi
          .fetchAdoptionRequestDetails(requestId);
      return requestDetails;
    } catch (e) {
      print('Error fetching adoption request details: $e');
      rethrow;
    }
  }

  Future<void> approveRequest(int requestId) async {
    try {
      await notificationAdoptionRequestApi.approveAdoptionRequest(requestId);
      Get.snackbar('สำเร็จ', 'คำขอรับเลี้ยงได้รับการอนุมัติแล้ว');
    } catch (e) {
      print('Error approving request: $e');
      Get.snackbar('Error', 'ไม่สามารถอนุมัติคำขอได้');
    }
  }

  Future<void> denyRequest(int requestId) async {
    try {
      await notificationAdoptionRequestApi.denyAdoptionRequest(requestId);
      Get.snackbar('สำเร็จ', 'คำขอรับเลี้ยงถูกปฏิเสธแล้ว');
    } catch (e) {
      print('Error denying request: $e');
      Get.snackbar('Error', 'ไม่สามารถปฏิเสธคำขอได้');
    }
  }
}
