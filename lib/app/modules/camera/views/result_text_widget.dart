import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';
import 'package:newlife_app/app/data/models/find_owner_post_model.dart';
import 'package:newlife_app/app/constants/app_url.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';

class ResultTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the data passed from the previous page using ModalRoute
    final List<dynamic> filteredAllPets =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>? ?? [];
    final HomeController controller = Get.put(HomeController());

    return Builder(
      builder: (context) {
        if (filteredAllPets.isEmpty) {
          return Center(child: Text('No pets available'));
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: filteredAllPets.length,
          shrinkWrap: true,
          physics: AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final pet = filteredAllPets[index];
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
              onTap: () {
                controller.navigateToPetDetail(pet);
              },
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
      },
    );
  }
}
