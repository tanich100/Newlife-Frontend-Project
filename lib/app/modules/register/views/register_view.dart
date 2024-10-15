import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/register/views/detail_adopt.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมัครสมาชิก',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTextField('อีเมล', controller.emailController),
                SizedBox(height: 16),
                _buildTextField('รหัสผ่าน', controller.passwordController),
                SizedBox(height: 16),

                // ปุ่มเลือกภาพโปรไฟล์
                ElevatedButton(
                  onPressed: () {
                    controller.pickImage(); // เรียกฟังก์ชัน pickImage
                  },
                  child: Text('เลือกรูปภาพโปรไฟล์'),
                ),
                SizedBox(height: 16),

                // แสดงภาพที่ผู้ใช้เลือก
                Obx(() {
                  return controller.profilePic.value != null
                      ? Image.file(
                          controller.profilePic.value!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : Text('ยังไม่ได้เลือกรูปภาพ');
                }),

                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    // เมื่อกรอกข้อมูลเสร็จแล้วให้ไปที่หน้า AdoptView
                    Get.to(AdoptView());
                  },
                  child: Text('ต่อไป'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      controller: controller,
    );
  }
}
