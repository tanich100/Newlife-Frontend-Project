import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pets_detail_controller.dart';

class PetsDetailView extends GetView<PetsDetailController> {
  const PetsDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PetsDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PetsDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
