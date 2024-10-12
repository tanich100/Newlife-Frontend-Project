import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/local_user.dart';
import 'package:newlife_app/app/data/network/api/user_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserController extends GetxController {
  static const int _version = 1;
  static const String _dbName = "user.db";
  RxInt userId = (-1).obs;
  RxString userName = ''.obs;
  RxString profileImage = ''.obs;
  UserApi userApi = UserApi();

  Future<Database> get database async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: _version,
    );
  }

  Future<void> executeRawQuery(String query) async {
    Database db = await database;
    await db.execute(query);
  }

  Future<List<Map<String, dynamic>>> selectRawQuery(String query) async {
    Database db = await database;

    try {
      List<Map<String, dynamic>> result = await db.rawQuery(query);
      return result;
    } catch (e) {
      print('Error executing raw query: $e');
      return [];
    }
  }

  Future<void> closeDatabase() async {
    Database db = await database;
    await db.close();
  }

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async {
        //สร้างตารางเก็บข้อมูล User
        // มี User Id name image
        await db.execute("""
          CREATE TABLE user (
            user_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            image_url TEXT NOT NULL,
            PRIMARY KEY (user_id)
          );
        """);
        print("Create DB");
        await db.execute("""
            INSERT INTO user (user_id, name, image_url)
            VALUES (?, ?, ?);
          """, [1, "", ""]);
        print("Insert DB");
      },
      version: _version,
    );
  }

  Future<void> getUser() async {
    try {
      await _getDB();
      List<Map<String, dynamic>> result = await selectRawQuery("""
        SELECT user_id, name, image_url 
        FROM user 
        WHERE user_id = 1;
      """);

      if (result.isNotEmpty) {
        userId.value = result[0]['user_id'];
        userName.value = result[0]['name'];
        profileImage.value = result[0]['image_url'];
      } else {
        print("No User Found");
        userId.value = 1;
        userName.value = 'No User';
        profileImage.value = '';
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
  }

  void login(String username, String password) async {
    try {
      await _getDB();
      localUser user = await userApi.login(username, password);
      print('Login successful! User ID: ${user.userId}, Name: ${user.name}');
      await updateLocalUser(user.userId, user.name, user.imageUrl);
      await getUser();
      Get.offAllNamed('/profile');
    } catch (e) {
      print('Login failed: $e');
    }
  }

  Future<void> updateLocalUser(
      int userId, String userName, String imgUrl) async {
    await executeRawQuery("""
      UPDATE user
      SET name = '${userName}' ,image_url = '${imgUrl}'
      WHERE user_id = 1;
    """);
    print("Updated");
  }
}

// @override
// void onInit() {
//   super.onInit();
// }

// @override
// void onReady() {
//   super.onReady();
// }

// @override
// void onClose() {
//   super.onClose();
// }
