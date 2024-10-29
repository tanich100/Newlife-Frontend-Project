import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/adoption_request_post.dart';
import 'package:newlife_app/app/data/models/user_profile_model.dart';

class NotificationAdoptionRequest {
  final int notiAdopReqId;
  final int requestId;
  final int userId;
  final String description;
  final bool isRead;
  final DateTime notiDate;
  final AdoptionRequestModel? adoptionRequest;
  final String? status;
  final Map<String, dynamic>? adoptionPost;

  NotificationAdoptionRequest({
    required this.notiAdopReqId,
    required this.requestId,
    required this.userId,
    required this.description,
    required this.isRead,
    required this.notiDate,
    this.adoptionRequest,
    this.status,
    this.adoptionPost,
  });

  factory NotificationAdoptionRequest.fromJson(Map<String, dynamic> json) {
    try {
      return NotificationAdoptionRequest(
        notiAdopReqId: json['notiAdopReqId'] ?? 0,
        requestId: json['requestId'] ?? 0,
        userId: json['userId'] ?? 0,
        description: json['description'] ?? '',
        isRead: json['isRead'] ?? false,
        notiDate: DateTime.parse(json['notiDate']),
        adoptionRequest: json['adoptionRequest'] != null
            ? AdoptionRequestModel.fromJson(json['adoptionRequest'])
            : null,
        status: json['status'] as String?,
        adoptionPost: json['adoptionPost'] as Map<String, dynamic>?,
      );
    } catch (e) {
      print('Error parsing NotificationAdoptionRequest: $e');
      print('JSON data: $json');
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        'notiAdopReqId': notiAdopReqId,
        'requestId': requestId,
        'userId': userId,
        'description': description,
        'isRead': isRead,
        'notiDate': notiDate.toIso8601String(),
        'adoptionRequest': adoptionRequest?.toJson(),
        'status': status,
        'adoptionPost': adoptionPost,
      };

//postName & postImage ดึงข้อมูลได้จาก adoptionPost
  String? get postName =>
      adoptionPost?['name'] ?? adoptionRequest?.adoptionPost?.name;
  String? get postImage =>
      adoptionPost?['image1'] ?? adoptionRequest?.adoptionPost?.image1;

  UserProfileModel? get requestingUser => adoptionRequest?.user;
  String? get userName => requestingUser?.name;
  String? get userEmail => requestingUser?.email;
  String? get userProfilePic => requestingUser?.profilePic;
}
