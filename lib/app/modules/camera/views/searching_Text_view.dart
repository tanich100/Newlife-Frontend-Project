import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/postPet/controllers/image_search_controller.dart';


class SearchingTextView extends StatefulWidget {
  const SearchingTextView({super.key});

  @override
  State<SearchingTextView> createState() => _SearchingTextViewState();
}

class _SearchingTextViewState extends State<SearchingTextView> {
  @override
  void initState() {
    super.initState();
    print("Bool");
    print(imageSearchController.isSearchingText.value);
  }

  final ImageSearchController imageSearchController =
      Get.put(ImageSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Searching View'),
      // ),
      body: Obx(() {
        if (!imageSearchController.isSearchingText.value) {
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
