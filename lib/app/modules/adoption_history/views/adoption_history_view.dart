import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/adoption_request_post.dart';
import 'package:newlife_app/app/modules/adoption_history/controllers/adoption_history_controller.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';

class AdoptionHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int postId = Get.arguments['postId'] ?? 0;
    if (postId == 0) {
      Get.snackbar('Error', 'ไม่พบโพสต์ที่คุณต้องการดูประวัติ');
      Get.back();
      return Container(); // หยุดการทำงานหากไม่มี postId
    }
    final AdoptionHistoryController controller =
        Get.put(AdoptionHistoryController(postId));

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
            // child: IconButton(
            //   icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            //   onPressed: () => Get.back(),
            // ),
          ),
          title: Text('ประวัติการขอรับอุปการะ',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                _buildRequestList(controller, 'ทั้งหมด'),
                _buildRequestList(controller, 'รอดำเนินการ'),
                _buildRequestList(controller, 'ผ่านเกณฑ์'),
                _buildRequestList(controller, 'ไม่ผ่านเกณฑ์'),
                _buildRequestList(controller, 'ยกเลิก'),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildRequestList(
      AdoptionHistoryController controller, String tabStatus) {
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
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: request.adoptionPost?.image1 != null
                  ? NetworkImage(request.adoptionPost!.image1!)
                  : AssetImage('assets/default_image.png') as ImageProvider,
              radius: 30,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${request.user?.name ?? 'Unknown'} ${request.user?.lastName ?? ''}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(
                      'รายได้ต่อเดือน : ${request.user?.monthlyIncome ?? 'ไม่ระบุ'}'),
                  Text(
                      'เวลาว่างต่อวัน : ${request.user?.freeTimePerDay ?? 'ไม่ระบุ'}'),
                  Text(
                      'ประเภทที่อยู่อาศัย : ${request.user?.typeOfResidence ?? 'ไม่ระบุ'}'),
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
                        : request.status == 'declined'
                            ? Colors.red
                            : Colors.black,
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
