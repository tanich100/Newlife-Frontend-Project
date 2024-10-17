import 'package:newlife_app/app/data/models/adoption_request_post.dart';

class NotificationAdoptionRequest {
  int notiAdopReqId;
  int requestId;
  int userId;
  String description;
  bool isRead;
  DateTime notiDate;
  AdoptionRequestModel? adoptionRequest; // Added the relationship here

  NotificationAdoptionRequest({
    required this.notiAdopReqId,
    required this.requestId,
    required this.userId,
    required this.description,
    required this.isRead,
    required this.notiDate,
    this.adoptionRequest, // nullable, in case it's missing
  });

  factory NotificationAdoptionRequest.fromJson(Map<String, dynamic> json) {
    return NotificationAdoptionRequest(
      notiAdopReqId: json['notiAdopReqId'] as int,
      requestId: json['requestId'] as int,
      userId: json['userId'] ?? 0,
      description: json['description'] as String,
      isRead: json['isRead'] == 1,
      notiDate: DateTime.parse(json['notiDate']),
      adoptionRequest: json['adoptionRequest'] != null
          ? AdoptionRequestModel.fromJson(json['adoptionRequest'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notiAdopReqId': notiAdopReqId,
      'requestId': requestId,
      'userId': userId,
      'description': description,
      'isRead': isRead,
      'notiDate': notiDate.toIso8601String(),
      'adoptionRequest': adoptionRequest?.toJson(),
    };
  }
}
