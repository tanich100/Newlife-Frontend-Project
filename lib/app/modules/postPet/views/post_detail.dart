import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/promote/views/promote_view.dart';

import 'confirm_dialog.dart';

class PostDetail extends StatefulWidget {
  const PostDetail({Key? key}) : super(key: key);

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  bool isFavorite = false;

  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFFFD54F),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.more_horiz, color: Colors.black),
              onPressed: () {
                Get.bottomSheet(
                  SettingsMenu(),
                  backgroundColor: Colors.transparent,
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPetImage(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPetTypeTag(),
                    SizedBox(height: 16),
                    _buildPetInfoHeader(),
                    SizedBox(height: 16),
                    _buildPetLocation(),
                    SizedBox(height: 20),
                    _buildPetDescription(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPetImage() {
    return Center(
      child: Container(
        width: 370,
        height: 350,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image(
            image: NetworkImage(
              'https://p16-va.lemon8cdn.com/tos-alisg-v-a3e477-sg/8120a94612554f8dac3c25f48ca214e7~tplv-tej9nj120t-origin.webp',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildPetTypeTag() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildTagBox(Icons.pets, 'แมว'),
            SizedBox(width: 10),
            _buildTagBox(Icons.female, 'เมีย'),
          ],
        ),
        _buildFavoriteButton(),
      ],
    );
  }

  Widget _buildFavoriteButton() {
    return InkWell(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isFavorite
              ? Color.fromARGB(255, 239, 190, 31)
              : Color.fromARGB(255, 239, 190, 31),
          shape: BoxShape.circle,
        ),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          color: isFavorite ? Colors.red : Colors.black,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildTagBox(IconData icon, String text) {
    return Container(
      width: 120,
      height: 40,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26), // ลดขนาด icon ลงเล็กน้อย
          SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetInfoHeader() {
    return Row(
      children: [
        Text(
          'โลร่า',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          '(8 เดือน)',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Container(
          child: Text(
            'สถานะ:',
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          'ยังไม่ได้รับอุปการะ',
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildPetLocation() {
    return Row(
      children: [
        Icon(Icons.location_on_sharp, color: Colors.red.shade500, size: 25),
        SizedBox(width: 4),
        Expanded(
          child: Text('คอนโดภูเก็ตทาวน์ ต.รัษฎา อ.เมืองภูเก็ต จ.ภูเก็ต'),
        ),
      ],
    );
  }

  Widget _buildPetDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'รายละเอียด',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'น้องเป็นแมวที่ขี้อ้อนมาก เป็นแมวที่ชอบเล่นขี้เล่นพอสมควรอยู่ไม่นิ่งเลยค่ะ ชอบกินขนมแมวมาก ชอบเป็นที่รักคนและขี้อ้อนมาก ๆ',
        ),
      ],
    );
  }

  void _showConfirmDialog() async {
    final result = await Get.dialog<bool>(
      ConfirmDialogView(petName: 'โลร่า'),
      barrierDismissible: false,
    );

    if (result == true) {
      // TODO: Add logic for confirming adoption
      Get.snackbar(
        'สำเร็จ',
        'คุณได้ยืนยันการอุปการะน้องโลร่าแล้ว',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class SettingsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFACD58),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          _buildMenuItem(Icons.edit, 'แก้ไขโพสต์', () {}),
          SizedBox(height: 10),
          _buildMenuItem(Icons.delete, 'ลบโพสต์', () {}),
          SizedBox(height: 10),
          _buildMenuItem(
              Icons.fireplace, 'โปรโมทโพส', () => Get.to(PromoteView())),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFFF5B73E),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Color(0xFF4D4D4D)),
      ),
      title: Text(text),
      onTap: () {
        Get.back();
        onTap();
      },
    );
  }
}
