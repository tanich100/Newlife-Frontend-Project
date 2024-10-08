import 'dart:io';

import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraControllerX extends GetxController {
  late CameraController cameraController;
  RxBool isCameraInitialized = false.obs;
  RxBool isFlashOn = false.obs;


  final RxList<File> selectedImages = <File>[].obs;

   void disposeCamera() {
    if (cameraController.value.isInitialized) {
      cameraController.dispose();
    }
    isCameraInitialized.value = false;
  }

  void addSelectedImages(List<XFile> images) {
    final newImages = images.map((xFile) => File(xFile.path)).toList();
    selectedImages.addAll(newImages);
   if (selectedImages.length > 5) {
    // ถ้ามีรูปมากกว่า 5 รูป ให้ตัดเหลือแค่ 5 รูปแรก
    selectedImages.removeRange(5, selectedImages.length);
  }
  }
  

  @override
  void onInit() {
    super.onInit();
    initCamera();
  }

  Future<bool> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    return status.isGranted;
  }

  Future<void> initCamera() async {
    bool hasPermission = await requestCameraPermission();
    if (!hasPermission) {
      print('Camera permission not granted');
      return;
    }

    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    cameraController = CameraController(cameras[0], ResolutionPreset.high);

    try {
      await cameraController.initialize();
      isCameraInitialized.value = true;
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

   void toggleFlash() {
    if (!isCameraInitialized.value) return;

    isFlashOn.value = !isFlashOn.value;
    _setFlashMode(isFlashOn.value ? FlashMode.torch : FlashMode.off);
  }

  void _setFlashMode(FlashMode mode) {
    if (cameraController.value.isInitialized) {
      cameraController.setFlashMode(mode);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}