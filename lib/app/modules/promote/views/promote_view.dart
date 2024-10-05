import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/promote/views/show_qr.dart';

class PromoteView extends StatefulWidget {
  const PromoteView({Key? key}) : super(key: key);

  @override
  _PromoteViewState createState() => _PromoteViewState();
}

class _PromoteViewState extends State<PromoteView> {
  int? selectedOption;
  final List<int> prices = [7, 49, 159];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Color(0xFFFFD54F),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
        title: const Text(
          'โปรโมทโพสต์',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPetImage(),
            const SizedBox(height: 20),
            _buildPromotionOption(0, '1 วัน', 'เพิ่มยอดเข้าชมโพสต์', '฿ 7'),
            _buildPromotionOption(1, '7 วัน', 'เพิ่มยอดเข้าชมโพสต์', '฿ 49'),
            _buildPromotionOption(2, '1 เดือน', 'เพิ่มยอดเข้าชมโพสต์', '฿ 159'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedOption != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowQrView(),
                        ),
                      );
                    }
                  : null,
              child: const Text('ชำระเงิน'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFFFD54F),
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
                disabledBackgroundColor: Colors.grey.withOpacity(0.12),
                minimumSize: const Size(200, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionOption(
      int index, String duration, String description, String price) {
    bool isSelected = selectedOption == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOption = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFD54F) : const Color(0xFFFFF9C4),
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: Colors.black, width: 2) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  duration,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: isSelected ? Colors.black : Colors.black87,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.black54 : Colors.grey,
                  ),
                ),
              ],
            ),
            Text(
              price,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: isSelected ? Colors.black : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
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
