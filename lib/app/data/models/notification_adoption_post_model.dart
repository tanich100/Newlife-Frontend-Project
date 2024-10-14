class NotificationAdoptionPost {
  int notificationId; 
  int postAdoptionId; 
  int userId;
  String description; 
  bool isRead;
  DateTime notiDate; 

  NotificationAdoptionPost({
    required this.notificationId,
    required this.postAdoptionId,
    required this.userId,
    required this.description,
    required this.isRead,
    required this.notiDate,
  });

  factory NotificationAdoptionPost.fromJson(Map<String, dynamic> json) {
    return NotificationAdoptionPost(
      notificationId: json['notificationId'],
      postAdoptionId: json['postAdoptionId'],
      userId: json['userId'],
      description: json['description'],
      isRead: json['isRead'],
      notiDate: DateTime.parse(json['notiDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'postAdoptionId': postAdoptionId,
      'userId': userId,
      'description': description,
      'isRead': isRead,
      'notiDate': notiDate.toIso8601String(),
    };
  }
}
