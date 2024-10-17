import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/district_model.dart';
import 'package:newlife_app/app/data/network/api/district_api.dart';

class DistrictController extends GetxController {
  final DistrictApi _districtApi = DistrictApi();

  RxList<District> districts = <District>[].obs;
  Rx<District?> selectedDistrict = Rx<District?>(null);
  RxBool isLoadingDistricts = true.obs;

  Future<void> fetchDistricts() async {
    try {
      isLoadingDistricts.value = true;
      districts.value = await _districtApi.getAllDistricts();
    } catch (e) {
      print('Error fetching districts: $e');
      // Handle error as needed
    } finally {
      isLoadingDistricts.value = false;
    }
  }

  void setSelectedDistrict(District? district) {
    selectedDistrict.value = district;
  }

  Widget buildDistrictDropdown() {
    return Obx(() {
      if (isLoadingDistricts.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (districts.isEmpty) {
        return Center(child: Text('ไม่พบข้อมูลอำเภอ'));
      }

      return DropdownButtonFormField<District>(
        decoration: InputDecoration(
          labelText: 'อำเภอ',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          labelStyle: TextStyle(fontSize: 15),
        ),
        items: [
          DropdownMenuItem<District>(
            value: null,
            child: Text('เลือกอำเภอ'),
          ),
          ...districts.map((District district) {
            return DropdownMenuItem<District>(
              value: district,
              child: Text(district.nameTh ?? ''),
            );
          }).toList(),
        ],
        style: TextStyle(fontSize: 16, color: Colors.black),
        value: selectedDistrict.value,
        onChanged: (District? newValue) {
          setSelectedDistrict(newValue);
        },
        validator: (value) {
          if (value == null) {
            return 'กรุณาเลือกอำเภอ';
          }
          return null;
        },
      );
    });
  }
}