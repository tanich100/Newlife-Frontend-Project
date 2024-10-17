import 'package:get/get.dart';
import 'package:newlife_app/app/modules/postPet/controllers/breed_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/district_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/postal_code_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/provinces_controller.dart';


import '../controllers/post_pet_controller.dart';
import '../controllers/sub_district_controller.dart';

class PostPetBinding extends Bindings {
  @override
  void dependencies() {
   
    Get.lazyPut<PostPetController>(
      () => PostPetController(),
    );
    Get.lazyPut<ProvinceController>(
      () => ProvinceController(),
    );
      Get.lazyPut<DistrictController>(
      () => DistrictController(),
    );
    Get.lazyPut<SubDistrictController>(
      () => SubDistrictController(),
    );
    Get.lazyPut<PostalCodeController>(
      () => PostalCodeController(),
    );
    Get.lazyPut<BreedController>(
      () => BreedController(),
    );
  }
}
