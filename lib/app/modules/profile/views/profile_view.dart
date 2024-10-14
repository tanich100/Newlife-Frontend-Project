import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/postPet/views/post_detail.dart';
import 'package:newlife_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:newlife_app/app/modules/profile/views/adoption_rule.dart';
import 'package:newlife_app/app/modules/profile/views/edit_profile_page.dart';
import 'package:newlife_app/app/modules/user/controllers/user_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      Get.bottomSheet(
                        SettingsMenu(),
                        backgroundColor: Colors.transparent,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                ProfileInfo(),
                SizedBox(height: 20),
                Center(child: Icon(Icons.pets, size: 30)),
                SizedBox(height: 8),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(height: 8),
                PostView(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  // Widget _buildHeader() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       IconButton(
  //           icon: const Icon(Icons.arrow_back_ios),
  //           onPressed: () => Get.toNamed('/home')),
  //       IconButton(
  //         icon: Icon(Icons.settings),
  //         onPressed: () {
  //           Get.bottomSheet(
  //             SettingsMenu(),
  //             backgroundColor: Colors.transparent,
  //           );
  //         },
  //       ),
  //     ],
  //   );
  // }

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

class ProfileInfo extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Center(
              child: const Text(
                'โปรไฟล์ของฉัน',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Color(0xFFD9D9D9),
                    backgroundImage: controller.profileImage.value.isNotEmpty
                        ? NetworkImage(
                            "http://10.0.2.2:5296/User/getImage/${controller.profileImage.value}")
                        : null,
                  ),
                  SizedBox(height: 10),
                  Text(
                    controller.userName.value,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class PostView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(), // Loading Indicator
        );
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: controller.userPosts.isEmpty
            ? Center(child: Text('ไม่มีโพสต์'))
            : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemCount: controller.userPosts.length,
                itemBuilder: (context, index) {
                  dynamic post = controller.userPosts[index];
                  String? imageUrl;
                  String imageEndpoint = '';

                  if (post is AdoptionPost) {
                    imageUrl = post.image1;
                    imageEndpoint = AppUrl.image;
                  } else if (post is FindOwnerPost) {
                    imageUrl = post.image1;
                    imageEndpoint = AppUrl.findOwnerPostImage;
                  }

                  return GestureDetector(
                    onTap: () {
                      controller.selectPost(post);
                      Get.to(() => PostDetail());
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: imageUrl != null
                              ? Image.network(
                                  '${AppUrl.baseUrl}${post is AdoptionPost ? AppUrl.adoptionPosts : AppUrl.findOwnerPosts}$imageEndpoint/$imageUrl',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Error loading image: $error');
                                    return Icon(Icons.error);
                                  },
                                )
                              : Icon(Icons.pets, size: 50),
                        ),
                      ],
                    ),
                  );
                },
              ),
      );
    });
  }
}

class SettingsMenu extends StatelessWidget {
  final ProfileController controller = Get.find<ProfileController>();

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
              Icons.edit, 'แก้ไขโปรไฟล์', () => Get.to(EditProfilePage())),
          SizedBox(height: 10),
          _buildMenuItem(Icons.pets, 'ประวัติการขอรับอุปการะ',
              () => Get.toNamed('/adoption-history')),
          SizedBox(height: 10),
          _buildMenuItem(Icons.house, 'ประวัติการอุปการะ',
              () => Get.toNamed('/adopted-history')),
          SizedBox(height: 10),
          _buildMenuItem(Icons.list_alt, 'ขั้นตอนการอุปการะ',
              () => Get.to(AdoptionRule())),
          SizedBox(height: 10),
          _buildMenuItem(Icons.exit_to_app, 'ออกจากระบบ', () {
            controller.logout();
          }),
          SizedBox(height: 10),
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
