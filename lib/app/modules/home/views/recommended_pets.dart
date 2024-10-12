import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/modules/petsDetail/views/pets_detail_view.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';

class RecommendedPets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Container(
      child: Obx(() {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.allPets.length,
          itemBuilder: (context, index) {
            final pet = controller.allPets[index];
            String name = '';
            String? imageUrl;
            String imageEndpoint = '';

            if (pet is AdoptionPost) {
              name = pet.name ?? 'Unknown';
              imageUrl = pet.image1;
              imageEndpoint = AppUrl.image; //  endpoint สำหรับ AdoptionPost
            } else if (pet is FindOwnerPost) {
              name = pet.name ?? 'Unknown';
              imageUrl = pet.image1;
              imageEndpoint =
                  AppUrl.findOwnerPostImage; //  endpoint สำหรับ FindOwnerPost
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetsDetailView(pet: pet),
                    ),
                  );
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
                                  '${AppUrl.baseUrl}${pet is AdoptionPost ? AppUrl.adoptionPosts : AppUrl.findOwnerPosts}$imageEndpoint/$imageUrl', // ใช้โครงสร้าง URL ที่เหมือนกัน
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
                      Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
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
