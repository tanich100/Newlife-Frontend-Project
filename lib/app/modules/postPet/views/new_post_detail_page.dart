import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/post_model.dart';
import 'package:newlife_app/app/modules/postPet/controllers/breed_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/district_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/post_pet_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/postal_code_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/provinces_controller.dart';
import 'package:newlife_app/app/modules/postPet/controllers/sub_district_controller.dart';

class NewPostPageDetail extends StatefulWidget {
  final PostModel selectedPost;
  final PostPetController controller = Get.find<PostPetController>();
  NewPostPageDetail({Key? key, required this.selectedPost}) : super(key: key);

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
        title: Text(
          widget.selectedPost.postType,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
                    _DetailsWidget(isLookingForAdoption: isLookingForAdoption),
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
                  onPressed: () {
                    bool isMainFormValid = _formKey.currentState!.validate();
                    bool isAddressValid =
                        _addressWidgetKey.currentState!.validate();

                    if (isMainFormValid && isAddressValid) {
                      // ถ้าข้อมูลถูกต้องทั้งหมด ทำการโพสต์
                      print('โพสต์สำเร็จ');
                      // ไปที่หน้าโปรไฟล์หลังจากโพสต์เสร็จ
                      Get.toNamed('/profile');
                    } else {
                      print('กรุณากรอกข้อมูลให้ครบถ้วน');
                      // อาจจะแสดง SnackBar หรือ Dialog เพื่อแจ้งเตือนผู้ใช้
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบถ้วน')),
                      );
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
        groupValue: _animalType,
        onChanged: (String? newValue) {
          setState(() {
            _animalType = newValue!;
          });
        },
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: Color(0xFFFFD54F),
      ),
    );
  }
}

class _DetailsWidget extends StatelessWidget {
  final bool isLookingForAdoption;
  final BreedController breedController = Get.find<BreedController>();

   _DetailsWidget({
    Key? key,
    required this.isLookingForAdoption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              child: TextField(
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
              child: TextField(
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
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'เพศ:',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  labelStyle: TextStyle(fontSize: 15),
                ),
                items: [
                  DropdownMenuItem(value: '', child: Text('เลือกเพศ')),
                  DropdownMenuItem(value: 'ผู้', child: Text('ผู้')),
                  DropdownMenuItem(value: 'เมีย', child: Text('เมีย')),
                  DropdownMenuItem(
                      value: 'ไม่ทราบเพศ', child: Text('ไม่ทราบเพศ')),
                ],
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        if (!isLookingForAdoption) ...[
          SizedBox(height: 12),
          TextField(
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
      ],
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
  final SubDistrictController subDistrictController = Get.find<SubDistrictController>();
  final PostalCodeController postalCodeController =Get.find<PostalCodeController>();

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
                child: postalCodeController.buildZipCodeInput(),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextField(
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
}
