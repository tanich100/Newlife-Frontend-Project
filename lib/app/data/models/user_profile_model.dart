class UserProfileModel {
  final int userId;
  final String name;
  final String lastName;
  final String email;
  final String? profilePic;

  UserProfileModel({
    required this.userId,
    required this.name,
    required this.lastName,
    required this.email,
    this.profilePic,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['user_id'],
      name: json['name'],
      lastName: json['lastname'],
      email: json['email'],
      profilePic: json['profile_pic'],
    );
  }
}
