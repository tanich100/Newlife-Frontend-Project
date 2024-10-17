import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/notification_adoption_post_model.dart';
import 'package:newlife_app/app/data/models/notification_adoption_request_model.dart';
import 'package:newlife_app/app/data/models/user_profile_model.dart';
import 'package:newlife_app/app/data/network/api/notification_adoption_request_api.dart';

class AdoptionRequestModel {
  final int? requestId;
  final int? userId;
  final int? adoptionPostId;
  final String status;
  final String? reasonForAdoption;
  final DateTime dateAdded;
  final AdoptionPost? adoptionPost;
  final UserProfileModel? user;

  AdoptionRequestModel({
    this.requestId,
    this.userId,
    this.adoptionPostId,
    required this.status,
    this.reasonForAdoption,
    required this.dateAdded,
    this.adoptionPost,
    this.user,
  });

  factory AdoptionRequestModel.fromJson(Map<String, dynamic> json) {
    return AdoptionRequestModel(
      requestId: json['requestId'] ?? 0, // ป้องกัน null ด้วยค่า default
      userId: json['userId'],
      adoptionPostId: json['adoptionPostId'],
      status: json['status'] ?? 'unknown', // กำหนดค่า default ถ้า null
      reasonForAdoption: json['reasonForAdoption'],
      dateAdded: DateTime.parse(json['dateAdded']),
      adoptionPost: json['adoptionPost'] != null
          ? AdoptionPost.fromJson(json['adoptionPost'])
          : null,
      user:
          json['user'] != null ? UserProfileModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'requestId': requestId,
      'userId': userId,
      'adoptionPostId': adoptionPostId,
      'status': status,
      'reasonForAdoption': reasonForAdoption,
      'dateAdded': dateAdded.toIso8601String(),
      'adoptionPost': adoptionPost?.toJson(),
      'user': user?.toJson(),
    };
  }
}
