import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/user_data.dart';
import 'package:newlife_app/app/modules/notification/views/detail_adoption.dart';

class adoptionRequest extends StatelessWidget {
  const adoptionRequest({Key? key}) : super(key: key);

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
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Center(
              child: Text(
                'จัดอันดับผู้ขอรับเลี้ยงของ น้องดำ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16),
            ...adoptionRequests.map((userData) => Column(
              children: [
                AdopterCard(
                  userData: userData,
                  onTap: () => Get.to(() => DetailAdoption(userData: userData)),
                ),
                SizedBox(height: 16),
              ],
            )).toList(),
          ],
        ),
      ),
    );
  }
}

class AdopterCard extends StatelessWidget {
  final UserData userData;
  final VoidCallback onTap;

  const AdopterCard({
    Key? key,
    required this.userData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
       child:  Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Text(
              '${userData.rank}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 16),
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://via.placeholder.com/60'),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userData.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text('รายได้ต่อเดือน : ${userData.income}'),
                  Text('เวลาว่างต่อวัน : ${userData.free_time_per_day}'),
                  Text('ประเภทที่อยู่อาศัย : ${userData.type_of_residence}'),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
