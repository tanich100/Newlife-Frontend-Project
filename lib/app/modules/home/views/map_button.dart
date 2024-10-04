import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';

class MapButton extends GetView<HomeController> {
  const MapButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
     
     
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Image.asset(
              'images/location.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              // TODO: เพิ่มการทำงานเมื่อกดปุ่มแผนที่
              print('Map button pressed');
            },
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              controller.location.value,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ));
  }
}

