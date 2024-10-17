import 'dart:io';

import 'package:get/get.dart';
import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/modules/camera/views/searching_view.dart';

class ImageSearchController extends GetxController {
  AdoptionPostApi adoptionPostApi = AdoptionPostApi();
  RxBool isSearching = false.obs;

  Future<void> getImageSearch(String petType, File file) async {
    // เริ่มค้นหา
    isSearching.value = true;
    Get.to(SearchingView());
    var list = await adoptionPostApi.searchByImage("dog", file);
    print(list);
    isSearching.value = false;
  }
}
