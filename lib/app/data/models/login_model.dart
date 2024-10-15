class LoginResponseModel {
  final int userId;
  final String name;
  final String email;
  final String? profilePic;
  final String token;
  final List<int> interestedBreedIds;

  LoginResponseModel({
    required this.userId,
    required this.name,
    required this.email,
    this.profilePic,
    required this.token,
    required this.interestedBreedIds,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    List<int> breedIds = [];
    if (json['interestedBreedIds'] != null &&
        json['interestedBreedIds'] is List) {
      breedIds = List<int>.from(json['interestedBreedIds']);
    }

    return LoginResponseModel(
      userId: json['userId'],
      name:
          json['name'] ?? 'Unknown name', // กำหนดค่าเริ่มต้นหาก name เป็น null
      email: json['email'] ??
          'Unknown email', // กำหนดค่าเริ่มต้นหาก email เป็น null
      profilePic: json['profilePic'] ??
          '', // กำหนดค่าเริ่มต้นให้เป็น '' หาก profilePic เป็น null
      token: json['token'] ?? '',
      interestedBreedIds: breedIds,
    );
  }
}
