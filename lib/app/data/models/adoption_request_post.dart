import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/notification_adoption_post_model.dart';
import 'package:newlife_app/app/data/models/notification_adoption_request_model.dart';
import 'package:newlife_app/app/data/models/user_profile_model.dart';
import 'package:newlife_app/app/data/network/api/notification_adoption_request_api.dart';

class AdoptionRequestModel {
  final int requestId;
  final int adoptionPostId;
  final int userId;
  final String status;
  final String reasonForAdoption;
  final DateTime dateAdded;
  final AdoptionPost? adoptionPost;
  final UserProfileModel? user;
  final List<NotificationAdoptionRequest>? notifications;

  AdoptionRequestModel({
    required this.requestId,
    required this.adoptionPostId,
    required this.userId,
    required this.status,
    required this.reasonForAdoption,
    required this.dateAdded,
    this.adoptionPost,
    this.user,
    this.notifications,
  });

  factory AdoptionRequestModel.fromJson(Map<String, dynamic> json) {
    try {
      print('Parsing json: $json'); // Debug print

      // แก้การแปลงข้อมูลให้ตรงกับ JSON ที่ได้รับ
      return AdoptionRequestModel(
        requestId: json['requestId'] ?? 0,
        adoptionPostId: json['adoptionPost']?['adoptionPostId'] ?? 0,
        userId: json['userId'] ?? 0,
        status: (json['status'] as String?)?.toLowerCase() ?? '',
        reasonForAdoption: json['reasonForAdoption'] ?? '',
        dateAdded: DateTime.parse(
            json['dateAdded'] ?? DateTime.now().toIso8601String()),
        adoptionPost: json['adoptionPost'] != null
            ? AdoptionPost.fromJson(
                json['adoptionPost'] as Map<String, dynamic>)
            : null,
        notifications: json['notifications'] != null
            ? (json['notifications'] as List)
                .map((n) => NotificationAdoptionRequest.fromJson(
                    n as Map<String, dynamic>))
                .toList()
            : null,
      );
    } catch (e) {
      print('Error parsing AdoptionRequestModel: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        'RequestId': requestId,
        'AdoptionPostId': adoptionPostId,
        'UserId': userId,
        'Status': status,
        'ReasonForAdoption': reasonForAdoption,
        'DateAdded': dateAdded.toIso8601String(),
        'AdoptionPost': adoptionPost?.toJson(),
        'User': user?.toJson(),
        'Notifications': notifications?.map((n) => n.toJson()).toList(),
      };
}
