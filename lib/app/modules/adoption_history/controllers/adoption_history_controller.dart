import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_request_post.dart';
import 'package:newlife_app/app/data/network/api/adoption_request_post.dart';

class AdoptionHistoryController extends GetxController {
  RxList<AdoptionRequestModel> adoptionRequests = <AdoptionRequestModel>[].obs;
  final AdoptionRequestApi _apiService = AdoptionRequestApi();

  final int postId;

  AdoptionHistoryController(this.postId);

  @override
  void onInit() {
    super.onInit();
    fetchAdoptionRequests();
  }

  void fetchAdoptionRequests() async {
    try {
      List<AdoptionRequestModel> fetchedRequests =
          await _apiService.getPostAdoptionRequests(postId);
      adoptionRequests.value = fetchedRequests;
    } catch (e) {
      print("Error fetching adoption requests: $e");
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
}
