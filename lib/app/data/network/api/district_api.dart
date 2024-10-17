import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';
import '../../models/district_model.dart';

class DistrictApi {
  final ApiService _apiService = ApiService();

  Future<List<District>> getAllDistricts() async {
    try {
      print('Fetching districts from: ${AppUrl.districts}');
      final response = await _apiService.get(AppUrl.districts);
      print('API Response: ${response.data}');

      if (response.data is List) {
        List<District> districts = (response.data as List)
            .map((json) => District.fromJson(json))
            .toList();

        print('Parsed districts: ${districts.length}');
        districts.forEach((district) {
          print('District: ${district.toJson()}');
        });

        return districts;
      } else {
        print('Invalid data format received from API');
        throw Exception('Invalid data format received from API');
      }
    } catch (e) {
      print('Error in getAllDistricts: $e');
      rethrow;
    }
  }

  Future<District> getDistrict(int districtId) async {
    try {
      final response = await _apiService.get('${AppUrl.districts}/$districtId');
      print('API Response for district $districtId: ${response.data}');

      if (response.data is Map<String, dynamic>) {
        District district = District.fromJson(response.data);
        print('Parsed district: ${district.toJson()}');
        return district;
      } else {
        throw Exception('Invalid data format received from API');
      }
    } catch (e) {
      print('Error in getDistrict: $e');
      rethrow;
    }
  }
}