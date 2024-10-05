import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/notification/views/adoptionRequest.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
            // Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: ElevatedButton(
            //     child: Text('กลับไปที่หน้าหลัก',
            //         style: TextStyle(color: Colors.black, fontSize: 16)),
            //     onPressed: () => Get.offNamed('/home'),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color(0xFFFFD54F),
            //       minimumSize: Size(double.infinity, 50),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildTabContent(String tabName) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        if (tabName == 'แจ้งเตือน')
          _buildNotificationCard(
            name: 'แจ้งเตือน:',
          ),
        if (tabName == 'คำขอรับเลี้ยง')
          _buildAdoptionReq(
            name: 'คำขอรับเลี้ยง:',
          ),
      ],
    );
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
