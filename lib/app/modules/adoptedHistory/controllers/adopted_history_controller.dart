import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_request_dto.dart';
import 'package:newlife_app/app/data/models/adoption_request_post.dart';
import 'package:newlife_app/app/data/network/api/adoption_request_post.dart';
import 'package:newlife_app/app/data/network/services/user_storage_service.dart';

class AdoptedHistoryController extends GetxController {
  RxList<AdoptionRequestModel> adoptionRequests = <AdoptionRequestModel>[].obs;
  final AdoptionRequestApi _apiService = AdoptionRequestApi();

  @override
  void onInit() async {
    super.onInit();
    fetchAdoptionHistory();
  }

  void fetchAdoptionHistory() async {
    try {
      int userId = UserStorageService.getUserId() ?? 0;
      List<AdoptionRequestModel> fetchedRequests =
          await _apiService.getUserAdoptionHistory(userId);
      adoptionRequests.value = fetchedRequests;
    } catch (e) {
      print("Error fetching adoption history: $e");
    }
  }

  List<AdoptionRequestModel> getFilteredRequests(String status) {
    if (status == 'ทั้งหมด') {
      return adoptionRequests;
    }
    return adoptionRequests.where((request) {
      switch (status) {
        case 'รอดำเนินการ':
          return request.status == 'waiting';
        case 'ผ่านเกณฑ์':
          return request.status == 'accepted';
        case 'ไม่ผ่านเกณฑ์':
          return request.status == 'declined';
        case 'ยกเลิก':
          return request.status == 'cancelled';
        default:
          return false;
      }
    }).toList();
  }

  Future<void> createAdoptionRequest(
      int adoptionPostId, String reasonForAdoption) async {
    try {
      int userId = UserStorageService.getUserId() ?? 0;
      AdoptionRequestDto requestDto = AdoptionRequestDto(
        userId: userId,
        adoptionPostId: adoptionPostId,
        reasonForAdoption: reasonForAdoption,
      );
      await _apiService.createAdoptionRequest(requestDto);
      fetchAdoptionHistory();
    } catch (e) {
      print("Error creating adoption request: $e");
    }
  }
}
