import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/petsDetail/controllers/pets_detail_controller.dart';

class ConfirmDialogView extends StatelessWidget {
  final String petName;

  const ConfirmDialogView({Key? key, required this.petName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PetsDetailController controller = Get.find();
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 226, 184, 31),
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
                child: Text('ยกเลิก', style: TextStyle(color: Colors.black)),
                onPressed: () => Get.back(result: false),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ),
            SizedBox(width: 8),
            Container(
              width: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Obx(() => TextButton(
                    child:
                        Text('ยืนยัน', style: TextStyle(color: Colors.black)),
                    onPressed: controller.isRequestButtonEnabled.value
                        ? () => Get.back(result: true)
                        : null,
                    style: TextButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
