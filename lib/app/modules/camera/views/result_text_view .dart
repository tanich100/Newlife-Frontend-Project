import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/camera/views/result_text_widget.dart';

class ResultTextView extends StatefulWidget {
  const ResultTextView({super.key});

  @override
  State<ResultTextView> createState() => _ResultTextViewState();
}

class _ResultTextViewState extends State<ResultTextView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ผลการค้นหาจากคำค้นหา',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Single title for the AppBar
        backgroundColor: const Color.fromARGB(255, 239, 190, 31),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Custom back button icon
          onPressed: () async {
            // Get.toNamed('/home');
            Get.back();
            Get.back();
          },
        ),
      ),
      body: Container(
        child: ResultTextWidget(),
      ),
    );
  }
}
