import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/post_pet_controller.dart';
import 'package:newlife_app/app/constants/app_url.dart';

class NewArrivals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    PostPetController postPetController = Get.put(PostPetController());

    return Container(
      child: Obx(() {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: postPetController.adoptionPostList.length,
          itemBuilder: (context, index) {
            final pet = postPetController.adoptionPostList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  postPetController.getNewPet(); // Fetch new pets on tap
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
                          height: 120, // Image height
                          width: 150,
                          child: pet.image1 != null
                              ? Image.network(
                                  '${AppUrl.baseUrl}${AppUrl.adoptionPosts}/getImage/${pet.image1}',
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child:
                                          CircularProgressIndicator(), // Loading spinner
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    print('Error loading image: $error');
                                    return Icon(Icons.broken_image,
                                        size: 50,
                                        color: Colors.red); // Error fallback
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
                              pet.name ?? 'Unknown', // Null check for name
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            pet.sex?.toLowerCase() == 'male'
                                ? Icons.male
                                : Icons.female,
                            size: 24,
                            color: pet.sex?.toLowerCase() == 'male'
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
