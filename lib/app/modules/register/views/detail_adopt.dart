import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/register/views/interest_view.dart';
import '../controllers/register_controller.dart';

class AdoptView extends GetView<RegisterController> {
  AdoptView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('บันทึกรายละเอียดเพิ่มเติม',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child:
                            _buildTextField('ชื่อ', controller.nameController)),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildTextField(
                            'นามสกุล', controller.lastNameController)),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _buildTextField(
                            'เบอร์โทรศัพท์', controller.telController)),
                    SizedBox(width: 16),
                    Expanded(
                        child: _buildTextField(
                            'เพศ', controller.genderController)),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildTextField('อายุ', controller.ageController),
                    )
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child:
                          _buildTextField('อาชีพ', controller.careerController),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildTextField('รายได้ต่อเดือน(บาท)',
                          controller.monthlyIncomeController),
                    )
                  ],
                ),
                SizedBox(height: 16),
                _buildTextField('จำนวนสมาชิกในครอบครัว',
                    controller.numOfFamMembersController),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                          'ที่อยู่', controller.addressController),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _buildTextField('ขนาดของที่อยู่อาศัย(ตารางเมตร)',
                          controller.sizeOfResidenceController),
                    )
                  ],
                ),
                SizedBox(height: 16),
                _buildTextField(
                    'ประเภทที่อยู่อาศัย (บ้าน / คอนโด / อพาร์ทเมนท์)',
                    controller.typeOfResidenceController),
                SizedBox(height: 16),
                _buildTextField('เวลาว่างต่อวัน (ชั่วโมง)',
                    controller.freeTimePerDayController),
                SizedBox(height: 16),
                _buildTextField('เหตุผลในการรับเลี้ยงสัตว์',
                    controller.reasonForAdoptionController),
                SizedBox(height: 16),
                // เพิ่ม Checkbox สำหรับ isHaveExperience
                Row(
                  children: [
                    Text("มีประสบการณ์ในการดูแลสัตว์หรือไม่"),
                    Obx(() => Checkbox(
                          value: controller.isHaveExperience.value,
                          onChanged: (value) {
                            controller.isHaveExperience.value = value ?? false;
                          },
                        )),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _validateAndSubmit,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(Color(0xfffdcf09)),
                      foregroundColor: WidgetStateProperty.all(Colors.black),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Color(0xfffdcf09)),
                        ),
                      ),
                    ),
                    child: Text(
                      'บันทึกข้อมูล',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSubmit() {
    // Check if all fields are filled
    if (controller.nameController.text.isEmpty ||
        controller.lastNameController.text.isEmpty ||
        controller.telController.text.isEmpty ||
        controller.genderController.text.isEmpty ||
        controller.ageController.text.isEmpty ||
        controller.careerController.text.isEmpty ||
        controller.monthlyIncomeController.text.isEmpty ||
        controller.numOfFamMembersController.text.isEmpty ||
        controller.addressController.text.isEmpty ||
        controller.sizeOfResidenceController.text.isEmpty ||
        controller.typeOfResidenceController.text.isEmpty ||
        controller.freeTimePerDayController.text.isEmpty ||
        controller.reasonForAdoptionController.text.isEmpty) {
      // Show snackbar if validation fails
      Get.snackbar(
        'ข้อผิดพลาด',
        'กรุณากรอกข้อมูลให้ครบทุกช่อง',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } else {
      // Navigate to InterestView if validation passes
      Get.to(() => InterestView());
    }
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 20), // ปรับ vertical padding
      ),
      controller: controller,
    );
  }
}
