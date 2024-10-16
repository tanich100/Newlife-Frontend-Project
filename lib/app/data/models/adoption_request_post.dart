import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/notification_adoption_post_model.dart';
import 'package:newlife_app/app/data/models/notification_adoption_request_model.dart';
import 'package:newlife_app/app/data/network/api/notification_adoption_request_api.dart';

class AdoptionRequestModel {
  final int? requestId;
  final int? userId; // เปลี่ยนเป็น nullable
  final int? adoptionPostId; // เปลี่ยนเป็น nullable
  final String status;
  final String? reasonForAdoption; // เปลี่ยนเป็น nullable
  final DateTime dateAdded;
  final AdoptionPost? adoptionPost;
  // final NotificationAdoptionRequest? notificationAdoptionRequest;

  AdoptionRequestModel({
    this.requestId,
    this.userId,
    this.adoptionPostId,
    required this.status,
    this.reasonForAdoption,
    required this.dateAdded,
    this.adoptionPost,
    // this.notificationAdoptionRequest,
  });

  factory AdoptionRequestModel.fromJson(Map<String, dynamic> json) {
    return AdoptionRequestModel(
      requestId: json['requestId'],
      userId: json['userId'],
      adoptionPostId: json['adoptionPostId'],
      status: json['status'],
      reasonForAdoption: json['reasonForAdoption'],
      dateAdded: DateTime.parse(json['dateAdded']),
      adoptionPost: json['adoptionPost'] != null
          ? AdoptionPost.fromJson(json['adoptionPost'])
          : null,
      // notificationAdoptionRequest: json['notificationAdoptionRequest'] != null
      //     ? NotificationAdoptionRequest.fromJson(
      //         json['notificationAdoptionRequest'])
      //     : null,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'requestId': requestId,
  //     'userId': userId,
  //     'adoptionPostId': adoptionPostId,
  //     'status': status,
  //     'reasonForAdoption': reasonForAdoption,
  //     'dateAdded': dateAdded.toIso8601String(),
  //   };
  // }
}
