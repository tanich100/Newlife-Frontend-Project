import 'package:get_storage/get_storage.dart';

// Function -> บันทึกข้อมูลผู้ใช้ลงใน GetStorage
class UserStorageService {
  static final GetStorage storage = GetStorage();

  static void saveUserData({
    required int userId,
    required String name,
    required String email,
    required String profilePic,
    required String token,
    required List<int> interestedBreedIds,
  }) {
    storage.write('userId', userId);
    storage.write('userName', name);
    storage.write('userEmail', email);
    storage.write('profilePic', profilePic);
    storage.write('token', token);
    storage.write('selectedBreedIds', interestedBreedIds);
  }

  static void clearUserData() {
    storage.remove('userId');
    storage.remove('userName');
    storage.remove('userEmail');
    storage.remove('profilePic');
    storage.remove('token');
    storage.remove('selectedBreedIds');
  }
}
