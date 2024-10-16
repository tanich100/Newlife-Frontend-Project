import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_request_post.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:path/path.dart';
import '../controllers/adopted_history_controller.dart';

class AdoptedHistoryView extends GetView<AdoptedHistoryController> {
  AdoptedHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFFFD54F),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
          title: Text(
            'ประวัติการอุปการะ',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFFFFD54F),
            tabs: [
              Tab(text: 'ทั้งหมด'),
              Tab(text: 'รอดำเนินการ'),
              Tab(text: 'ผ่านเกณฑ์'),
              Tab(text: 'ไม่ผ่านเกณฑ์'),
              Tab(text: 'ยกเลิก'),
            ],
          ),
        ),
        body: SafeArea(
          child: Obx(() {
            if (controller.adoptionRequests.isEmpty) {
              return Center(child: Text('ไม่มีประวัติการขอรับเลี้ยง'));
            }

            return TabBarView(
              children: [
                _buildRequestList('ทั้งหมด'),
                _buildRequestList('รอดำเนินการ'),
                _buildRequestList('ผ่านเกณฑ์'),
                _buildRequestList('ไม่ผ่านเกณฑ์'),
                _buildRequestList('ยกเลิก'),
              ],
            );
          }),
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
    );
  }

  Widget _buildRequestList(String tabStatus) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: controller.getFilteredRequests(tabStatus).length,
      itemBuilder: (context, index) {
        final request = controller.getFilteredRequests(tabStatus)[index];
        return _buildRequestCard(request);
      },
    );
  }

  Widget _buildRequestCard(AdoptionRequestModel request) {
    return Card(
      color: Color(0xFFFFD54F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(request.adoptionPost?.image1 ?? ''),
              radius: 30,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${request.adoptionPost?.name ?? 'Unknown'} (${request.adoptionPost?.age ?? 'Unknown'})',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                      'สายพันธุ์ ${request.adoptionPost?.breedId ?? 'Unknown'}'),
                  Text(request.reasonForAdoption ?? 'No reason provided'),
                  Text('เหตุผล ${request.reasonForAdoption ?? 'Unknown'}'),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(request.dateAdded.toString().substring(0, 10)),
                Text(
                  _getStatusText(request.status),
                  style: TextStyle(
                    color: request.status == 'accepted'
                        ? Colors.green
                        : const Color.fromARGB(255, 235, 44, 44),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'waiting':
        return 'รอดำเนินการ';
      case 'accepted':
        return 'ผ่านเกณฑ์';
      case 'declined':
        return 'ไม่ผ่านเกณฑ์';
      case 'cancelled':
        return 'ยกเลิก';
      default:
        return status;
    }
  }
}
