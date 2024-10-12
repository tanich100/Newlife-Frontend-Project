import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'confirm_dialog.dart';

class PetsDetailView extends StatefulWidget {
  const PetsDetailView({Key? key, required pet}) : super(key: key);

  @override
  _PetsDetailViewState createState() => _PetsDetailViewState();
}

class _PetsDetailViewState extends State<PetsDetailView> {
  bool isFavorite = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
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
                    SizedBox(height: 80),
                    _buildControls(),
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

  Widget _buildControls() {
    return Center(
      child: SizedBox(
        width: 250,
        height: 60,
        child: ElevatedButton(
          child: Text(
            'ต้องการอุปการะ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _showConfirmDialog(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 244, 204, 47),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
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
