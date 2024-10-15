import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/postPet/controllers/post_pet_controller.dart';
import 'package:newlife_app/app/modules/postPet/views/add_images.dart';
import 'package:newlife_app/app/modules/postPet/views/new_post_detail_page.dart';

class NewPostPage extends StatelessWidget {
  final String postType;
  final PostPetController controller = Get.find<PostPetController>();

  //สร้าง GlobalKey สำหรับควบคุมสถานะของ Form
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _phoneController = TextEditingController();
  final _lineIdController = TextEditingController();

  NewPostPage({Key? key, required this.postType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Text('โพสต์ใหม่',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://ae-pic-a1.aliexpress-media.com/kf/Sd2a617eb4fd54862b20b2e7a4dae68efs.jpg_640x640Q90.jpg_.webp',
                          ),
                          radius: 20,
                        ),
                        SizedBox(width: 8),
                        Text('คาริน่า ถนอมญาติ',
                            style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.only(left: 49),
                      child: Row(
                        children: [
                          Container(
                            width: 240,
                            height: 40,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(postType),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: controller.isMaxImagesSelected
                                ? null
                                : () => controller.pickImages(),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                Icons.add_photo_alternate,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    AddImages(maxImages: 5),
                    SizedBox(height: 16),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _descriptionController,
                                maxLines: 8,
                                maxLength: 100, // จำกัดไม่เกิน 500 ตัวอักษร
                                decoration: InputDecoration(
                                  hintText: 'คุณกำลังคิดอะไร',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกรายละเอียดของโพสต์'; // ถ้าไม่กรอกอะไร ให้แสดงข้อความแจ้งเตือน
                                  }
                                  return null; // ถ้าข้อมูลถูกต้อง ให้คืนค่า null
                                },
                              ),
                              SizedBox(height: 20),
                              Container(
                                alignment:
                                    Alignment.centerLeft, // จัดให้อยู่ซ้ายสุด
                                child: Text('ช่องทางการติดต่อ',
                                    style: TextStyle(fontSize: 17)),
                              ),
                              SizedBox(height: 8),
                              Column(
                                children: [
                                  TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // จำกัดให้กรอกเฉพาะตัวเลข
                                    ],
                                    decoration: InputDecoration(
                                      hintText: 'เบอร์โทรศัพท์',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'กรุณากรอกเบอร์โทรศัพท์';
                                      } else if (value.length != 10 ||
                                          !RegExp(r'^[0-9]+$')
                                              .hasMatch(value)) {
                                        return 'กรุณากรอกเบอร์โทร 10 หลักให้ถูกต้อง';
                                      }
                                      return null; // ถ้าข้อมูลถูกต้อง ให้คืนค่า null
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              TextFormField(
                                decoration: InputDecoration(
                                  hintText: '@ID Line',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  child: Text('ขั้นตอนต่อไป',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD54F),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    // ตรวจสอบการ validate ของฟอร์มก่อนเปลี่ยนหน้า
                    if (_formKey.currentState!.validate()) {
                      Get.to(() => NewPostPageDetail(selectedType: postType));
                    }
                  }

                  // Get.to(() => NewPostPageDetail(selectedType: postType)),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
