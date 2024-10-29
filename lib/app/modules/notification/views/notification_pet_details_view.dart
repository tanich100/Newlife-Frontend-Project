import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/notification_adoption_request_model.dart';
import 'package:newlife_app/app/modules/notification/controllers/notification_controller.dart';

class NotificationPetDetailsView extends GetView<NotificationController> {
  const NotificationPetDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final notification = controller.selectedNotification.value;
        if (notification == null) {
          return Center(child: CircularProgressIndicator());
        }

        // Extract post details from either adoptionPost or adoptionRequest
        final postName = notification.adoptionPost?['name'] ??
            notification.adoptionRequest?.adoptionPost?.name ??
            'สัตว์เลี้ยง';

        final postImage = notification.adoptionPost?['image1'] ??
            notification.adoptionRequest?.adoptionPost?.image1;

        final isApproved = notification.status == 'accepted';

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildPetImage(postImage),
                SizedBox(height: 24),
                _buildStatusMessage(postName, isApproved),
                SizedBox(height: 50),
                _buildBackButton(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPetImage(String? imageUrl) {
    return Container(
      width: double.infinity,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: imageUrl != null
            ? Image.network(
                '${AppUrl.baseUrl}${AppUrl.adoptionPosts}${AppUrl.image}/$imageUrl',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Center(
                    child: Icon(Icons.pets, size: 100, color: Colors.grey),
                  );
                },
              )
            : Center(
                child: Icon(Icons.pets, size: 100, color: Colors.grey),
              ),
      ),
    );
  }

  Widget _buildStatusMessage(String petName, bool isApproved) {
    return Column(
      children: [
        Icon(
          isApproved ? Icons.check_circle : Icons.cancel,
          size: 60,
          color: isApproved ? Colors.green : Colors.red,
        ),
        SizedBox(height: 16),
        Text(
          isApproved
              ? 'คุณได้รับการอนุมัติให้อุปการะ'
              : 'คุณไม่ได้รับการอนุมัติให้อุปการะ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8),
        Text(
          petName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 8),
        Text(
          isApproved ? 'สำเร็จ' : 'ไม่สำเร็จ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: isApproved ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return SizedBox(
      width: 250,
      height: 60,
      child: ElevatedButton(
        onPressed: () => Get.until((route) => route.isFirst),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFD54F),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 2,
        ),
        child: Text(
          'กลับไปที่หน้าหลัก',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
