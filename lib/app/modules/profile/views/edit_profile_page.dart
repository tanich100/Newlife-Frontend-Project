import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController(text: 'คาริน่า');
  final _surnameController = TextEditingController(text: 'ถนอมญาติ');
  final _phoneController = TextEditingController(text: '0911111111');
  final _addressController = TextEditingController(
      text: 'หอพักเทาทอง1 ต.แสนสุข อ.เมืองชลบุรี จ.ชลบุรี');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขโปรไฟล์'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Color(0xFFD9D9D9),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(
                        'https://ae-pic-a1.aliexpress-media.com/kf/Sd2a617eb4fd54862b20b2e7a4dae68efs.jpg_640x640Q90.jpg_.webp',
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            _buildTextField('ชื่อ', _nameController),
            SizedBox(height: 30),
            _buildTextField('นามสกุล', _surnameController),
            SizedBox(height: 30),
            _buildTextField('เบอร์ติดต่อ', _phoneController),
            SizedBox(height: 30),
            _buildTextField('ที่อยู่', _addressController),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                child: Text('บันทึก',
                    style: TextStyle(color: Colors.black, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFD54F),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                onPressed: () {
                  Get.toNamed('/profile');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
