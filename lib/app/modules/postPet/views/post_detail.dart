import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/promote/views/promote_view.dart';
import 'package:newlife_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'confirm_dialog.dart';

class PostDetail extends GetView<ProfileController> {
  final RxBool isFavorite = false.obs;
  PostDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFFFD54F),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.more_horiz, color: Colors.black),
              onPressed: () {
                Get.bottomSheet(
                  SettingsMenu(),
                  backgroundColor: Colors.transparent,
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPetImage(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPetTypeTag(),
                    SizedBox(height: 16),
                    _buildPetInfoHeader(),
                    SizedBox(height: 16),
                    _buildPetLocation(),
                    SizedBox(height: 20),
                    _buildPetDescription(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPetImage() {
    return Obx(() => Column(
          children: [
            Container(
              width: 370,
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView.builder(
                  controller: PageController(),
                  itemCount: controller.images.length,
                  onPageChanged: (index) =>
                      controller.currentImageIndex.value = index,
                  itemBuilder: (context, index) {
                    String imageUrl = controller.images[index];
                    String fullUrl =
                        '${AppUrl.baseUrl}${controller.selectedPost.value is FindOwnerPost ? AppUrl.findOwnerPosts : AppUrl.adoptionPosts}${controller.selectedPost.value is FindOwnerPost ? AppUrl.findOwnerPostImage : AppUrl.image}/$imageUrl';
                    return Image.network(
                      fullUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print('Error loading image: $error');
                        return Icon(Icons.error, size: 100);
                      },
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            if (controller.images.length > 1)
              SmoothPageIndicator(
                controller: PageController(
                    initialPage: controller.currentImageIndex.value),
                count: controller.images.length,
                effect: ScrollingDotsEffect(
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  activeDotColor: Color.fromARGB(255, 239, 190, 31),
                  dotColor: Colors.grey,
                ),
              ),
          ],
        ));
  }

  Widget _buildPetTypeTag() {
    return Obx(() {
      String animalType = controller.animalType.value;
      String breedName = controller.breedName.value;
      String gender = controller.selectedPost.value?.sex ?? 'ไม่ระบุ';

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildTagBox(Icons.pets, animalType),
                  SizedBox(width: 10),
                  _buildTagBox(
                      gender.toLowerCase() == 'male'
                          ? Icons.male
                          : Icons.female,
                      gender),
                ],
              ),
              _buildFavoriteButton(),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'สายพันธุ์: $breedName',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      );
    });
  }

  Widget _buildFavoriteButton() {
    return Obx(() => InkWell(
          onTap: () {
            isFavorite.toggle();
            Get.snackbar(
              'Favorite',
              isFavorite.value
                  ? 'Added to favorites'
                  : 'Removed from favorites',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 239, 190, 31),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite.value ? Icons.favorite : Icons.favorite_border,
              color: isFavorite.value ? Colors.red : Colors.black,
              size: 30,
            ),
          ),
        ));
  }

  Widget _buildTagBox(IconData icon, String text) {
    return Container(
      width: 120,
      height: 40,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.black,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 26),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetInfoHeader() {
    return Obx(() {
      String name = controller.selectedPost.value?.name ?? 'ไม่ระบุชื่อ';
      String age = controller.selectedPost.value is AdoptionPost
          ? '(${(controller.selectedPost.value as AdoptionPost).age ?? 'ไม่ระบุ'} เดือน)'
          : '';
      String status = controller.selectedPost.value is AdoptionPost
          ? (controller.selectedPost.value as AdoptionPost).adoptionStatus ??
              'ยังไม่ได้รับอุปการะ'
          : controller.selectedPost.value?.postStatus ?? 'ตามหาเจ้าของ';

      return Row(
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Text(
            age,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'สถานะ:',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  status,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPetLocation() {
    return Obx(() => Row(
          children: [
            Icon(Icons.location_on_sharp, color: Colors.red.shade500, size: 25),
            SizedBox(width: 4),
            Expanded(
              child: Text(controller.selectedPost.value?.addressDetails ??
                  'ไม่ระบุที่อยู่'),
            ),
          ],
        ));
  }

  Widget _buildPetDescription() {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'รายละเอียด',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              controller.selectedPost.value?.description ??
                  'ไม่มีคำอธิบายเพิ่มเติม',
            ),
          ],
        ));
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
          _buildMenuItem(Icons.edit, 'แก้ไขโพสต์', () {}),
          SizedBox(height: 10),
          _buildMenuItem(Icons.delete, 'ลบโพสต์', () {}),
          SizedBox(height: 10),
          _buildMenuItem(
              Icons.fireplace, 'โปรโมทโพส', () => Get.to(PromoteView())),
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
