import 'user_update_dto.dart';

class AdoptionRequestDto {
  final int userId;
  final int adoptionPostId;
  final String reasonForAdoption;
  final bool updateUserInfo;
  final UserUpdateDto? userUpdate;

  AdoptionRequestDto({
    required this.userId,
    required this.adoptionPostId,
    required this.reasonForAdoption,
    required this.updateUserInfo,
    this.userUpdate,
  });

  // toJson ถูกต้องแล้ว เพราะใช้ตัวพิมพ์ใหญ่ตรงกับ Backend
  Map<String, dynamic> toJson() => {
        'UserId': userId,
        'AdoptionPostId': adoptionPostId,
        'ReasonForAdoption': reasonForAdoption,
        'UpdateUserInfo': updateUserInfo,
        'UserUpdate': userUpdate?.toJson(),
      };
}
