import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:newlife_app/app/modules/notification/views/adoptionRequest.dart';
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
    // เรียกข้อมูลสำหรับแท็บแรก
    notificationController.getPostOwnerNotifications();
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
                  case 0: // แท็บ "แจ้งเตือน"
                    await notificationController.getRequesterNotifications();
                    break;
                  case 1: // แท็บ "คำขอรับเลี้ยง"
                    await notificationController
                        .getPostOwnerNotifications(); // ตรวจสอบให้แน่ใจว่าเรียก API ถูกต้อง
                    break;
                  case 2: // แท็บ "การขอรับเลี้ยง"
                    await notificationController.getRequesterNotifications();
                    break;
                }
              },
              tabs: [
                Tab(text: 'แจ้งเตือน'),
                Tab(
                    text:
                        'คำขอรับเลี้ยง'), // ควรดึง getPostOwnerNotifications()
                Tab(
                    text:
                        'การขอรับเลี้ยง'), // ควรดึง getRequesterNotifications()
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
                  _buildTabContent('แจ้งเตือน'),
                  _buildTabContent('คำขอรับเลี้ยง'),
                  _buildTabContent('การขอรับเลี้ยง'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildTabContent(String tabName) {
    if (tabName == 'แจ้งเตือน' ||
        tabName == 'คำขอรับเลี้ยง' ||
        tabName == 'การขอรับเลี้ยง') {
      return Obx(
        () => ListView.builder(
          itemCount: notificationController.notificationRequests.length,
          itemBuilder: (context, index) {
            final notification =
                notificationController.notificationRequests[index];
            print(
                "Displaying notification: ${notification.description}"); // ตรวจสอบข้อมูลที่แสดงในแต่ละการ์ด
            return _buildNotificationCard(
              name: notification.description,
              requestId: notification.requestId,
            );
          },
        ),
      );
    } else {
      return Center(child: Text('No content available'));
    }
  }

  Widget _buildNotificationCard(
      {required String name, required int requestId}) {
    return GestureDetector(
      onTap: () {
        // เมื่อกด "ดูข้อมูลเพิ่มเติม" ให้ไปยังหน้าแสดงรายละเอียดคำขอ
        Get.to(() => DetailAdoption(requestId: requestId));
      },
      child: Card(
        color: Color(0xFFFFD54F),
        margin: EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtn6gKRJ_Cx6faDUAqA5w_zyG_8jSwLe1ygA&s'),
                radius: 35,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
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
