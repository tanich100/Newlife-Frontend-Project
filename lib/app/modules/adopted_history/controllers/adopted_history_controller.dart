import 'package:flutter/material.dart';
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

  Future<void> fetchAdoptionHistory() async {
    try {
      int userId = UserStorageService.getUserId() ?? 0;
      if (userId == 0) return;

      final fetchedRequests = await _apiService.getUserAdoptionHistory(userId);

      print('Fetched ${fetchedRequests.length} requests');
      for (var request in fetchedRequests) {
        print('Request ID: ${request.requestId}');
        print('Status: ${request.status}');
        print('Pet name: ${request.adoptionPost?.name}');
        print('Image URL: ${request.adoptionPost?.image1}');
      }

      adoptionRequests.value = fetchedRequests;
    } catch (e) {
      print("Error fetching adoption history: $e");
      Get.snackbar(
        'ข้อผิดพลาด',
        'ไม่สามารถดึงข้อมูลประวัติการขอรับเลี้ยงได้',
        backgroundColor: Colors.red.withOpacity(0.1),
      );
    }
  }

  List<AdoptionRequestModel> getFilteredRequests(String status) {
    print('Current status filter: $status');
    print('Total requests: ${adoptionRequests.length}');

    for (var request in adoptionRequests) {
      print(
          'Request status: ${request.status}, Pet name: ${request.adoptionPost?.name}');
    }

    var sortedRequests = List<AdoptionRequestModel>.from(adoptionRequests)
      ..sort((a, b) => b.dateAdded.compareTo(a.dateAdded));

    if (status == 'ทั้งหมด') {
      return sortedRequests;
    }

    var filteredRequests = sortedRequests.where((request) {
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

    print('Filtered requests count for $status: ${filteredRequests.length}');
    return filteredRequests;
  }

  Future<void> createAdoptionRequest(
      int adoptionPostId, String reasonForAdoption) async {
    try {
      int userId = UserStorageService.getUserId() ?? 0;

      AdoptionRequestDto requestDto = AdoptionRequestDto(
        userId: userId,
        adoptionPostId: adoptionPostId,
        reasonForAdoption: reasonForAdoption,
        updateUserInfo: false,
        userUpdate: null,
      );
      await _apiService.createAdoptionRequest(requestDto);
      fetchAdoptionHistory();
    } catch (e) {
      print("Error creating adoption request: $e");
    }
  }
}
