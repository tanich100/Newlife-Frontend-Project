import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/notification_adoption_request_model.dart';

import '../../../data/network/api/notification_adoption_request_api.dart';

class NotificationController extends GetxController {
  NotificationAdoptionRequestApi notificationAdoptionRequestApi =
      NotificationAdoptionRequestApi();
  RxList<NotificationAdoptionRequest> notificationRequests =
      <NotificationAdoptionRequest>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAdoptionRequestNotifications() async {
    try {
      List<NotificationAdoptionRequest> fetchedNotifications =
          await notificationAdoptionRequestApi.getNotifications();
      notificationRequests.value = fetchedNotifications;
      for (int i = 0; i < notificationRequests.length; i++) {
        print('Notification #${i + 1}: ${notificationRequests[i]}');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }
}
