import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/breed_model.dart';
import 'package:newlife_app/app/data/network/api/breed_api.dart';

class BreedController extends GetxController {
  final BreedApi _breedApi = BreedApi();

  RxList<Breed> breeds = <Breed>[].obs;
  Rx<Breed?> selectedBreed = Rx<Breed?>(null);
  // RxBool isLoadingBreeds = true.obs;
  RxString selectedAnimalType = ''.obs;
  RxString errorMessage = ''.obs;

   
  RxString selectedSex = ''.obs;
  RxBool isNeedAttention = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBreeds();
  }

  

  Future<void> fetchBreeds() async {
    try {
      // isLoadingBreeds.value = true;
      errorMessage.value = '';
      breeds.value = await _breedApi.getAllBreed();

      print(breeds);
    } catch (e) {
      print('Error fetching breeds: $e');
      errorMessage.value = 'เกิดข้อผิดพลาดในการโหลดข้อมูลสายพันธุ์';
    } finally {
      // isLoadingBreeds.value = false;
    }
  }

  Future<void> fetchBreedById(int breedId) async {
    try {
      // isLoadingBreeds.value = true;
      errorMessage.value = '';
      Breed breed = await _breedApi.getBreed(breedId);
      selectedBreed.value = breed;
    } catch (e) {
      print('Error fetching breed by id: $e');
      errorMessage.value = 'เกิดข้อผิดพลาดในการโหลดข้อมูลสายพันธุ์';
    } finally {
      // isLoadingBreeds.value = false;
    }
  }

  void setSelectedBreed(Breed? breed) {
    selectedBreed.value = breed;
  }

  void setSelectedAnimalType(String animalType) {
    selectedAnimalType.value = animalType;
    selectedBreed.value = null; // Reset selected breed when animal type changes
  }

  List<Breed> getBreedsByAnimalType() {
    return breeds
        .where((breed) => breed.animalType == selectedAnimalType.value)
        .toList();
  }

 Widget buildBreedDropdown() {
  return Obx(() {
    // if (isLoadingBreeds.value) {
    //   return Center(child: CircularProgressIndicator());
    // }

    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage.value));
    }

    // กรองพันธุ์ตามประเภทสัตว์ที่เลือก
    List<Breed> filteredBreeds = getBreedsByAnimalType();

    // if (filteredBreeds.isEmpty) {
    //   return Center(child: Text('ไม่พบข้อมูลสายพันธุ์สำหรับสัตว์ชนิดนี้'));
    // }

    return DropdownButtonFormField<Breed>(
      decoration: InputDecoration(
        labelText: 'สายพันธุ์',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        labelStyle: TextStyle(fontSize: 15),
      ),
      items: [
        DropdownMenuItem<Breed>(
          value: null,
          child: Text('เลือกสายพันธุ์'),
        ),
        ...filteredBreeds.map((Breed breed) {
          return DropdownMenuItem<Breed>(
            value: breed,
            child: Text(breed.breedName),
          );
        }).toList(),
      ],
      style: TextStyle(fontSize: 16, color: Colors.black),
      value: selectedBreed.value,
      onChanged: (Breed? newValue) {
        setSelectedBreed(newValue); // อัปเดตพันธุ์ที่เลือก
      },
      validator: (value) {
        if (value == null) {
          return 'กรุณาเลือกสายพันธุ์';
        }
        return null;
      },
    );
  });
}
}