import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../postPet/controllers/image_search_controller.dart';

class SearchingView extends StatefulWidget {
  const SearchingView({super.key});

  @override
  State<SearchingView> createState() => _SearchingViewState();
}

class _SearchingViewState extends State<SearchingView> {
  @override
  void initState() {
    super.initState();
    print("Bool");
    print(imageSearchController.isSearching.value);
  }

  final ImageSearchController imageSearchController =
      Get.put(ImageSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Searching View'),
      ),
      body: Obx(() {
        if (imageSearchController.isSearching.value) {
          // Show loading indicator if searching
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // Show your main content when not searching
          return Center(
            child: Text("Finish Searching")
          );
        }
      }),
    );
  }
}
