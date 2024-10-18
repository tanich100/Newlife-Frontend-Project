import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/adoption_post_model.dart';

import 'package:newlife_app/app/data/network/api/adoption_post_api.dart';
import 'package:newlife_app/app/modules/postPet/controllers/breed_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/district_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/post_pet_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/postal_code_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/provinces_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/sub_district_controller.dart';

import '../../../data/models/post_model.dart';

class NewPostPageDetail extends StatefulWidget {
  final AdoptionPost selectedPost;
  final PostPetController controller = Get.find<PostPetController>();
  final List<File> selectedImages;
  NewPostPageDetail({
    Key? key,
    required this.selectedPost,
    required this.selectedImages,
  }) : super(key: key);

  @override
  _PostPageDetailState createState() => _PostPageDetailState();
}

class _PostPageDetailState extends State<NewPostPageDetail> {
  final ProvinceController provinceController = Get.put(ProvinceController());
  final DistrictController districtController = Get.put(DistrictController());
  final SubDistrictController subDistrictController =
      Get.put(SubDistrictController());
  final PostalCodeController postalCodeController =
      Get.put(PostalCodeController());

  final BreedController breedController = Get.put(BreedController());

  final PostPetController controller = Get.find<PostPetController>();
  final AdoptionPostApi _adoptionPostApi = AdoptionPostApi();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _additionalAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    try {
      await Future.wait([
        districtController.fetchDistricts(),
        provinceController.fetchProvinces(),
        subDistrictController.fetchSubDistricts(),
        breedController.fetchBreeds(),
      ]);
      postalCodeController.initializeZipCodes();
    } catch (e) {
      print('Error fetching data: $e');
      // จัดการข้อผิดพลาดตามที่เหมาะสม เช่น แสดง SnackBar หรือ Dialog
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _additionalAddressController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final _addressWidgetKey = GlobalKey<_AddressWidgetState>();
  String _animalType = 'สุนัข';
  bool _isSpecialCareSelected = false;

  bool get isLookingForAdoption =>
      widget.selectedPost == 'ประกาศหาผู้รับเลี้ยง';

  void _handleAnimalTypeChange(String value) {
    setState(() {
      _animalType = value;
    });
  }

  void _handleSpecialCareChange(bool? value) {
    setState(() {
      _isSpecialCareSelected = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFFFFD54F),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
        // title: Text(
        //   // widget.selectedPost.postType,
        //   style: TextStyle(
        //       color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        // ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ประเภท',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    SizedBox(height: 5),
                    _buildRadioListTile(
                      title: 'สุนัข',
                      value: 'สุนัข',
                    ),
                    _buildRadioListTile(
                      title: 'แมว',
                      value: 'แมว',
                    ),
                    SizedBox(height: 5),
                    Text(
                      'การดูแล',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    CheckboxListTile(
                      title: Text(
                        'ต้องการความดูแลเป็นพิเศษ',
                        style: TextStyle(fontSize: 15), // Adjust font size here
                      ),
                      value: _isSpecialCareSelected,
                      onChanged: _handleSpecialCareChange,
                      activeColor: Color(0xFFFFD54F),
                    ),
                    if (_isSpecialCareSelected)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'โปรดทราบสัตว์ที่ต้องการความดูแลพิเศษอาจมีโอกาสในการขอรับเลี้ยงน้อย',
                          style: TextStyle(color: Colors.red, fontSize: 11.5),
                        ),
                      ),
                    _DetailsWidget(
                      isLookingForAdoption: isLookingForAdoption,
                      nameController: _nameController,
                      ageController: _ageController,
                      additionalAddressController: _additionalAddressController,
                    ),
                    SizedBox(height: 8),
                    _AddressWidget(key: _addressWidgetKey),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  child: Text('โพสต์',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFD54F),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: Size(double.infinity, 48),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // บันทึกข้อมูลจากฟอร์มลงในโมเดล
                      widget.selectedPost.name = _nameController.text;
                      widget.selectedPost.age =
                          int.tryParse(_ageController.text);
                      widget.selectedPost.sex = controller.selectedSex.value;
                      widget.selectedPost.isNeedAttention =
                          _isSpecialCareSelected;
                      widget.selectedPost.breedId =
                          breedController.selectedBreedId;
                      widget.selectedPost.provinceId =
                          provinceController.selectedProvinceId;
                      widget.selectedPost.districtId =
                          districtController.selectedDistrictId;
                      widget.selectedPost.subdistrictId =
                          subDistrictController.selectedSubDistrictId;
                      widget.selectedPost.addressDetails =
                          _additionalAddressController.text;

                      try {
                        // เรียกใช้ฟังก์ชันเพื่อบันทึกข้อมูล
                        await controller
                            .createAdoptionPost(widget.selectedPost);
                        Get.snackbar('สำเร็จ', 'โพสต์ถูกบันทึกเรียบร้อยแล้ว',
                            snackPosition: SnackPosition.BOTTOM);
                      } catch (e) {
                        Get.snackbar(
                            'เกิดข้อผิดพลาด', 'ไม่สามารถบันทึกโพสต์ได้',
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    } else {
                      Get.snackbar('ข้อผิดพลาด', 'กรุณากรอกข้อมูลให้ครบถ้วน',
                          snackPosition: SnackPosition.BOTTOM);
                    }
                  }),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildRadioListTile({
    required String title,
    required String value,
  }) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: RadioListTile<String>(
          title: Row(
            children: [
              Expanded(child: Text(title, style: TextStyle(fontSize: 15))),
            ],
          ),
          value: value,
          groupValue: breedController.selectedAnimalType.value,
          onChanged: (String? newValue) {
            if (newValue != null) {
              breedController.setSelectedAnimalType(newValue);
            }
          },
          controlAffinity: ListTileControlAffinity.trailing,
          activeColor: Color(0xFFFFD54F),
        ),
      );
    });
  }

  // Widget _buildRadioListTile({
  //   required String title,
  //   required String value,
  // }) {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 8),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey[300]!),
  //       borderRadius: BorderRadius.circular(8),
  //     ),
  //     child: RadioListTile<String>(
  //       title: Row(
  //         children: [
  //           Expanded(child: Text(title, style: TextStyle(fontSize: 15))),
  //         ],
  //       ),
  //       value: value,
  //       groupValue: _animalType,
  //       onChanged: (String? newValue) {
  //         setState(() {
  //           _animalType = newValue!;
  //         });
  //       },
  //       controlAffinity: ListTileControlAffinity.trailing,
  //       activeColor: Color(0xFFFFD54F),
  //     ),
  //   );
  // }
}

class _DetailsWidget extends StatelessWidget {
  final bool isLookingForAdoption;
  final BreedController breedController = Get.find<BreedController>();
  final PostPetController controller = Get.find<PostPetController>();
  final AdoptionPostApi _adoptionPostApi = AdoptionPostApi();
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController additionalAddressController;
  final _formKey = GlobalKey<FormState>(); // ประกาศตัวแปร formKey

  _DetailsWidget({
    Key? key,
    required this.isLookingForAdoption,
    required this.nameController,
    required this.ageController,
    required this.additionalAddressController,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // ผูกฟอร์มกับ formKey
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'รายละเอียด',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: isLookingForAdoption ? 'ชื่อ:' : 'ชื่อ(ถ้ามี):',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                    labelStyle: TextStyle(fontSize: 15),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: breedController.buildBreedDropdown(),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    labelText: 'อายุ (ปี):',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    labelStyle: TextStyle(fontSize: 15),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'เพศ:',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    labelStyle: TextStyle(fontSize: 15),
                  ),
                  items: [
                    DropdownMenuItem(value: '', child: Text('เลือกเพศ')),
                    DropdownMenuItem(value: 'M', child: Text('ผู้')),
                    DropdownMenuItem(value: 'F', child: Text('เมีย')),
                    DropdownMenuItem(
                        value: 'Unknow', child: Text('ไม่ทราบเพศ')),
                  ],
                  value: controller.selectedSex.value,
                  onChanged: (value) {
                    controller.selectedSex.value = value ?? '';
                  },
                ),
              ),
            ],
          ),
          if (!isLookingForAdoption) ...[
            SizedBox(height: 12),
            TextFormField(
              controller: additionalAddressController,
              decoration: InputDecoration(
                labelText: 'รายละเอียดเพิ่มเติม:',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                labelStyle: TextStyle(fontSize: 15),
              ),
              maxLines: 2,
            ),
          ],
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AddressWidget extends StatefulWidget {
  const _AddressWidget({Key? key}) : super(key: key);

  @override
  _AddressWidgetState createState() => _AddressWidgetState();
}

class _AddressWidgetState extends State<_AddressWidget> {
  final _addressFormKey = GlobalKey<FormState>();
  final ProvinceController provinceController = Get.find<ProvinceController>();
  final DistrictController districtController = Get.find<DistrictController>();
  final SubDistrictController subDistrictController =
      Get.find<SubDistrictController>();
  final PostalCodeController postalCodeController =
      Get.find<PostalCodeController>();

  final TextEditingController _additionalAddressController =
      TextEditingController();

  bool validate() {
    return _addressFormKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _addressFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ที่อยู่', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: provinceController.buildProvinceDropdown(),
              ),
              SizedBox(width: 16),
              Expanded(
                child: districtController.buildDistrictDropdown(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: subDistrictController.buildSubDistrictDropdown(),
              ),
              SizedBox(width: 16),
              Expanded(
                child: postalCodeController.buildZipCodeDropdown(),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _additionalAddressController,
            decoration: InputDecoration(
              labelText: 'รายละเอียดที่อยู่เพิ่มเติม',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              labelStyle: TextStyle(fontSize: 15),
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _additionalAddressController.dispose();
    super.dispose();
  }
}
