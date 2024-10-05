import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';

class CategorySelector extends GetView<HomeController> {
  final Function(String) onTagSelected;

  CategorySelector({Key? key, required this.onTagSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      height: 55,
      child: TabBar(
        
        controller: controller.tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        indicatorColor: Color.fromARGB(255, 34, 33, 33),
        
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
       
        labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
        tabs: controller.categories.map((category) => 
          Tab(text: category)
        ).toList(),
        onTap: (index) {
          String selectedCategory = controller.categories[index];
          controller.setSelectedCategory(selectedCategory);
          onTagSelected(selectedCategory);
        },
        
      ),
    );
  }
}