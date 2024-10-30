import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/camera/views/result_widget.dart';

class ResultView extends StatefulWidget {
  ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ผลการค้นหาจากภาพ'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Custom back button icon
          onPressed: () async {
            // Get.toNamed('/home');
            Get.back();
            Get.back();
          },
        ),
        backgroundColor: Color.fromARGB(255, 239, 190, 31),
      ),
      body: Container(
        child: ResultWidget(),
      ),
    );
  }
}
