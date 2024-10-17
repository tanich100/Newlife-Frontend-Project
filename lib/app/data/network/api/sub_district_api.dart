import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/sub_daistrict_model.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';


class SubDistrictApi {
  final ApiService _apiService = ApiService();

  Future<List<SubDistrictModel>> getAllSubDistricts() async {
    try {
      print('Fetching sub-districts from: ${AppUrl.subDistricts}');
      final response = await _apiService.get(AppUrl.subDistricts);
      print('API Response: ${response.data}');

      if (response.data is List) {
        List<SubDistrictModel> subDistricts = (response.data as List)
            .map((json) => SubDistrictModel.fromJson(json))
            .toList();

        print('Parsed sub-districts: ${subDistricts.length}');
        subDistricts.forEach((subDistrict) {
          print('SubDistrict: ${subDistrict.toJson()}');
        });

        return subDistricts;
      } else {
        print('Invalid data format received from API');
        throw Exception('Invalid data format received from API');
      }
    } catch (e) {
      print('Error in getAllSubDistricts: $e');
      rethrow;
    }
  }

  Future<SubDistrictModel> getSubDistrict(int subDistrictId) async {
    try {
      final response = await _apiService.get('${AppUrl.subDistricts}/$subDistrictId');
      print('API Response for sub-district $subDistrictId: ${response.data}');

      if (response.data is Map<String, dynamic>) {
        SubDistrictModel subDistrict = SubDistrictModel.fromJson(response.data);
        print('Parsed sub-district: ${subDistrict.toJson()}');
        return subDistrict;
      } else {
        throw Exception('Invalid data format received from API');
      }
    } catch (e) {
      print('Error in getSubDistrict: $e');
      rethrow;
    }
  }

  Future<List<SubDistrictModel>> getSubDistrictsByDistrictId(int districtId) async {
    try {
      final response = await _apiService.get('${AppUrl.subDistricts}/by-district/$districtId');
      print('API Response for sub-districts of district $districtId: ${response.data}');

      if (response.data is List) {
        List<SubDistrictModel> subDistricts = (response.data as List)
            .map((json) => SubDistrictModel.fromJson(json))
            .toList();

        print('Parsed sub-districts: ${subDistricts.length}');
        return subDistricts;
      } else {
        throw Exception('Invalid data format received from API');
      }
    } catch (e) {
      print('Error in getSubDistrictsByDistrictId: $e');
      rethrow;
    }
  }
}