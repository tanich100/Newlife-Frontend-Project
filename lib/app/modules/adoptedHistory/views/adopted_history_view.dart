import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/adopted_history_controller.dart';

class AdoptedHistoryView extends GetView<AdoptedHistoryController> {
  const AdoptedHistoryView({super.key});

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
          child: TabBarView(
            children: [
              _buildCatList('ทั้งหมด'),
              _buildCatList('รอดำเนินการ'),
              _buildCatList('ผ่านเกณฑ์'),
              _buildCatList('ไม่ผ่านเกณฑ์'),
              _buildCatList('ยกเลิก'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCatList(String tabStatus) {
    // This would typically come from your controller
    final List<Map<String, String>> cats = [
      {
        'name': 'น้องดำ',
        'age': '8 เดือน',
        'breed': 'สายพันธุ์ อเมริกัน ช็อตแฮร์',
        'status': 'รอดำเนินการ',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwuTO62uMD8fBBR9B2Eb1B1ABGDoZM9z680uYlkRL-FVxoy3Bk',
        'date': '26/06/67',
      },
      {
        'name': 'ไอร่า',
        'age': '8 เดือน',
        'breed': 'สายพันธุ์ อเมริกัน ช็อตแฮร์',
        'status': 'ผ่านเกณฑ์',
        'imageUrl':
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRV8in7G9Lie9O5hnZoa5h1Ose-HGXTv0zMjWobwsQUQmX6MJtd',
        'date': '26/06/67',
      },
    ];

    return ListView(
      padding: EdgeInsets.all(16),
      children: cats
          .where((cat) =>
              tabStatus == 'ทั้งหมด' ||
              cat['status'] == tabStatus ||
              (tabStatus == 'รอดำเนินการ' && cat['status'] == 'รอดำเนินการ') ||
              (tabStatus == 'ผ่านเกณฑ์' && cat['status'] == 'ผ่านเกณฑ์'))
          .map((cat) => Column(
                children: [
                  _buildCatCard(
                    name: cat['name']!,
                    age: cat['age']!,
                    breed: cat['breed']!,
                    status: cat['status']!,
                    imageUrl: cat['imageUrl']!,
                    date: cat['date']!,
                  ),
                  SizedBox(height: 16),
                ],
              ))
          .toList(),
    );
  }

  Widget _buildCatCard({
    required String name,
    required String age,
    required String breed,
    required String status,
    required String imageUrl,
    required String date,
  }) {
    return Card(
      color: Color(0xFFFFD54F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 30,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$name ($age)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(breed),
                  Text('วัคซีน ได้รับแล้ว'),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(date),
                Text(
                  status,
                  style: TextStyle(
                    color: status == 'ผ่านเกณฑ์' ? Colors.green : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
