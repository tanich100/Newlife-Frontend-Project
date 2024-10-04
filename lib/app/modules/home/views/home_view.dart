import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/views/camera_button.dart';
import 'package:newlife_app/app/modules/home/views/category_selector.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/home/views/favorites_button.dart';
import 'package:newlife_app/app/modules/home/views/filter_dropdown.dart';
import 'package:newlife_app/app/modules/home/views/new_arrivals.dart';
import 'package:newlife_app/app/modules/home/views/pets_display.dart';
import 'package:newlife_app/app/modules/home/views/recommended_pets.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 236, 217, 79),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: SearchBar()),
            CameraButton(),
            FavoritesButton()
          ],
        ),
        actions: [FilterDropdown()],
      ),
      body: Container(
        color: Color.fromARGB(255, 229, 223, 174),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 240,
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 249, 246, 215),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Text(
                                    'แนะนำ',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Image.asset(
                                    'images/hot.png',
                                    width: 26,
                                    height: 26,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              height: 192,
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: RecommendedPets(),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
             
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Text(
                            'สมาชิกใหม่',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(width: 8),
                          Image.asset(
                            'images/new.png',
                            width: 30,
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 192,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: NewArrivals(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              Container(
                height: 50, // ปรับความสูงตามความเหมาะสม
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategorySelector(
                      onTagSelected: (tag) {
                        controller.updateTag(tag);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Container(
                color: Color.fromARGB(255, 242, 242, 242),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: SizedBox(
                  height: 250,
                  child: PetsDisplay(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
