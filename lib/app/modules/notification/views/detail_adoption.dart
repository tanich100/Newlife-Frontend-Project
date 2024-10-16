import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newlife_app/app/data/user_data.dart';
import 'package:newlife_app/app/modules/notification/views/confirm_dialog.dart';

class DetailAdoption extends StatelessWidget {
  final int requestId;

  DetailAdoption({required this.requestId});

  @override
  Widget build(BuildContext context) {
    // เรียกใช้ฟังก์ชันดึงข้อมูลคำขอรับเลี้ยงโดยใช้ requestId
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดผู้ขอรับเลี้ยง',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder(
        future: fetchAdoptionRequestDetails(
            requestId), // ฟังก์ชันดึงข้อมูลจาก requestId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else {
            final requestDetails = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ชื่อ: ${requestDetails.name}'),
                  Text('เพศ: ${requestDetails.gender}'),
                  Text('อายุ: ${requestDetails.age}'),
                  Text('ที่อยู่: ${requestDetails.address}'),
                  // เพิ่มข้อมูลตามที่ต้องการแสดง
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<dynamic> fetchAdoptionRequestDetails(int requestId) async {
    // เรียกใช้ API ที่ดึงข้อมูลคำขอรับเลี้ยงจาก requestId
    // Return ข้อมูลคำขอรับเลี้ยง
  }
}
