import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/adoption_request_post.dart';
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
      ),
    );
  }

  Widget _buildRequestList(String tabStatus) {
    final filteredRequests = controller.getFilteredRequests(tabStatus);

    if (filteredRequests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'ไม่มีประวัติการขอรับเลี้ยงในสถานะ${_getStatusText(tabStatus)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: controller.fetchAdoptionHistory,
      child: ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: filteredRequests.length,
        itemBuilder: (context, index) {
          final request = filteredRequests[index];
          return _buildRequestCard(request);
        },
      ),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                child: request.adoptionPost?.image1 != null
                    ? Image.network(
                        request.adoptionPost!.image1 ?? '',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return Container(
                            color: Colors.grey[200],
                            child: Icon(Icons.pets,
                                color: Colors.grey[400], size: 30),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[200],
                        child:
                            Icon(Icons.pets, color: Colors.grey[400], size: 30),
                      ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (request.adoptionPost?.name != null)
                    Text(
                      '${request.adoptionPost!.name} (${request.adoptionPost!.age} เดือน)',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  if (request.adoptionPost?.breedId != null)
                    Text(
                      'สายพันธุ์: American Short Hair',
                      style: TextStyle(color: Colors.black87),
                    ),
                  if (request.reasonForAdoption.isNotEmpty)
                    Text(
                      'เหตุผล: ${request.reasonForAdoption}',
                      style: TextStyle(color: Colors.black87),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatDate(request.dateAdded),
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
                SizedBox(height: 4),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(request.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(request.status),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'waiting':
        return const Color.fromARGB(255, 243, 185, 99);
      case 'accepted':
        return const Color.fromARGB(255, 136, 193, 138);
      case 'declined':
        return const Color.fromARGB(255, 213, 123, 117);
      case 'cancelled':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'waiting':
        return 'รอดำเนินการ';
      case 'accepted':
        return 'ผ่านเกณฑ์';
      case 'declined':
        return 'ไม่ผ่านเกณฑ์';
      case 'cancelled':
        return 'ยกเลิก';
      default:
        return status ?? '';
    }
  }
}
