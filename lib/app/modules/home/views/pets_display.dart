import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/breed_model.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/modules/postPet/controllers/breed_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/post_pet_controller.dart';
import 'package:newlife_app/app/modules/profile/controllers/profile_controller.dart';

class PetsDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.filteredAllPets.isEmpty) {
        return Center(child: Text('No pets available'));
      }
      return Padding(
        padding: EdgeInsets.only(top: 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: controller.filteredAllPets.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final pet = controller.filteredAllPets[index];
            String name = '';
            String? imageUrl;
            String imageEndpoint = '';
            String? sex;

            if (pet is AdoptionPost) {
              name = pet.name ?? 'Unknown';
              imageUrl = pet.image1;
              imageEndpoint = AppUrl.image;
              sex = pet.sex;
            } else if (pet is FindOwnerPost) {
              name = pet.name ?? 'Unknown';
              imageUrl = pet.image1;
              imageEndpoint = AppUrl.findOwnerPostImage;
              sex = pet.sex;
            }

            return GestureDetector(
              onTap: () => controller.navigateToPetDetail(pet),
              child: Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: imageUrl != null
                          ? Image.network(
                              '${AppUrl.baseUrl}${pet is AdoptionPost ? AppUrl.adoptionPosts : AppUrl.findOwnerPosts}$imageEndpoint/$imageUrl',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading image: $error');
                                return Icon(Icons.error);
                              },
                            )
                          : Icon(Icons.pets, size: 50),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            (sex?.toLowerCase() == 'male' ||
                                    sex?.toLowerCase() == 'm' ||
                                    sex?.toLowerCase() == 'men')
                                ? Icons.male
                                : Icons.female,
                            size: 24,
                            color: (sex?.toLowerCase() == 'male' ||
                                    sex?.toLowerCase() == 'm' ||
                                    sex?.toLowerCase() == 'men')
                                ? Colors.blue
                                : Colors.pink,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
