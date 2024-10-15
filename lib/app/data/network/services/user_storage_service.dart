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
    storage.erase();
  }

  // Getter สำหรับดึงข้อมูลผู้ใช้ที่ login แล้ว
  static int? getUserId() => storage.read('userId') as int?;
  static String? getUserName() => storage.read('userName') as String?;
  static String? getUserEmail() => storage.read('userEmail') as String?;
  static String? getProfilePic() => storage.read('profilePic') as String?;
  static String? getToken() => storage.read('token') as String?;
  static List<int> getSelectedBreedIds() =>
      List<int>.from(storage.read('selectedBreedIds') ?? []);
}
