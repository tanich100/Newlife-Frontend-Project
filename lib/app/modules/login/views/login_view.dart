import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

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
              child: Image(image: NetworkImage('images/Icon.jpg')),
            ),
          ),
          SizedBox(height: 30),
        Column(
  children: [
    buildCustomTextField(
      label: 'Email',
      prefixIcon: Icons.person,
    ),
    SizedBox(height: 25),
    buildCustomTextField(
      label: 'Password',
      prefixIcon: Icons.lock,
      isPassword: true,
    ),
  ],
),
          SizedBox(height: 100),
          Center(
            child: SizedBox(
              width: 300,
              height: 55,
              child: ElevatedButton(
                onPressed: () => Get.offAllNamed('/home'),
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
                  'Do not have an account? ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 121, 119, 119),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Text(
                    'Sign up',
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
            obscureText: isPassword,
            style: TextStyle(fontSize: 16, color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: label,
              hintStyle: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ),
        ),
        if (suffixIcon != null)
          Icon(suffixIcon, color: Colors.grey[400], size: 24),
        SizedBox(width: 16),
      ],
    ),
  );
}}