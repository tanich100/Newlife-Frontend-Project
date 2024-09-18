import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraControllerX extends GetxController {
  late CameraController cameraController;
  RxBool isCameraInitialized = false.obs;

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