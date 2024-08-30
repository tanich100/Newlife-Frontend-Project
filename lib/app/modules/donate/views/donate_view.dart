import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/donate_controller.dart';

class DonateView extends GetView<DonateController> {
  const DonateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DonateView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DonateView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
