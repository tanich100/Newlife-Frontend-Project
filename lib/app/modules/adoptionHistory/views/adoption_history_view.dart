import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/adoptionHistory/controllers/adoption_history_controller.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';

class AdoptionHistoryView extends GetView<AdoptionHistoryController> {
  AdoptionHistoryView({Key? key}) : super(key: key);

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
          title: Text('ประวัติการขอรับอุปการะ',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFFFFD54F),
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.symmetric(horizontal: 16),
                tabs: [
                  Tab(text: 'ทั้งหมด'),
                  Tab(text: 'รอดำเนินการ'),
                  Tab(text: 'ผ่านเกณฑ์'),
                  Tab(text: 'ไม่ผ่านเกณฑ์'),
                  Tab(text: 'ยกเลิก'),
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
                  children: [
                    _buildTabContent('ทั้งหมด'),
                    _buildTabContent('รอดำเนินการ'),
                    _buildTabContent('ผ่านเกณฑ์'),
                    _buildTabContent('ไม่ผ่านเกณฑ์'),
                    _buildTabContent('ยกเลิก'),
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(16.0),
              //   child: ElevatedButton(
              //     child: Text('กลับไปที่หน้าหลัก',
              //         style: TextStyle(color: Colors.black, fontSize: 16)),
              //     onPressed: () => Get.toNamed('/home'),
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
      ),
    );
  }
}

Widget _buildTabContent(String tabName) {
  return ListView(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    children: [
      if (tabName == 'ทั้งหมด' || tabName == 'ผ่านเกณฑ์')
        _buildAdoptionCard(
          name: 'ชนาธิป หลักแหลม',
          status: 'ผ่านเกณฑ์',
          date: '26/06/67',
        ),
    ],
  );
}

Widget _buildAdoptionCard({
  required String name,
  required String status,
  required String date,
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
                'https://t4.ftcdn.net/jpg/09/13/64/57/360_F_913645734_uaYTFPqd8vMv48NzmQlgBUISr2aIHR5K.jpg'),
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
                Text('รายได้ต่อเดือน : 30,000'),
                Text('เวลาว่างต่อวัน : 6-8 ช.ม.'),
                Text('ประเภทที่อยู่อาศัย : บ้านเดี่ยว'),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min, // Added to tighten the column
            children: [
              Text(date),
              SizedBox(height: 4),
              Text(status, style: TextStyle(color: Colors.green)),
            ],
          ),
        ],
      ),
    ),
  );
}
