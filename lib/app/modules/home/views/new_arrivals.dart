import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/post_pet_controller.dart';

class NewArrivals extends StatelessWidget {
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
                      // Null check for image1
                      if (pet.image1 != null)
                        ClipRRect(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(6)),
                          child: Container(
                            height: 120, // Image height
                            width: 150,
                            child: Image.network(
                              'http://10.0.2.2:5296/AdoptionPost/getImage/' +
                                  pet.image1,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child:
                                      CircularProgressIndicator(), // Loading spinner
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.broken_image,
                                    size: 50,
                                    color: Colors.red); // Error fallback
                              },
                            ),
                          ),
                        ),

                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            pet.name ?? 'Unknown', // Null check for name
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 4),
                          Icon(
                            pet.sex == 'male' ? Icons.male : Icons.female,
                            size: 24,
                            color:
                                pet.sex == 'male' ? Colors.blue : Colors.pink,
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
