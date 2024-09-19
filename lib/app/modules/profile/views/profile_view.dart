import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                _buildHeader(),
                const SizedBox(height: 20),
                ProfileInfo(),
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
                PostView(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.toNamed('/home')),
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
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
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
          size: 35,
        ),
        onPressed: () => Get.toNamed('/post-pet'),
      ),
    );
  }
}

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                'คาริน่า ถนอมญาติ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PostView extends StatelessWidget {
  final List<String> imageUrls = [
    'https://cdn.ennxo.com/uploads/products/640/528fd47ecf3346f2993d73c7a62e3002.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1199px-Cat03.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return Image.network(
          imageUrls[index],
          fit: BoxFit.cover,
        );
      },
    );
  }
}

class SettingsMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFACD58),
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
              color: Colors.white,
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
            Get.offAllNamed('/login');
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
          color: Color(0xFFF5B73E),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Color(0xFF4D4D4D)),
      ),
      title: Text(text),
      onTap: () {
        Get.back();
        onTap();
      },
    );
  }
}
