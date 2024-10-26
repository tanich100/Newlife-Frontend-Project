import 'package:dio/dio.dart';
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

  // ฟังก์ชันดึงรายละเอียดคำขอรับเลี้ยง
  Future<Map<String, dynamic>?> fetchAdoptionRequestDetails(
      int requestId) async {
    try {
      final response = await _apiService.get(
          '${AppUrl.notificationAdoptionRequest}/request-details/$requestId');

      if (response.statusCode == 200 && response.data != null) {
        print('API Response data: ${response.data}'); // เพิ่ม debug print

        // แปลงข้อมูลให้เป็น camelCase
        var data = Map<String, dynamic>.from(response.data);
        if (data.containsKey('ReasonForAdoption')) {
          data['reasonForAdoption'] = data['ReasonForAdoption'];
          data.remove('ReasonForAdoption');
        }

        print('Transformed data: $data'); // เพิ่ม debug print
        return data;
      } else {
        print('Error status code: ${response.statusCode}');
        print('Error response: ${response.data}');
        return null;
      }
    } catch (e) {
      print('Error fetching request details: $e');
      return null;
    }
  }

// ฟังก์ชันสำหรับการอนุมัติคำขอรับเลี้ยง
  Future<void> approveAdoptionRequest(int notiAdopReqId) async {
    try {
      final response = await _apiService.patch(
        '${AppUrl.notificationAdoptionRequest}/approve/$notiAdopReqId',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to approve request: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error in approve adoption request: $e');
      rethrow;
    }
  }

  Future<void> denyAdoptionRequest(int notiAdopReqId) async {
    try {
      final response = await _apiService.patch(
        '${AppUrl.notificationAdoptionRequest}/deny/$notiAdopReqId',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to deny request: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error in deny adoption request: $e');
      rethrow;
    }
  }

  Future<void> markAsRead(int notiAdopReqId) async {
    try {
      final response = await _apiService.patch(
        '${AppUrl.notificationAdoptionRequest}/mark-as-read/$notiAdopReqId',
        data: {},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to mark notification as read: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error marking notification as read: $e');
      rethrow;
    }
  }
}
