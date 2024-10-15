import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/breed_model.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';

class BreedApi {
  final ApiService _apiService = ApiService();

  Future<Breed> getBreed(int breedId) async {
    try {
      final response = await _apiService.get('${AppUrl.breeds}/$breedId');
      return Breed.fromJson(response.data);
    } catch (e) {
      print('Error in getBreed: $e');
      // ส่งค่าเริ่มต้นกลับไปเมื่อเกิดข้อผิดพลาด
      return Breed(
          breedId: null, animalType: 'ไม่ทราบ', breedName: 'ไม่ทราบสายพันธุ์');
    }
  }
}