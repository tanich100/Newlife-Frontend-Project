import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/postPet/controllers/post_pet_controller.dart';
import 'package:newlife_app/app/modules/postPet/views/new_post_page.dart';

class PostPetView extends GetView<PostPetController> {
  const PostPetView({super.key});

  @override
  Widget build(BuildContext context) {
    return PostTypeSelectionPage();
  }
}

class PostTypeSelectionPage extends StatefulWidget {
  @override
  _PostTypeSelectionPageState createState() => _PostTypeSelectionPageState();
}

class _PostTypeSelectionPageState extends State<PostTypeSelectionPage> {
  String _selectedType = 'ประกาศหาผู้รับเลี้ยง';

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
        title: Text('เลือกประเภทของโพสต์',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'ประเภทของโพสต์',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('รายการที่แนะนำ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 8),
              _buildRadioListTile(
                title: 'ประกาศหาผู้รับเลี้ยง',
                value: 'ประกาศหาผู้รับเลี้ยง',
                icon: Icons.favorite_border,
              ),
              _buildRadioListTile(
                title: 'ประกาศตามหาเจ้าของสัตว์เลี้ยง',
                value: 'ประกาศตามหาเจ้าของสัตว์เลี้ยง',
                icon: Icons.person_outline,
              ),
              _buildRadioListTile(
                title: 'ประกาศตามหาสัตว์หาย',
                value: 'ประกาศตามหาสัตว์หาย',
                icon: Icons.pets,
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('ขั้นตอนต่อไป',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD54F),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () =>
                      Get.to(() => NewPostPage(postType: _selectedType)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioListTile(
      {required String title, required String value, required IconData icon}) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        title: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black54),
            SizedBox(width: 12),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
        value: value,
        groupValue: _selectedType,
        onChanged: (String? newValue) {
          setState(() {
            _selectedType = newValue!;
          });
        },
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: Color(0xFFFFD54F),
      ),
    );
  }
}
