import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/notification_adoption_request_model.dart';
import 'package:newlife_app/app/data/network/api/notification_adoption_request_api.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';
import 'package:newlife_app/app/modules/notification/views/notification_pet_details_view.dart';
import 'package:newlife_app/app/modules/notification/views/notification_view.dart';

class NotificationController extends GetxController {
  final NotificationAdoptionRequestApi _notificationApi =
      NotificationAdoptionRequestApi();
  RxList<NotificationAdoptionRequest> postOwnerNotifications =
      <NotificationAdoptionRequest>[].obs;
  RxList<NotificationAdoptionRequest> requesterNotifications =
      <NotificationAdoptionRequest>[].obs;
  RxInt currentTab = 0.obs;
  RxBool isLoading = false.obs;

  RxInt unreadNotificationCount = 0.obs;

  final Rx<NotificationAdoptionRequest?> selectedNotification =
      Rx<NotificationAdoptionRequest?>(null);

  @override
  void onInit() {
    super.onInit();
    initializeNotifications();
  }

  Future<void> showNotificationDetails(
      NotificationAdoptionRequest notification) async {
    try {
      print('Selected notification: ${notification.toJson()}');
      print('Adoption post data: ${notification.adoptionPost}');
      print('Post name: ${notification.postName}');
      print('Post image: ${notification.postImage}');

      if (notification.adoptionPost == null) {
        return;
      }

      selectedNotification.value = notification;
      Get.to(() => NotificationPetDetailsView());
    } catch (e) {
      print('Error showing notification details: $e');
    }
  }

  RxList<NotificationAdoptionRequest> get combinedNotifications =>
      RxList<NotificationAdoptionRequest>.from([
        ...postOwnerNotifications,
        ...requesterNotifications,
      ]..sort((a, b) => b.notiDate.compareTo(a.notiDate)));

  Future<void> _loadTabData(int index) async {
    try {
      switch (index) {
        case 0: // แท็บแจ้งเตือนรวม
          await Future.wait([
            getPostOwnerNotifications(),
            getRequesterNotifications(),
          ]);
          break;
        case 1: // คำขอรับเลี้ยง
          await getPostOwnerNotifications();
          break;
        case 2: // การขอรับเลี้ยง
          await getRequesterNotifications();
          break;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getPostOwnerNotifications() async {
    try {
      final userId = UserStorageService.getUserId();
      if (userId != null) {
        isLoading.value = true;
        final notifications =
            await _notificationApi.getPostOwnerNotifications(userId);
        postOwnerNotifications.value = notifications;
        updateUnreadCount();
      }
    } catch (e) {
      print('Error fetching post owner notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getRequesterNotifications() async {
    try {
      final userId = UserStorageService.getUserId();
      if (userId != null) {
        isLoading.value = true;
        final notifications =
            await _notificationApi.getRequesterNotifications(userId);
        // กรองเฉพาะแจ้งเตือนที่ยังไม่ได้อ่าน
        requesterNotifications.value =
            notifications.where((n) => !n.isRead).toList();
        updateUnreadCount();
      }
    } catch (e) {
      print('Error fetching requester notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markNotificationAsRead(
      NotificationAdoptionRequest notification) async {
    try {
      if (!notification.isRead) {
        await _notificationApi.markAsRead(notification.notiAdopReqId);

        // อัพเดทข้อมูลตาม tab ปัจจุบัน
        if (currentTab.value == 1) {
          await getPostOwnerNotifications();
        } else {
          await getRequesterNotifications();
        }

        updateUnreadCount();
      }
    } catch (e) {
      print('Error marking notification as read: $e');
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      isLoading.value = true;

      var notificationsToMark =
          requesterNotifications.where((n) => !n.isRead).toList();

      for (var notification in notificationsToMark) {
        await _notificationApi.markAsRead(notification.notiAdopReqId);
      }

      await getRequesterNotifications();
      updateUnreadCount();
    } catch (e) {
      print('Error clearing notifications: $e');
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถล้างการแจ้งเตือนได้ กรุณาลองใหม่อีกครั้ง',
        backgroundColor: Colors.red.withOpacity(0.1),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshAllNotifications() async {
    await getPostOwnerNotifications();
    await getRequesterNotifications();
    updateUnreadCount();
  }

  void updateUnreadCount() {
    int count = 0;
    count += postOwnerNotifications.where((n) => !n.isRead).length;
    count += requesterNotifications.where((n) => !n.isRead).length;
    unreadNotificationCount.value = count;
  }

  Future<void> initializeNotifications() async {
    await getPostOwnerNotifications();
    await getRequesterNotifications();
    updateUnreadCount();
  }

  Future<Map<String, dynamic>?> fetchAdoptionRequestDetails(
      int requestId) async {
    try {
      isLoading.value = true;
      return await _notificationApi.fetchAdoptionRequestDetails(requestId);
    } catch (e) {
      print('Error fetching request details: $e');
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถดึงข้อมูลได้ กรุณาลองใหม่',
        backgroundColor: Colors.red.withOpacity(0.1),
        snackPosition: SnackPosition.TOP,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleApproveRequest(int notiAdopReqId) async {
    try {
      isLoading.value = true;
      await _notificationApi.approveAdoptionRequest(notiAdopReqId);
      await refreshAllNotifications();

      Get.snackbar(
        'สำเร็จ',
        'คำขอรับเลี้ยงได้รับการอนุมัติแล้ว',
        backgroundColor: Colors.green.withOpacity(0.1),
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
      );

      await Future.delayed(Duration(milliseconds: 500));
      Get.until((route) => route.isFirst);
    } catch (e) {
      print('Error approving request: $e');
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถอนุมัติคำขอได้ กรุณาลองใหม่อีกครั้ง',
        backgroundColor: Colors.red.withOpacity(0.1),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleDenyRequest(int notiAdopReqId) async {
    try {
      isLoading.value = true;

      await _notificationApi.denyAdoptionRequest(notiAdopReqId);
      await refreshAllNotifications();

      Get.snackbar(
        'สำเร็จ',
        'คำขอรับเลี้ยงถูกปฏิเสธแล้ว',
        backgroundColor: Colors.green.withOpacity(0.1),
        duration: Duration(seconds: 2),
      );

      Get.until((route) => route.isFirst);
    } catch (e) {
      print('Error denying request: $e');
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถปฏิเสธคำขอได้ กรุณาลองใหม่อีกครั้ง',
        backgroundColor: Colors.red.withOpacity(0.1),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
