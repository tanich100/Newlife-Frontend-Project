import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(8), 
          child: Icon(
            Icons.camera_alt_outlined,
            color: Colors.black, 
            size: 24, 
          ),
        ),
        onPressed: () => Get.toNamed('/camera'));
  }
}
