import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class AdoptionHistoryView extends StatefulWidget {
  const AdoptionHistoryView({Key? key}) : super(key: key);

  @override
  _AdoptionHistoryViewState createState() => _AdoptionHistoryViewState();
}

class _AdoptionHistoryViewState extends State<AdoptionHistoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('ประวัติการขอรับอุปการะ',
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
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent('ทั้งหมด'),
                _buildTabContent('รอดำเนินการ'),
                _buildTabContent('ผ่านเกณฑ์'),
                _buildTabContent('ไม่ผ่านเกณฑ์'),
                _buildTabContent('ยกเลิก'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text('กลับไปที่หน้าหลัก',
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              onPressed: () => Get.toNamed('/home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFD54F),
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
}
