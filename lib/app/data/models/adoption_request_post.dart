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
      return AdoptionRequestModel(
        requestId: json['RequestId'] ?? 0,
        adoptionPostId: json['AdoptionPostId'] ?? 0,
        userId: json['UserId'] ?? 0,
        status: json['Status'] ?? '',
        reasonForAdoption: json['ReasonForAdoption'] ?? '',
        dateAdded: DateTime.parse(
            json['DateAdded'] ?? DateTime.now().toIso8601String()),
        adoptionPost: json['AdoptionPost'] != null
            ? AdoptionPost.fromJson(json['AdoptionPost'])
            : null,
        user: json['User'] != null
            ? UserProfileModel.fromJson(json['User'])
            : null,
        notifications: json['Notifications'] != null
            ? (json['Notifications'] as List)
                .map((n) => NotificationAdoptionRequest.fromJson(n))
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
