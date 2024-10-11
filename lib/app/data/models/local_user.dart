class localUser {
  int userId;
  String name;
  String imageUrl;

  localUser({required this.userId, required this.name, required this.imageUrl});

  factory localUser.fromJson(Map<String, dynamic> json) {
    return localUser(
      userId: json['user_id'],
      name: json['name'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'image_url': imageUrl,
    };
  }
}
