import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/data/models/user_update_dto.dart';
import '../controllers/edit_user_info_controller.dart';

class EditUserInfoView extends GetView<EditUserInfoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลการอุปการะ'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final userUpdate = controller.userUpdateDto.value;
        if (userUpdate == null) {
          return Center(child: Text('ไม่พบข้อมูลผู้ใช้'));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ข้อมูลผู้อุปการะ',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),

                // ข้อมูลส่วนตัว
                Row(
                  children: [
                    Expanded(
                      child: _buildEditableTextField(
                          'ชื่อ',
                          userUpdate.name,
                          (val) => userUpdate.name = val,
                          controller.isNameEditable),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildEditableTextField(
                          'นามสกุล',
                          userUpdate.lastName,
                          (val) => userUpdate.lastName = val,
                          controller.isLastNameEditable),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildEditableTextField(
                          'เบอร์โทรศัพท์',
                          userUpdate.tel,
                          (val) => userUpdate.tel = val,
                          controller.isTelEditable),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _buildEditableTextField(
                          'เพศ',
                          userUpdate.gender,
                          (val) => userUpdate.gender = val,
                          controller.isGenderEditable),
                    ),
                  ],
                ),
                _buildEditableNumberField(
                    'อายุ',
                    userUpdate.age,
                    (val) => userUpdate.age = int.tryParse(val),
                    controller.isAgeEditable),
                _buildEditableTextField(
                    'ที่อยู่',
                    userUpdate.address,
                    (val) => userUpdate.address = val,
                    controller.isAddressEditable),
                _buildEditableTextField(
                    'อาชีพ',
                    userUpdate.career,
                    (val) => userUpdate.career = val,
                    controller.isCareerEditable),
                _buildEditableNumberField(
                    'จำนวนสมาชิกในครอบครัว',
                    userUpdate.numOfFamMembers,
                    (val) => userUpdate.numOfFamMembers = int.tryParse(val),
                    controller.isFamMembersEditable),

                _buildExperienceField(
                    userUpdate, controller.isHaveExperienceEditable),
                _buildEditableTextField(
                    'ขนาดที่อยู่อาศัย',
                    userUpdate.sizeOfResidence,
                    (val) => userUpdate.sizeOfResidence = val,
                    controller.isSizeOfResidenceEditable),
                _buildEditableTextField(
                    'ประเภทที่อยู่อาศัย (บ้าน/คอนโด/อพาร์ทเมนท์)',
                    userUpdate.typeOfResidence,
                    (val) => userUpdate.typeOfResidence = val,
                    controller.isTypeOfResidenceEditable),
                _buildEditableNumberField(
                    'เวลาว่างต่อวัน (ชั่วโมง)',
                    userUpdate.freeTimePerDay,
                    (val) => userUpdate.freeTimePerDay = int.tryParse(val),
                    controller.isFreeTimeEditable),
                _buildEditableNumberField(
                    'รายได้ต่อเดือน (บาท)',
                    userUpdate.monthlyIncome,
                    (val) => userUpdate.monthlyIncome = int.tryParse(val),
                    controller.isMonthlyIncomeEditable),

                SizedBox(height: 24),
                Text('เหตุผลในการอุปการะ',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'กรุณาระบุเหตุผลในการอุปการะ',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'กรุณาระบุเหตุผล' : null,
                  onSaved: (value) =>
                      controller.reasonForAdoption.value = value ?? '',
                ),
                SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    onPressed: () => controller.updateUserAndSubmit(),
                    child: Text('ยืนยันข้อมูล'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildExperienceField(UserUpdateDto userUpdate, RxBool isEditable) {
    final currentValue = (userUpdate.isHaveExperience ?? false).obs;

    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isEditable.value ? Colors.white : Colors.grey[200],
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'มีประสบการณ์เลี้ยงสัตว์',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isEditable.value
                              ? Icons.save_as_outlined
                              : Icons.edit,
                          color: isEditable.value
                              ? const Color.fromARGB(255, 114, 171, 96)
                              : Colors.grey,
                        ),
                        onPressed: () {
                          isEditable.value = !isEditable.value;
                          if (!isEditable.value) {
                            // เมื่อกด save บันทึกค่าใหม่
                            userUpdate.isHaveExperience = currentValue.value;
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: currentValue.value,
                              onChanged: isEditable.value
                                  ? (value) {
                                      if (value != null) {
                                        currentValue.value = value;
                                      }
                                    }
                                  : null,
                              activeColor:
                                  const Color.fromARGB(255, 114, 171, 96),
                            ),
                            Text('มี'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio<bool>(
                              value: false,
                              groupValue: currentValue.value,
                              onChanged: isEditable.value
                                  ? (value) {
                                      if (value != null) {
                                        currentValue.value = value;
                                      }
                                    }
                                  : null,
                              activeColor:
                                  const Color.fromARGB(255, 114, 171, 96),
                            ),
                            Text('ไม่มี'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildEditableTextField(String label, String? initialValue,
      Function(String) onChanged, RxBool isEditable) {
    // ใช้ RxString เพื่อเก็บค่าระหว่างการแก้ไข
    final editingValue = RxString(initialValue ?? '');
    final textController = TextEditingController(text: initialValue);

    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            TextField(
              controller: textController,
              enabled: isEditable.value,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
                fillColor: isEditable.value ? Colors.white : Colors.grey[200],
                filled: true,
              ),
              onChanged: (value) {
                if (isEditable.value) {
                  editingValue.value = value;
                }
              },
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(
                  isEditable.value ? Icons.save_as_outlined : Icons.edit,
                  color: isEditable.value
                      ? const Color.fromARGB(255, 114, 171, 96)
                      : Colors.grey,
                ),
                onPressed: () {
                  isEditable.value = !isEditable.value;
                  if (!isEditable.value) {
                    // เมื่อกด save บันทึกค่าใหม่
                    onChanged(editingValue.value);
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildEditableNumberField(String label, int? initialValue,
      Function(String) onChanged, RxBool isEditable) {
    // ใช้ RxString เพื่อเก็บค่าระหว่างการแก้ไข
    final editingValue = RxString(initialValue?.toString() ?? '');
    final textController =
        TextEditingController(text: initialValue?.toString());

    return Obx(() {
      return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            TextField(
              controller: textController,
              enabled: isEditable.value,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
                fillColor: isEditable.value ? Colors.white : Colors.grey[200],
                filled: true,
              ),
              onChanged: (value) {
                if (isEditable.value) {
                  editingValue.value = value;
                }
              },
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: Icon(
                  isEditable.value ? Icons.save_as_outlined : Icons.edit,
                  color: isEditable.value
                      ? const Color.fromARGB(255, 114, 171, 96)
                      : Colors.grey,
                ),
                onPressed: () {
                  isEditable.value = !isEditable.value;
                  if (!isEditable.value) {
                    // เมื่อกด save บันทึกค่าใหม่
                    onChanged(editingValue.value);
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
