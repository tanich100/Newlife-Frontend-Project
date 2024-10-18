import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:newlife_app/app/modules/notification/views/detail_adoption.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  NotificationController notificationController =
      Get.put(NotificationController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    notificationController
        .getPostOwnerNotifications(); // Default to Post Owner Notifications
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('การแจ้งเตือน',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFFFFD54F),
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.symmetric(horizontal: 16),
              onTap: (index) async {
                switch (index) {
                  case 0: // All Notifications
                    await notificationController.getRequesterNotifications();
                    break;
                  case 1: // Post Owner Notifications
                    await notificationController.getPostOwnerNotifications();
                    break;
                  case 2: // Requester Notifications
                    await notificationController.getRequesterNotifications();
                    break;
                }
              },
              tabs: [
                Tab(text: 'แจ้งเตือน'),
                Tab(text: 'คำขอรับเลี้ยง'),
                Tab(text: 'การขอรับเลี้ยง'),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildTabContent('แจ้งเตือน',
                      isTappable: false), // Cannot tap on this tab
                  _buildTabContent('คำขอรับเลี้ยง',
                      isTappable: true), // Can tap on this tab
                  _buildTabContent('การขอรับเลี้ยง',
                      isTappable: false), // Cannot tap on this tab
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          CustomBottomNavBar(), // Bring back the custom bottom navbar
    );
  }

  Widget _buildTabContent(String tabName, {required bool isTappable}) {
    return Obx(
      () => ListView.builder(
        itemCount: notificationController.notificationRequests.length,
        itemBuilder: (context, index) {
          final notification =
              notificationController.notificationRequests[index];
          return _buildNotificationCard(
            name: notification.description,
            requestId: notification.requestId,
            isTappable: isTappable,
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard({
    required String name,
    required int requestId,
    required bool isTappable,
  }) {
    return GestureDetector(
      onTap: isTappable
          ? () {
              Get.to(() => DetailAdoption(notiAdopReqId: requestId));
            }
          : null,
      child: Card(
        color: Color(0xFFFFD54F),
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.notifications, size: 35),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text('ดูข้อมูลเพิ่มเติม'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
