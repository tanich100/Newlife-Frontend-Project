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

  NotificationAdoptionRequest({
    required this.notiAdopReqId,
    required this.requestId,
    required this.userId,
    required this.description,
    required this.isRead,
    required this.notiDate,
    this.adoptionRequest,
    this.status,
  });

  factory NotificationAdoptionRequest.fromJson(Map<String, dynamic> json) {
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
    );
  }

  String? get postName => adoptionRequest?.adoptionPost?.name;
  String? get postImage => adoptionRequest?.adoptionPost?.image1;
  String? get reasonForAdoption => adoptionRequest?.reasonForAdoption;

  UserProfileModel? get requestingUser => adoptionRequest?.user;
  String? get userName => requestingUser?.name;
  String? get userEmail => requestingUser?.email;
  String? get userProfilePic => requestingUser?.profilePic;
}
