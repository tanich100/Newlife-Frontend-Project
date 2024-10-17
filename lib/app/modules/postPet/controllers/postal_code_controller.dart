import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/postPet/controllers/district_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/provinces_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/sub_district_controller.dart';

class PostalCodeController extends GetxController {
  final SubDistrictController subDistrictController = Get.find<SubDistrictController>();
  final DistrictController districtController = Get.find<DistrictController>();
  final ProvinceController provinceController = Get.find<ProvinceController>();

  final TextEditingController textEditingController = TextEditingController();
  RxList<String> uniqueZipCodes = <String>[].obs;
  Rx<String?> selectedZipCode = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    ever(selectedZipCode, (_) => updateTextFieldValue());
    initializeZipCodes();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  void initializeZipCodes() {
    uniqueZipCodes.value = subDistrictController.subDistricts
        .map((subDistrict) => subDistrict.zipCode.toString())
        .toSet()
        .toList();
  }

  void setSelectedZipCode(String? zipCode) {
    selectedZipCode.value = zipCode;
    updateLocationFromZipCode(zipCode);
  }

    void updateLocationFromZipCode(String? zipCode) {
    if (zipCode == null || zipCode.isEmpty) {
      clearSelections();
      return;
    }

    // ใช้ updateFilteredSubDistricts ของ SubDistrictController
    subDistrictController.updateFilteredSubDistricts(zipCode);

    if (subDistrictController.filteredSubDistricts.isNotEmpty) {
      var firstSubDistrict = subDistrictController.filteredSubDistricts.first;
      
      // หาและเลือกอำเภอ
      var matchingDistrict = districtController.districts
          .firstWhereOrNull((district) => district.id == firstSubDistrict.districtId);
      if (matchingDistrict != null) {
        districtController.setSelectedDistrict(matchingDistrict);
        
        // หาและเลือกจังหวัด
        var matchingProvince = provinceController.provinces
          .firstWhereOrNull((province) => province.provinceId == matchingDistrict.provinceId);
        if (matchingProvince != null) {
          provinceController.setSelectedProvince(matchingProvince);
        }
      }

      // ถ้ามีตำบลเดียว SubDistrictController จะเลือกให้อัตโนมัติแล้ว
      // เราไม่ต้องทำอะไรเพิ่มเติมที่นี่
    } else {
      clearSelections();
      Get.snackbar('ไม่พบข้อมูล', 'ไม่พบข้อมูลสำหรับรหัสไปรษณีย์นี้');
    }
  }

  void clearSelections() {
    subDistrictController.setSelectedSubDistrict(null);
    subDistrictController.filteredSubDistricts.clear();
    districtController.setSelectedDistrict(null);
    provinceController.setSelectedProvince(null);
  }




  void updateTextFieldValue() {
    textEditingController.text = selectedZipCode.value ?? '';
  }
Widget buildZipCodeDropdown() {
  return Obx(() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'รหัสไปรษณีย์',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        labelStyle: TextStyle(fontSize: 15),
      ),
      items: [
        DropdownMenuItem<String>(
          value: null,
          child: Text('เลือกรหัสไปรษณีย์'),
        ),
        ...uniqueZipCodes.map((String zipCode) {
          return DropdownMenuItem<String>(
            value: zipCode,
            child: Text(zipCode),
          );
        }).toList(),
      ],
      style: TextStyle(fontSize: 16, color: Colors.black),
      value: selectedZipCode.value,
      onChanged: (String? newValue) {
        setSelectedZipCode(newValue);
      },
      validator: (value) {
        if (value == null) {
          return 'กรุณาเลือกรหัสไปรษณีย์';
        }
        return null;
      },
    );
  });
}


}