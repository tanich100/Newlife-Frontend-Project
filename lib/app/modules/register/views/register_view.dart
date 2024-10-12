import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/register/views/detail_adopt.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  RxBool isshowPassword = false.obs;
  RxBool isshowConfirmPassword = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0), // ปรับความสูงตามต้องการ
        child: AppBar(
          title: Text(
            'สมัครสมาชิก',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Changed from stretch to center
              children: [
                _buildTextField('อีเมล', emailController),
                SizedBox(height: 40),
                _buildPasswordField(
                    'รหัสผ่าน', passwordController, isshowPassword),
                SizedBox(height: 40),
                _buildPasswordField('ยืนยันรหัสผ่าน', confirmpasswordController,
                    isshowConfirmPassword),
                SizedBox(height: 40),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(AdoptView());
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.yellow),
                      foregroundColor: WidgetStateProperty.all(Colors.black),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.yellow),
                        ),
                      ),
                    ),
                    child: Text(
                      'สมัครสมาชิก',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('มีบัญชีอยู่แล้ว?'),
                    TextButton(
                      onPressed: () => Get.toNamed('/login'),
                      child: Text('เข้าสู่ระบบ'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
  ) {
    return Container(
      width: 300, // กำหนดความกว้างที่ต้องการ
      height: 60, // กำหนดความสูงที่ต้องการ
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Color.fromARGB(255, 221, 221, 221),
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
      ),
    );
  }

  Widget _buildPasswordField(
      String label, TextEditingController controller, RxBool isshow) {
    return Obx(() {
      return Container(
        width: 300, // กำหนดความกว้างที่ต้องการ
        height: 60,
        child: TextFormField(
          // controller: controller,
          obscureText: !isshow.value,
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Color.fromARGB(255, 221, 221, 221),
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
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            suffixIcon: IconButton(
              icon: Icon(
                isshow.value ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                isshow.value = !isshow.value;
              },
            ),
          ),
        ),
      );
    });
  }
}
