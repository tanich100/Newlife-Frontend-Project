import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';

class RecommendedPets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Container(
      child: Obx(() {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller
              .recommendedPets.length, // แสดงผลจาก recommendedPets ที่ถูกกรอง
          itemBuilder: (context, index) {
            final pet = controller.recommendedPets[index];
            String name = '';
            String? imageUrl;
            String gender = '';

            // กำหนดค่าให้กับชื่อและรูปภาพของสัตว์
            if (pet is AdoptionPost) {
              name = pet.name ?? 'Unknown';
              imageUrl = pet.image1;
              gender = pet.sex ?? '';
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/pets-detail', arguments: {'pet': pet});
                },
                child: Container(
                  width: 150,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 194, 10),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(6)),
                        child: Container(
                          height: 120,
                          width: 150,
                          child: imageUrl != null
                              ? Image.network(
                                  '${AppUrl.baseUrl}${AppUrl.adoptionPosts}${AppUrl.image}/$imageUrl',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    print(
                                        'Error loading image for $name: $error');
                                    return Icon(Icons.error, size: 50);
                                  },
                                )
                              : Icon(Icons.pets, size: 50),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Icon(
                            gender.toLowerCase() == 'male'
                                ? Icons.male
                                : Icons.female,
                            size: 24,
                            color: gender.toLowerCase() == 'male'
                                ? Colors.blue
                                : Colors.pink,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
