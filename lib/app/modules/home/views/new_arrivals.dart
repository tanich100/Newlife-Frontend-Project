import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/modules/petsDetail/views/pets_detail_view.dart';

class NewArrivals extends StatelessWidget {
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final newarrivalsPets = controller.recommendedPets;

    return Container(
      
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: newarrivalsPets.length,
          itemBuilder: (context, index) {
            final pet = newarrivalsPets[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PetsDetailView(),
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  height: 180,
                  // margin: EdgeInsets.symmetric(horizontal: 8.0),
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
                          height: 120, // กำหนดความสูงของรูปภาพ
                          width: 150,
                          child: Image.network(
                            pet.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            pet.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: 4),
                          Icon(
                            pet.gender == 'male' ? Icons.male : Icons.female,
                            size: 24,
                            color: pet.gender == 'male'
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
          }),
    );
  }
}
