import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Get.bottomSheet(
                          SettingsMenu(),
                          backgroundColor: Colors.transparent,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: const Text(
                    'โปรไฟล์ของฉัน',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xFFD9D9D9),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://ae-pic-a1.aliexpress-media.com/kf/Sd2a617eb4fd54862b20b2e7a4dae68efs.jpg_640x640Q90.jpg_.webp',
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'คารีน่า ถนอมญาติ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Center(child: Icon(Icons.pets, size: 30)),
                SizedBox(height: 8),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.3,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Image(
                          image: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                          child: Image(
                        image: NetworkImage(
                            'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xfffdcf09),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            // Add post functionality
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class SettingsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          _buildMenuItem(
              Icons.edit, 'แก้ไขโปรไฟล์', () => Get.toNamed('/edit-profile')),
          _buildMenuItem(Icons.pets, 'ประวัติการขออุปการะ',
              () => Get.toNamed('/adoption-history')),
          _buildMenuItem(Icons.house, 'ประวัติการอุปการะ',
              () => Get.toNamed('/adopted-history')),
          _buildMenuItem(Icons.volunteer_activism, 'ประวัติการบริจาคเงิน',
              () => Get.toNamed('/donation-history')),
          _buildMenuItem(Icons.list_alt, 'ขั้นตอนการอุปการะ',
              () => Get.toNamed('/adoption-process')),
          _buildMenuItem(Icons.exit_to_app, 'ออกจากระบบ', () {
            // Handle logout logic here
            Get.offAllNamed(
                '/login'); // Navigate to login page and remove all previous routes
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.amber,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(text),
      onTap: () {
        Get.back();
        onTap();
      },
    );
  }
}
