import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/modules/petsDetail/controllers/pets_detail_controller.dart';
import 'package:newlife_app/app/modules/petsDetail/views/confirm_dialog.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PetsDetailView extends GetView<PetsDetailController> {
  const PetsDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final post = controller.post.value;
        if (post == null) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPetImage(),
                SizedBox(height: 20),
                _buildPetTypeTag(),
                SizedBox(height: 16),
                _buildPetInfoHeader(),
                SizedBox(height: 16),
                _buildPetLocation(),
                SizedBox(height: 20),
                _buildPetDescription(),
                SizedBox(height: 50),
                _buildControls(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPetImage() {
    return Column(
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
                    '${AppUrl.baseUrl}${controller.post.value is FindOwnerPost ? AppUrl.findOwnerPosts : AppUrl.adoptionPosts}${controller.post.value is FindOwnerPost ? AppUrl.findOwnerPostImage : AppUrl.image}/$imageUrl';
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
        Obx(() {
          if (controller.images.length > 1) {
            return SmoothPageIndicator(
              controller: PageController(
                  initialPage: controller.currentImageIndex.value),
              count: controller.images.length,
              effect: ScrollingDotsEffect(
                dotWidth: 8.0,
                dotHeight: 8.0,
                activeDotColor: Color.fromARGB(255, 239, 190, 31),
                dotColor: Colors.grey,
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ],
    );
  }

  Widget _buildPetTypeTag() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildTagBox(Icons.pets, controller.animalType.value),
            SizedBox(width: 10),
            _buildTagBox(Icons.face, controller.post.value?.sex ?? 'ไม่ระบุ'),
          ],
        ),
        Obx(() => _buildFavoriteButton()),
      ],
    );
  }

  Widget _buildFavoriteButton() {
    return InkWell(
      onTap: controller.toggleFavorite,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 239, 190, 31),
          shape: BoxShape.circle,
        ),
        child: Icon(
          controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
          color: controller.isFavorite.value ? Colors.red : Colors.black,
          size: 30,
        ),
      ),
    );
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
    String name = controller.post.value.name ?? 'ไม่ระบุชื่อ';
    String age = controller.post.value is AdoptionPost
        ? '(${(controller.post.value as AdoptionPost).age ?? 'ไม่ระบุ'} เดือน)'
        : '';
    String status = controller.post.value is AdoptionPost
        ? (controller.post.value as AdoptionPost).adoptionStatus ??
            'ยังไม่ได้รับอุปการะ'
        : controller.post.value.postStatus ?? 'ตามหาเจ้าของ';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: RichText(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                text: TextSpan(
                  style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: [
                    TextSpan(text: '$name $age '),
                    TextSpan(
                      text: 'สถานะ: ',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: status,
                      style: Theme.of(Get.context!)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(
                              fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 18, color: Colors.black87),
            children: [
              TextSpan(
                text: 'สายพันธุ์: ',
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text: controller.breedName.value,
                  style: Theme.of(Get.context!).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPetLocation() {
    String location = controller.post.value.addressDetails ?? 'ไม่ระบุที่อยู่';
    return Row(
      children: [
        Icon(Icons.location_on_sharp, color: Colors.red.shade500, size: 25),
        SizedBox(width: 4),
        Expanded(
          child: Text(location),
        ),
      ],
    );
  }

  Widget _buildPetDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'รายละเอียด',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(controller.post.value.description ?? 'ไม่มีคำอธิบายเพิ่มเติม'),
      ],
    );
  }

  Widget _buildControls() {
    if (controller.post.value is AdoptionPost) {
      return Center(
        child: SizedBox(
          width: 250,
          height: 60,
          child: ElevatedButton(
            child: Text(
              'ต้องการอุปการะ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onPressed: () async {
              final result = await Get.dialog<bool>(
                ConfirmDialogView(
                    petName: controller.post.value.name ?? 'สัตว์เลี้ยง'),
                barrierDismissible: false,
              );

              if (result == true) {
                controller.sendAdoptionRequest();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 244, 204, 47),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  void _showConfirmDialog() async {
    final result = await Get.dialog<bool>(
      ConfirmDialogView(petName: controller.post.value.name ?? 'สัตว์เลี้ยง'),
      barrierDismissible: false,
    );

    if (result == true) {
      controller.sendAdoptionRequest();
    }
  }
}
