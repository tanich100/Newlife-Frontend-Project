import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/modules/postPet/controllers/image_search_controller.dart';

class ResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final ImageSearchController imageSearchController = Get.find<ImageSearchController>();

    return Obx(() {
      if (imageSearchController.filteredAllPets.isEmpty) {
        return Center(child: Text('No pets available'));
      }
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: imageSearchController.filteredAllPets.length,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(), 
        itemBuilder: (context, index) {
          final pet = imageSearchController.filteredAllPets[index];
          String name = '';
          String? imageUrl;
          String imageEndpoint = '';

          if (pet is AdoptionPost) {
            name = pet.name ?? 'Unknown';
            imageUrl = pet.image1;
            imageEndpoint = AppUrl.image;
          } else if (pet is FindOwnerPost) {
            name = pet.name ?? 'Unknown';
            imageUrl = pet.image1;
            imageEndpoint = AppUrl.findOwnerPostImage;
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
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
