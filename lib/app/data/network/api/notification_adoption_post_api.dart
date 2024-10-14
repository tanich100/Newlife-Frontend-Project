import 'package:get_storage/get_storage.dart';

import '../../../constants/app_url.dart';
import '../../models/notification_adoption_post_model.dart';
import '../services/api_service.dart';

class NotificationAdoptionPostApi {
  final ApiService _apiService = ApiService();

  Future<List<NotificationAdoptionPost>> getNotifications() async {
    try {
      final GetStorage storage = GetStorage();
      String userId = storage.read('userId').toString();

      // final response = await _apiService.get(AppUrl.notificationAdoptionPost);
      final response = await _apiService.get(AppUrl.notificationAdoptionPostByUserId+userId);
      print('API Response: ${response.data}');

      List<NotificationAdoptionPost> notifications = (response.data as List)
          .map((json) => NotificationAdoptionPost.fromJson(json))
          .toList();

      notifications.forEach((notifications) {
        print('Post: ${notifications.toJson()}');
      });

      return notifications;
    } catch (e) {
      print('Error in get notifications: $e');
      rethrow;
    }
  }
}
