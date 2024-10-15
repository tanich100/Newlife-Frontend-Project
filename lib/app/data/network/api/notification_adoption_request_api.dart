import 'package:get_storage/get_storage.dart';

import '../../../constants/app_url.dart';
import '../../models/notification_adoption_request_model.dart';
import '../services/api_service.dart';

class NotificationAdoptionRequestApi {
  final ApiService _apiService = ApiService();
  Future<List<NotificationAdoptionRequest>> getNotifications() async {
    try {
      final GetStorage storage = GetStorage();
      String userId = storage.read('userId').toString();
      final response = await _apiService
          .get(AppUrl.notificationAdoptionRequestByUserId + userId);
      print('API Response: ${response.data}');
      List<NotificationAdoptionRequest> notifications = (response.data as List)
          .map((json) => NotificationAdoptionRequest.fromJson(json))
          .toList();
      // notifications.forEach((notifications) {
      //   print('NotificationAdoption Request: ${notifications.toJson()}');
      // });

      return notifications;
    } catch (e) {
      print('Error in get notifications: $e');
      rethrow;
    }
  }
}
