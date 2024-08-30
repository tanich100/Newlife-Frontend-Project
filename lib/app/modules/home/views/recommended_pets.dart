import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/modules/petsDetail/views/pets_detail_view.dart';

class RecommendedPets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final recommendedPets = controller.recommendedPets;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: recommendedPets.length,
      itemBuilder: (context, index) {
        final pet = recommendedPets[index];
        return GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PetsDetailView(),
      ),
    );
  },
  child: Container(
    width: 120,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        Expanded(
          child: Image.network(
            pet.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          pet.name,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  ),
);
      }
    );
  
  }
  }
