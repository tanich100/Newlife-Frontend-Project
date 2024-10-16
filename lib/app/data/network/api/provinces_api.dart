import 'package:newlife_app/app/constants/app_url.dart';

import 'package:newlife_app/app/data/network/services/api_service.dart';

import '../../models/provinces_model.dart';

class ProvinceApi {
  final ApiService _apiService = ApiService();

  Future<List<Province>> getAllProvinces() async {
    try {
      final response = await _apiService.get(AppUrl.provinces);
      print('API Response: ${response.data}');

      if (response.data is List) {
        List<Province> provinces = (response.data as List)
            .map((json) => Province.fromJson(json))
            .toList();

        print('Parsed provinces:');
        provinces.forEach((province) {
          print('Province: ${province.toJson()}');
        });

        return provinces;
      } else {
        throw Exception('Invalid data format received from API');
      }
    } catch (e) {
      print('Error in getAllProvinces: $e');
      rethrow;
    }
  }

  Future<Province> getProvince(int provinceId) async {
    try {
      final response = await _apiService.get('${AppUrl.provinces}/$provinceId');
      print('API Response: ${response.data}');

      if (response.data is Map<String, dynamic>) {
        Province province = Province.fromJson(response.data);
        print('Parsed province: ${province.toJson()}');
        return province;
      } else {
        throw Exception('Invalid data format received from API');
      }
    } catch (e) {
      print('Error in getProvince: $e');
      rethrow;
    }
  }

  // ฟังก์ชันเพิ่มเติมสำหรับการจัดการข้อมูลจังหวัด (ถ้าจำเป็น)
  // เช่น การเพิ่ม แก้ไข หรือลบข้อมูลจังหวัด
}