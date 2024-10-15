import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:newlife_app/app/modules/postPet/controllers/post_pet_controller.dart';

class AddImages extends StatelessWidget {
  final int maxImages;
  final PostPetController controller = Get.find<PostPetController>();
  final Function(bool) onUpdateStatus;

  AddImages({Key? key, this.maxImages = 10, required this.onUpdateStatus})
      : super(key: key);

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('เพิ่มรูปภาพ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: Obx(() => GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(16),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemCount: controller.selectedImages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == controller.selectedImages.length) {
                            return _addPhotoButton();
                          }
                          return _imageItem(index);
                        },
                      )),
                ),
                TextButton(
                  child: Text('บันทึก'),
                  onPressed: () async {
                    // เรียกใช้ฟังก์ชันบันทึกรูปภาพทันที
                    await controller.saveImages();
                    Get.snackbar('สำเร็จ', 'บันทึกรูปภาพเรียบร้อยแล้ว');
                    Navigator.of(context).pop(); // ปิด dialog
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _addPhotoButton() {
    return GestureDetector(
      onTap: controller.isMaxImagesSelected
          ? null
          : controller.pickImages, // เรียกใช้ฟังก์ชันเลือกภาพจาก controller
      child: Container(
        color: Colors.grey[300],
        child: Icon(
          Icons.add_a_photo,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _imageItem(int index) {
    return Stack(
      children: [
        Image.file(
          controller.selectedImages[index],
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
               controller.removeImage(index);
            // ตรวจสอบว่ามีภาพเหลืออยู่หรือไม่
            if (controller.selectedImages.isEmpty) {
              onUpdateStatus(false); // อัปเดตสถานะให้ไม่มีภาพ
            } else {
              onUpdateStatus(true); // อัปเดตสถานะว่ามีภาพอยู่
            }
            }, // เรียกใช้ฟังก์
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.white,
        //     side: BorderSide(color: Colors.grey),
        //     padding:
        //         EdgeInsets.all(12),
        //   ),
        //   onPressed: controller.isMaxImagesSelected
        //       ? null
        //       : () => _showImagePickerDialog(context),
        //   child: Icon(
        //     Icons.add_photo_alternate,
        //     color: Colors.black,
        //   ),
        // ),
        // SizedBox(height: 8),
        // Obx(() => Text('${controller.selectedImages.length} รูปที่เลือก')),
        // SizedBox(height: 16),

        // แสดงรูปภาพที่เลือก
        Obx(() => GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: controller.selectedImages.length,
              itemBuilder: (context, index) {
                return _imageItem(index);
              },
            )),
      ],
    );
  }
}
