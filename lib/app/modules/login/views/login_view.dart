import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  RxBool isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Center(
            child: Container(
              width: 300,
              height: 300,
              child: Image.asset('images/Icon.jpg'),
            ),
          ),
          SizedBox(height: 30),
          Column(
            children: [
              buildCustomTextField(
                label: 'อีเมล',
                prefixIcon: Icons.person,
                controller: controller.emailController,
              ),
              SizedBox(height: 25),
              Obx(() {
                return buildCustomTextField(
                  label: 'รหัสผ่าน',
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  controller: controller.passwordController,
                  suffixIcon: isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onSuffixIconPressed: () {
                    isPasswordVisible.value = !isPasswordVisible.value;
                  },
                  obscureText: !isPasswordVisible.value,
                );
              }),
            ],
          ),
          SizedBox(height: 100),
          Center(
            child: SizedBox(
              width: 300,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  controller.login(); // เรียกฟังก์ชัน login ที่ปรับปรุง
                },
                child: Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 232, 212, 36),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'คุณยังไม่มีบัญชี? ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 121, 119, 119),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed('/register'),
                  child: Text(
                    'สมัคร',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCustomTextField({
    required String label,
    required IconData prefixIcon,
    IconData? suffixIcon,
    bool isPassword = false,
    required TextEditingController controller,
    bool obscureText = false,
    VoidCallback? onSuffixIconPressed,
  }) {
    return Container(
      width: 350,
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 218, 215, 215),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 16),
          Icon(prefixIcon, color: const Color.fromARGB(255, 0, 0, 0), size: 24),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              obscureText: obscureText,
              style: TextStyle(fontSize: 16, color: Colors.black87),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
              controller: controller,
            ),
          ),
          if (suffixIcon != null)
            IconButton(
              icon: Icon(suffixIcon, color: Colors.black, size: 24),
              onPressed: onSuffixIconPressed,
            ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}
