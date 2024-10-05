import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:newlife_app/app/data/user_data.dart';

class DetailAdoption extends StatelessWidget {
  final UserData userData;

  const DetailAdoption({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 234, 212, 110),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 25,
                ),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        ),
        title: Text('รายละเอียดผู้ขอรับเลี้ยง',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: DefaultTextStyle(
        style: TextStyle(fontSize: 16, color: Colors.black,),
        child: Padding(
          padding: EdgeInsets.only(left: 40, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('อันดับ: ${userData.rank}'),
              SizedBox(height: 8),
              Text('ชื่อ : ${userData.name}'),
              SizedBox(height: 8),
              Text('เพศ : ${userData.gender}'),
              SizedBox(height: 8),
              Text('อายุ : ${userData.age}'),
              SizedBox(height: 8),
              Text('email : ${userData.email}'),
              SizedBox(height: 8),
              Text('เบอร์โทร : ${userData.tel}'),
              SizedBox(height: 8),
              Text('อาชีพ : ${userData.career}'),
              SizedBox(height: 8),
              Text('จำนวนสมาชิกในครอบครัว : ${userData.num_of_fam_members}'),
              SizedBox(height: 8),
              Text('รายได้ต่อเดือน : ${userData.income}'),
              SizedBox(height: 8),
              Text('ขนาดที่อยู่อาศัย : ${userData.size_of_residence}'),
              SizedBox(height: 8),
              Text('ประสบการณ์ : ${userData.experience}'),
              SizedBox(height: 8),
              Text('ประเภทที่อยู่อาศัย : ${userData.type_of_residence}'),
              SizedBox(height: 8),
              Text('เวลาว่างต่อวัน : ${userData.free_time_per_day}'),
            ],
          ),
        ),
      ),
    );
  }
}
