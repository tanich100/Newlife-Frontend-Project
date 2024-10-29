import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialogView extends StatelessWidget {
  final String petName;

  const ConfirmDialogView({Key? key, required this.petName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 226, 184, 31),
      title: Center(child: Text('ยืนยันการอุปการะ')),
      content: Text('คุณต้องการอุปการะน้อง $petName ใช่หรือไม่?'),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: TextButton(
                child:
                    const Text('ยกเลิก', style: TextStyle(color: Colors.black)),
                onPressed: () => Get.back(result: false),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: TextButton(
                child:
                    const Text('ยืนยัน', style: TextStyle(color: Colors.black)),
                onPressed: () => Get.back(result: true),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
