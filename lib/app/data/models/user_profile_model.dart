class UserProfileModel {
  final int userId;
  final String name;
  final String lastName;
  final String email;
  final String? monthlyIncome;
  final String? freeTimePerDay;
  final String? typeOfResidence;
  final String? profilePic;

  UserProfileModel({
    required this.userId,
    required this.name,
    required this.lastName,
    this.monthlyIncome,
    this.freeTimePerDay,
    this.typeOfResidence,
    required this.email,
    this.profilePic,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['user_id'],
      name: json['name'],
      lastName: json['lastname'],
      monthlyIncome: json['monthlyIncome'],
      freeTimePerDay: json['freeTimePerDay'],
      typeOfResidence: json['typeOfResidence'],
      email: json['email'],
      profilePic: json['profile_pic'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'userId': userId,
      'name': name,
      'lastName': lastName,
      'email': email,
    };

    // Add nullable fields only if they are not null
    if (monthlyIncome != null) {
      data['monthlyIncome'] = monthlyIncome;
    }
    if (freeTimePerDay != null) {
      data['freeTimePerDay'] = freeTimePerDay;
    }
    if (typeOfResidence != null) {
      data['typeOfResidence'] = typeOfResidence;
    }
    if (profilePic != null) {
      data['profilePic'] = profilePic;
    }

    return data;
  }
}
