import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/adoption_request_dto.dart';
import 'package:newlife_app/app/data/models/adoption_request_post.dart';
import 'package:newlife_app/app/data/network/services/api_service.dart';

class AdoptionRequestApi {
  final ApiService _apiService = ApiService();

  Future<List<AdoptionRequestModel>> getUserAdoptionHistory(int userId) async {
    try {
      final response = await _apiService
          .get('${AppUrl.adoptionRequests}/user-adoption-history/$userId');
      List<AdoptionRequestModel> adoptionRequests = (response.data as List)
          .map((json) => AdoptionRequestModel.fromJson(json))
          .toList();
      return adoptionRequests;
    } catch (e) {
      print("Error fetching adoption history: $e");
      rethrow;
    }
  }

  Future<void> createAdoptionRequest(AdoptionRequestDto requestDto) async {
    try {
      await _apiService.post(AppUrl.adoptionRequests,
          data: requestDto.toJson());
    } catch (e) {
      print("Error creating adoption request: $e");
      rethrow;
    }
  }
}
