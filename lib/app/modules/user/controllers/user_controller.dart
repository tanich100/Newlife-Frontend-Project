import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class UserController extends GetxController {
  static const int _version = 1;
  static const String _dbName = "user.db";
  RxInt userId = (-1).obs;
  RxString userName = ''.obs;
  RxString profileImage = ''.obs;

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
          CREATE TABLE device (
            user_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            image_url TEXT NOT NULL,
            PRIMARY KEY (user_id)
          );
        """);

        await db.execute("""
            INSERT INTO device (user_id, name, image_url)
            VALUES (?, ?, ?);
          """, [-1, "", ""]);
      },
      version: _version,
    );
  }

  Future<void> getUser() async {
    try {
      List<Map<String, dynamic>> result = await selectRawQuery("""
        SELECT user_id, name, image_url 
        FROM device 
        WHERE user_id = 1;
      """);

      if (result.isNotEmpty) {
        userId.value = result[0]['user_id'];
        userName.value = result[0]['name'];
        profileImage.value = result[0]['image_url'];
      } else {
        userId.value = -1;
        userName.value = '';
        profileImage.value = '';
      }
    } catch (e) {
      print("Error fetching user: $e");
    }
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
