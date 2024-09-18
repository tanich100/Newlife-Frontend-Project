import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../controllers/camera_controller.dart';

class CameraView extends GetView<CameraControllerX> {
  const CameraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera View'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: CameraPreview(controller.cameraController),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => _takePicture(),
                child: const Text('Take Picture'),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _takePicture() async {
    try {
      final image = await controller.cameraController.takePicture();
      Get.snackbar('Success', 'Picture saved to ${image.path}');
      // ทำอย่างอื่นกับรูปภาพตามต้องการ เช่น แสดงในหน้าใหม่
    } catch (e) {
      Get.snackbar('Error', 'Failed to take picture: $e');
    }
  }
}