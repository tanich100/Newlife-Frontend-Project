class NotificationAdoptionRequest {
  int notiAdopReqId;
  int requestId;
  int userId;
  String description;
  bool isRead;
  DateTime notiDate;

  NotificationAdoptionRequest({
    required this.notiAdopReqId,
    required this.requestId,
    required this.userId,
    required this.description,
    required this.isRead,
    required this.notiDate,
  });

  factory NotificationAdoptionRequest.fromJson(Map<String, dynamic> json) {
    return NotificationAdoptionRequest(
      notiAdopReqId: json['notiAdopReqId'],
      requestId: json['requestId'],
      userId: json['userId'],
      description: json['description'],
      isRead: json['isRead'],
      notiDate: DateTime.parse(json['notiDate']),
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
    };
  }
}
