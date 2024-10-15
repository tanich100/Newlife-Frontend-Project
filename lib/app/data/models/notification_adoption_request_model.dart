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
    notiAdopReqId: json['notiAdopReqId'] as int,
    requestId: json['requestId'] as int,
    userId: json['userId'] as int,
    description: json['description'] as String,
    isRead: json['isRead'] == 1, // Convert 1 to true, 0 to false
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
