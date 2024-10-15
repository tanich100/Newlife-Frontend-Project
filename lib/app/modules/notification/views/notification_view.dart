import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:newlife_app/app/modules/notification/views/adoptionRequest.dart';

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
    notificationController.getAdoptionRequestNotifications();
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
                print('Tab $index selected');
                switch (index) {
                  case 0:
                    print('แจ้งเตือน tapped');
                    break;
                  case 1:
                    print('คำขอรับเลี้ยง tapped');
                    // await notificationController.getAdoptionRequestNotifications();
                    _buildTabContent('คำขอรับเลี้ยง');
                    // _buildNotificationCard(
                    //   name: "Test",
                    // );
                    break;
                  case 2:
                    print('การขอรับเลี้ยง tapped');
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
    if (tabName == 'แจ้งเตือน') {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: List.generate(
          3,
          (index) {
            return _buildNotificationCard(
              name: 'แจ้งเตือน:',
            );
          },
        ),
      );
    } else if (tabName == 'คำขอรับเลี้ยง') {
      // Use FutureBuilder to fetch data asynchronously
      return FutureBuilder(
        future: notificationController.getAdoptionRequestNotifications(),
        builder: (context, snapshot) {
          // Check the status of the Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while fetching data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors that might occur
            return Center(child: Text('Error fetching data'));
          } else {
            // Data has been successfully fetched, display the list
            return Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: notificationController.notificationRequests.length,
                itemBuilder: (context, index) {
                  final notification =
                      notificationController.notificationRequests[index];
                  return _buildNotificationCard(
                    name: notification.description,
                  );
                },
              ),
            );
          }
        },
      );
    } else {
      return Center(child: Text('No content available'));
    }
  }

  Widget _buildNotificationCard({
    required String name,
  }) {
    return Card(
      color: Color(0xFFFFD54F),
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Changed to center
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
                mainAxisSize: MainAxisSize.min, // Added to tighten the column
                children: [
                  Text(name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('ดูข้อมูลเพิ่มเติม'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildAdoptionReq({
  required String name,
}) {
  return GestureDetector(
    onTap: () => Get.to(() => adoptionRequest()),
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('ดูข้อมูล'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
