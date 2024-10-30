import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/provinces_model.dart';
import 'package:newlife_app/app/data/network/api/provinces_api.dart';


class ProvinceController extends GetxController {
  final ProvinceApi _provinceApi = ProvinceApi();
  
  RxList<Province> provinces = <Province>[].obs;
  Rx<Province?> selectedProvince = Rx<Province?>(null);
  // RxBool isLoadingProvinces = true.obs;

  int? get selectedProvinceId => selectedProvince.value?.provinceId;
  String get selectedProvinceName => selectedProvince.value?.nameTh ?? '';

  Future<void> fetchProvinces() async {
    try {
      // isLoadingProvinces.value = true;
      provinces.value = await _provinceApi.getAllProvinces();
    } catch (e) {
      // print('Error fetching provinces: $e');
      // Handle error as needed
    } finally { 
      // isLoadingProvinces.value = false;
    }
  }

  void setSelectedProvince(Province? province) {
    selectedProvince.value = province;
  }

  Widget buildProvinceDropdown() {
    return Obx(() {
      // if (isLoadingProvinces.value) {
      //   return Center(child: CircularProgressIndicator());
      // }
      
      // if (provinces.isEmpty) {
      //   return Center(child: Text('ไม่พบข้อมูลจังหวัด'));
      // }

      return DropdownButtonFormField<Province>(
        decoration: InputDecoration(
          labelText: 'จังหวัด',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          labelStyle: TextStyle(fontSize: 15),
        ),
        items: [
          DropdownMenuItem<Province>(
            value: null,
            child: Text('เลือกจังหวัด'),
          ),
          ...provinces.map((Province province) {
            return DropdownMenuItem<Province>(
              value: province,
              child: Text(province.nameTh ?? ''),
            );
          }).toList(),
        ],
        style: TextStyle(fontSize: 16,color: Colors.black),
        value: selectedProvince.value,
        onChanged: (Province? newValue) {
          setSelectedProvince(newValue);
        },
        validator: (value) {
          if (value == null) {
            return 'กรุณาเลือกจังหวัด';
          }
          return null;
        },
      );
    });
  }
}