import '../../../constants/app_url.dart';
import '../../models/notification_adoption_request_model.dart';
import '../services/api_service.dart';

class NotificationAdoptionRequestApi {
  final ApiService _apiService = ApiService();

  // ดึงการแจ้งเตือนสำหรับเจ้าของโพสต์
  Future<List<NotificationAdoptionRequest>> getPostOwnerNotifications(
      int userId) async {
    try {
      final response = await _apiService
          .get(AppUrl.notificationAdoptionRequest + "/post-owner/$userId");
      print('API Response: ${response.data}');
      List<NotificationAdoptionRequest> notifications = (response.data as List)
          .map((json) => NotificationAdoptionRequest.fromJson(json))
          .toList();
      return notifications;
    } catch (e) {
      print('Error in get post owner notifications: $e');
      rethrow;
    }
  }

  // ดึงการแจ้งเตือนสำหรับผู้ขอรับเลี้ยง
  Future<List<NotificationAdoptionRequest>> getRequesterNotifications(
      int userId) async {
    try {
      final response = await _apiService
          .get(AppUrl.notificationAdoptionRequest + "/requester/$userId");
      print('API Response: ${response.data}');
      List<NotificationAdoptionRequest> notifications = (response.data as List)
          .map((json) => NotificationAdoptionRequest.fromJson(json))
          .toList();
      return notifications;
    } catch (e) {
      print('Error in get requester notifications: $e');
      rethrow;
    }
  }

// ฟังก์ชันสำหรับการอนุมัติคำขอรับเลี้ยง
  Future<void> approveAdoptionRequest(int notiAdopReqId) async {
    try {
      await _apiService.patch(
        AppUrl.notificationAdoptionRequest + "/approve/$notiAdopReqId",
        data: {},
      );
    } catch (e) {
      print('Error in approve adoption request: $e');
      rethrow;
    }
  }

// ฟังก์ชันสำหรับการปฏิเสธคำขอรับเลี้ยง
  Future<void> denyAdoptionRequest(int notiAdopReqId) async {
    try {
      await _apiService.patch(
        AppUrl.notificationAdoptionRequest + "/deny/$notiAdopReqId",
        data: {},
      );
    } catch (e) {
      print('Error in deny adoption request: $e');
      rethrow;
    }
  }
}
