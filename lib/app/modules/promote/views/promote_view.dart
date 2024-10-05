import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/promote_controller.dart';

class PromoteView extends GetView<PromoteController> {
  const PromoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PromoteView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PromoteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
