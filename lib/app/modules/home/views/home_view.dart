import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/views/camera_button.dart';
import 'package:newlife_app/app/modules/home/views/category_selector.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';
import 'package:newlife_app/app/modules/home/views/favorites_button.dart';
import 'package:newlife_app/app/modules/home/views/filter_dropdown.dart';
import 'package:newlife_app/app/modules/home/views/map_button.dart';
import 'package:newlife_app/app/modules/home/views/new_arrivals.dart';
import 'package:newlife_app/app/modules/home/views/pets_display.dart';
import 'package:newlife_app/app/modules/home/views/recommended_pets.dart';
import 'package:newlife_app/app/modules/home/views/text_search.dart';
import 'package:newlife_app/app/modules/postPet/controllers/post_pet_controller.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final PostPetController postPetController = Get.put(PostPetController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(125.0),
        child: SafeArea(
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 236, 217, 79),
            flexibleSpace: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MapButton(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          child: Row(
                            children: [
                              FilterDropdown(),
                              Expanded(
                                child: TextSearch(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CameraButton(),
                      FavoritesButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 236, 217, 79),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 245, 205),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            height: 240,
                            width: 390,
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 251),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: RecommendedPets(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            height: 250,
                            width: 390,
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 253, 253, 253),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: NewArrivals(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 2),
                Container(
                  color: Colors.white,
                  height: 55, // ปรับความสูงตามความเหมาะสม
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postPetController.getNewPet(); // Fetch new pets on button press
        },
        child: Icon(Icons.refresh), // Icon for the button
        tooltip: 'Refresh Pets', // Tooltip for accessibility
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
