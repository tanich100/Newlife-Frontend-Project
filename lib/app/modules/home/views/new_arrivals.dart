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
                child: Card(
                  color: Color(0xfffdcf09),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: pet.image1 != null
                                ? Image.network(
                                    '${AppUrl.baseUrl}${AppUrl.adoptionPosts}/getImage/${pet.image1}',
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      print('Error loading image: $error');
                                      return Icon(Icons.broken_image,
                                          size: 50, color: Colors.red);
                                    },
                                  )
                                : Icon(Icons.pets, size: 50),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  pet.name ?? 'Unknown',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                (pet.sex?.toLowerCase() == 'male' ||
                                        pet.sex?.toLowerCase() == 'm' ||
                                        pet.sex?.toLowerCase() == 'men')
                                    ? Icons.male
                                    : Icons.female,
                                size: 24,
                                color: (pet.sex?.toLowerCase() == 'male' ||
                                        pet.sex?.toLowerCase() == 'm' ||
                                        pet.sex?.toLowerCase() == 'men')
                                    ? Colors.blue
                                    : Colors.pink,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
