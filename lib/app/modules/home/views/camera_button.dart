import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.camera_alt),
      onPressed: () => Get.toNamed('/camera')
       
    );
  }
}
