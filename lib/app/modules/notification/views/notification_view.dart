import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';

class NotificationView extends StatelessWidget {
  String _selectedType = 'ประกาศหาผู้รับเลี้ยง';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,  
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.0), 
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),

            title: Text(
              'การแจ้งเตือน',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            elevation: 0,
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black, 
              indicatorWeight: 3.0, 
              tabs: [
                Tab(text: 'การแจ้งเตือน'),
                Tab(text: 'คำขอรับเลี้ยง'),
                Tab(text: 'การขอรับเลี้ยง'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('พีท')),  
            Center(child: Text('หล่อ')),  
            Center(child: Text('มาก')),  
          ],
        ),
        bottomNavigationBar: CustomBottomNavBar(),
      ),
      
    );
  }
  Widget _buildRadioListTile(
      {required String title, required String value, required IconData icon}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

 