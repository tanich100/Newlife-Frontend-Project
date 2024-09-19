import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import '../controllers/camera_controller.dart';
import 'package:image_picker/image_picker.dart';

class CameraView extends GetView<CameraControllerX> {
  const CameraView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (!controller.isCameraInitialized.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          // เต็มหน้าจอ
          fit: StackFit.expand,
          children: [
            CameraPreview(controller.cameraController),
            _buildOverlay(),
            _buildControls(),
          ],
        );
      }),
    );
  }

  Widget _buildOverlay() {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.toNamed('/home'),
               
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 180,

        // บาง
        color: Colors.black.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildImagePicker(),
            _buildCaptureButton(),
            _buildFlashButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    return Container(
      width: 85,
      height: 85,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 16, 15, 15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      // TODO: Replace with actual thumbnail
      child: const Icon(Icons.image, color: Colors.white),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImages,
      child: Obx(() => Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 16, 15, 15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white),
        ),
        child: controller.selectedImages.isEmpty
            ? const Icon(Icons.image, color: Colors.white)
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  controller.selectedImages.first,
                  fit: BoxFit.cover,
                ),
              ),
      )),
    );
  }

  Widget _buildCaptureButton() {
    return GestureDetector(
      onTap: _takePicture,
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

 Widget _buildFlashButton() {
  final CameraControllerX cameraController = Get.find<CameraControllerX>();

  return Obx(() => IconButton(
    icon: Icon(
      cameraController.isFlashOn.value ? Icons.flash_on : Icons.flash_off,
      color: Colors.white,
      size: 30,
    ),
    onPressed: () {
      cameraController.toggleFlash();
    },
  ));
}

   void _takePicture() async {
    try {
      final image = await controller.cameraController.takePicture();
      Get.snackbar('Success', 'Picture saved to ${image.path}');
      // TODO: Handle captured image
    } catch (e) {
      Get.snackbar('Error', 'Failed to take picture: $e');
    }
  }

  void _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      if (images.length + controller.selectedImages.length > 5) {
        Get.snackbar('แจ้งเตือน', 'คุณสามารถเลือกรูปได้สูงสุด 5 รูป');
        return;
      }
      controller.addSelectedImages(images);
    }
  }
}


