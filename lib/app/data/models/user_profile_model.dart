import 'package:newlife_app/app/data/models/user_update_dto.dart';

class UserProfileModel {
  final int userId;
  String name;
  String lastName;
  final String email;
  String? tel;
  String? gender;
  int? age;
  String? address;
  String? career;
  int? numOfFamMembers;
  bool? isHaveExperience;
  String? sizeOfResidence;
  String? typeOfResidence;
  int? freeTimePerDay;
  int? monthlyIncome;
  String? profilePic;

  UserProfileModel({
    required this.userId,
    required this.name,
    required this.lastName,
    required this.email,
    this.tel,
    this.gender,
    this.age,
    this.address,
    this.career,
    this.numOfFamMembers,
    this.isHaveExperience,
    this.sizeOfResidence,
    this.typeOfResidence,
    this.freeTimePerDay,
    this.monthlyIncome,
    this.profilePic,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['userId'] ?? 0,
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      tel: json['tel'],
      gender: json['gender'],
      age: json['age'] != null ? int.parse(json['age'].toString()) : null,
      address: json['address'],
      career: json['career'],
      numOfFamMembers: json['numOfFamMembers'] != null
          ? int.parse(json['numOfFamMembers'].toString())
          : null,
      isHaveExperience: json['isHaveExperience'],
      sizeOfResidence: json['sizeOfResidence'],
      typeOfResidence: json['typeOfResidence'],
      freeTimePerDay: json['freeTimePerDay'] != null
          ? int.parse(json['freeTimePerDay'].toString())
          : null,
      monthlyIncome: json['monthlyIncome'] != null
          ? int.parse(json['monthlyIncome'].toString())
          : null,
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'lastname': lastName,
      'email': email,
      'tel': tel,
      'gender': gender,
      'age': age,
      'address': address,
      'career': career,
      'numOfFamMembers': numOfFamMembers,
      'isHaveExperience': isHaveExperience,
      'sizeOfResidence': sizeOfResidence,
      'typeOfResidence': typeOfResidence,
      'freeTimePerDay': freeTimePerDay,
      'monthlyIncome': monthlyIncome,
      'profile_pic': profilePic,
    };
  }

  UserUpdateDto toUpdateDto() {
    return UserUpdateDto(
      name: name,
      lastName: lastName,
      tel: tel,
      gender: gender,
      age: age,
      address: address,
      career: career,
      numOfFamMembers: numOfFamMembers,
      isHaveExperience: isHaveExperience,
      sizeOfResidence: sizeOfResidence,
      typeOfResidence: typeOfResidence,
      freeTimePerDay: freeTimePerDay,
      monthlyIncome: monthlyIncome,
    );
  }
}
