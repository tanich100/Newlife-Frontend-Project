import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/register/views/detail_adopt.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('สมัครสมาชิก',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
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
                    controller.pickImage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 240, 174),
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Color(0xfffdcf09), width: 1),
                  ),
                  child: Text(
                    'เลือกรูปภาพโปรไฟล์',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // ปรับความหนาของข้อความ
                    ),
                  ),
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

                SizedBox(
                    width: 300,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdoptView()),
                        );
                        Get.to(AdoptView());
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(Color(0xfffdcf09)),
                        foregroundColor: WidgetStateProperty.all(Colors.black),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Color(0xfffdcf09)),
                          ),
                        ),
                      ),
                      child: Text(
                        'ต่อไป',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ))
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 20), // ปรับ vertical padding
      ),
      controller: controller,
    );
  }
}
