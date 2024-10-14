import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class AdoptView extends GetView<RegisterController> {
  AdoptView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('บันทึกรายละเอียดเพิ่มเติม',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
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
                _buildTextField('ชื่อ', controller.nameController),
                SizedBox(height: 16),
                _buildTextField('นามสกุล', controller.lastNameController),
                SizedBox(height: 16),
                _buildTextField('เบอร์โทรศัพท์', controller.telController),
                SizedBox(height: 16),
                _buildTextField('เพศ', controller.genderController),
                SizedBox(height: 16),
                _buildTextField('อายุ', controller.ageController),
                SizedBox(height: 16),
                _buildTextField('ที่อยู่', controller.addressController),
                SizedBox(height: 16),
                _buildTextField('อาชีพ', controller.careerController),
                SizedBox(height: 16),
                _buildTextField('จำนวนสมาชิกในครอบครัว',
                    controller.numOfFamMembersController),
                SizedBox(height: 16),
                _buildTextField('ประสบการณ์การดูแลสัตว์เลี้ยง',
                    controller.experienceController),
                SizedBox(height: 16),
                _buildTextField('ขนาดที่อยู่อาศัย (ตารางเมตร)',
                    controller.sizeOfResidenceController),
                SizedBox(height: 16),
                _buildTextField(
                    'ประเภทที่อยู่อาศัย', controller.typeOfResidenceController),
                SizedBox(height: 16),
                _buildTextField('เวลาว่างต่อวัน (ชั่วโมง)',
                    controller.freeTimePerDayController),
                SizedBox(height: 16),
                _buildTextField('เหตุผลในการรับเลี้ยงสัตว์',
                    controller.reasonForAdoptionController),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.register, // บันทึกข้อมูลและไปหน้า login
                  child: Text('บันทึกข้อมูลและไปที่หน้าเข้าสู่ระบบ'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      controller: controller,
    );
  }
}
