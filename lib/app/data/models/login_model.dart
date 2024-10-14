class LoginResponseModel {
  final int userId;
  final String name;
  final String email;
  final String? profilePic;
  final String token; // เพิ่ม token

  LoginResponseModel({
    required this.userId,
    required this.name,
    required this.email,
    this.profilePic,
    required this.token, // เพิ่ม token
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      profilePic: json['profilePic'],
      token: json['token'], // เพิ่ม token
    );
  }
}
