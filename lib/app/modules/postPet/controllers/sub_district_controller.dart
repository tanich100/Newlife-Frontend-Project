import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/sub_daistrict_model.dart';

import 'package:newlife_app/app/data/network/api/sub_district_api.dart';

class SubDistrictController extends GetxController {
  final SubDistrictApi _subDistrictApi = SubDistrictApi();

  RxList<SubDistrictModel> subDistricts = <SubDistrictModel>[].obs;
  Rx<SubDistrictModel?> selectedSubDistrict = Rx<SubDistrictModel?>(null);
  RxBool isLoadingSubDistricts = true.obs;

  Future<void> fetchSubDistricts() async {
    try {
      isLoadingSubDistricts.value = true;
      subDistricts.value = await _subDistrictApi.getAllSubDistricts();
    } catch (e) {
      print('Error fetching sub-districts: $e');
      // Handle error as needed
    } finally {
      isLoadingSubDistricts.value = false;
    }
  }

  Future<void> fetchSubDistrictsByDistrictId(int districtId) async {
    try {
      isLoadingSubDistricts.value = true;
      subDistricts.value = await _subDistrictApi.getSubDistrictsByDistrictId(districtId);
    } catch (e) {
      print('Error fetching sub-districts for district $districtId: $e');
      // Handle error as needed
    } finally {
      isLoadingSubDistricts.value = false;
    }
  }

  void setSelectedSubDistrict(SubDistrictModel? subDistrict) {
    selectedSubDistrict.value = subDistrict;
  }

  Widget buildSubDistrictDropdown() {
    return Obx(() {
      if (isLoadingSubDistricts.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (subDistricts.isEmpty) {
        return Center(child: Text('ไม่พบข้อมูลตำบล'));
      }

      return DropdownButtonFormField<SubDistrictModel>(
        decoration: InputDecoration(
          labelText: 'ตำบล',
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          labelStyle: TextStyle(fontSize: 15),
        ),
        items: [
          DropdownMenuItem<SubDistrictModel>(
            value: null,
            child: Text('เลือกตำบล'),
          ),
          ...subDistricts.map((SubDistrictModel subDistrict) {
            return DropdownMenuItem<SubDistrictModel>(
              value: subDistrict,
              child: Text(subDistrict.nameTh ?? ''),
            );
          }).toList(),
        ],
        style: TextStyle(fontSize: 16, color: Colors.black),
        value: selectedSubDistrict.value,
        onChanged: (SubDistrictModel? newValue) {
          setSelectedSubDistrict(newValue);
        },
        validator: (value) {
          if (value == null) {
            return 'กรุณาเลือกตำบล';
          }
          return null;
        },
      );
    });
  }
}