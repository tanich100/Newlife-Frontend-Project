import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(8), // ปรับขนาดพื้นที่รอบไอคอน
          child: Image.asset(
            'images/fav.png',
            width: 24,
            height: 24,
          ),
        ),
        onPressed: () => Get.toNamed('/favorite'));
  }
}
