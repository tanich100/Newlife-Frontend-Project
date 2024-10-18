import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:newlife_app/app/modules/notification/views/confirm_dialog.dart';

class DetailAdoption extends StatelessWidget {
  final int notiAdopReqId;
  final NotificationController notificationController =
      Get.put(NotificationController());

  DetailAdoption({required this.notiAdopReqId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายละเอียดผู้ขอรับเลี้ยง',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder(
        future: notificationController
            .fetchAdoptionRequestDetails(notiAdopReqId), // ใช้ notiAdopReqId
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาดในการดึงข้อมูล'));
          } else if (snapshot.hasData) {
            final requestDetails = snapshot.data as Map<String, dynamic>?;

            if (requestDetails != null && requestDetails['user'] != null) {
              final user = requestDetails['user'];
              String profilePicUrl =
                  'http://10.0.2.2:5296/User/getImage/${user['profilePic']}';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (user['profilePic'] != null)
                      Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(profilePicUrl),
                          onBackgroundImageError: (_, __) {
                            print("Error loading profile image");
                          },
                        ),
                      ),
                    SizedBox(height: 16),
                    Text('ชื่อ: ${user['name'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 8),
                    Text('อีเมล: ${user['email'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 8),
                    Text('อายุ: ${user['age'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 8),
                    Text('เบอร์โทร: ${user['tel'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 8),
                    Text('อาชีพ: ${user['career'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 8),
                    Text(
                        'จำนวนสมาชิกในครอบครัว: ${user['numOfFamMembers'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 8),
                    Text(
                        'ประสบการณ์ในการเลี้ยงสัตว์: ${user['isHaveExperience'] == true ? "มี" : "ไม่มี"}'),
                    SizedBox(height: 8),
                    Text(
                        'ขนาดที่อยู่อาศัย: ${user['sizeOfResidence'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 8),
                    Text(
                        'ประเภทที่อยู่อาศัย: ${user['typeOfResidence'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 8),
                    Text(
                        'เวลาว่างต่อวัน: ${user['freeTimePerDay'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 8),
                    Text(
                        'รายได้ต่อเดือน: ${user['monthlyIncome'] ?? 'ไม่ระบุ'}'),
                    SizedBox(height: 16),

                    // ปุ่มอนุมัติและไม่อนุมัติ แสดงเป็นไอคอนติ้กถูกและกากบาท
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          iconSize: 40,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmDialog(
                                  title: 'อนุมัติ',
                                  name: user['name'] ?? 'ไม่ระบุ',
                                  onConfirm: () {
                                    notificationController.approveRequest(
                                        notiAdopReqId); // เรียกใช้ฟังก์ชันการอนุมัติ
                                  },
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.red),
                          iconSize: 40,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ConfirmDialog(
                                  title: 'ไม่อนุมัติ',
                                  name: user['name'] ?? 'ไม่ระบุ',
                                  onConfirm: () {
                                    notificationController.denyRequest(
                                        notiAdopReqId); // เรียกใช้ฟังก์ชันการไม่อนุมัติ
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('ไม่มีข้อมูลที่พร้อมใช้งาน'));
            }
          } else {
            return Center(child: Text('ไม่มีข้อมูลที่พร้อมใช้งาน'));
          }
        },
      ),
    );
  }
}
