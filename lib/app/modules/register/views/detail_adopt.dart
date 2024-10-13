import 'package:flutter/material.dart';
import 'package:newlife_app/app/modules/login/views/login_view.dart';
import 'package:newlife_app/app/modules/register/views/interest_view.dart';

class AdoptView extends StatefulWidget {
  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptView> {
  String? _selectedIncome;
  String? _selectedExperience;
  String? _selectedHousingType;
  String? _selectedFreeTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: AppBar(
          title: Text(
            'บันทึกข้อมูลสำหรับการอุปการะ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ส่วนข้อมูลเบื้องต้น
            _buildFormRow(),
            SizedBox(height: 8),
            _buildFormmRow(),
            SizedBox(height: 8),
            _buildFormmmRow(),

            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('รายได้ต่อเดือน (บาท)*:'),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                // ชุด Radio สำหรับรายได้
                _buildIncomeRadio('น้อยกว่า 10,000', 'น้อยกว่า 10,000'),
                _buildIncomeRadio('10,000 - 19,000', '10,000 - 19,000'),
                _buildIncomeRadio('20,000 - 29,000', '20,000 - 29,000'),
                _buildIncomeRadio('30,000 - 39,000', '30,000 - 39,000'),
                _buildIncomeRadio('มากกว่า 39,000', 'มากกว่า 39,000'),
              ],
            ),
            SizedBox(height: 16),
            _buildAdsField('ขนาดของที่อยู่อาศัย(ตารางเมตร)*'),
            SizedBox(height: 16),
            _buildExperienceField(),
            SizedBox(height: 16),
            _buildHousingTypeField(),
            SizedBox(height: 16),
            _buildFreeTimeField(),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InterestView()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.yellow),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Colors.yellow),
                      ),
                    ),
                  ),
                  child: Text(
                    'บันทึกข้อมูล',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }


  Widget _buildIncomeRadio(String label, String value) {
    return SizedBox(
      width: 150,
      child: RadioListTile<String>(
        title: Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
        value: value,
        groupValue: _selectedIncome,
        onChanged: (value) {
          setState(() {
            _selectedIncome = value;
          });
        },
      ),
    );
  }


  Widget _buildExperienceField() {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ประสบการณ์ในการดูแลสัตว์เลี้ยง*',
            style: TextStyle(fontSize: 14),
          ),
          Row(
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: 'มี',
                    groupValue: _selectedExperience,
                    onChanged: (value) {
                      setState(() {
                        _selectedExperience = value;
                      });
                    },
                  ),
                  Text(
                    'มี',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Row(
                children: [
                  Radio<String>(
                    value: 'ไม่มี',
                    groupValue: _selectedExperience,
                    onChanged: (value) {
                      setState(() {
                        _selectedExperience = value;
                      });
                    },
                  ),
                  Text(
                    'ไม่มี',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildHousingTypeField() {
    return SizedBox(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ข้อมูลที่อยู่อาศัย ประเภทของที่อยู่*',
            style: TextStyle(fontSize: 14),
          ),
          Row(
            children: [
              _buildHousingTypeRadio('บ้านเดี่ยว', 'บ้านเดี่ยว'),
              SizedBox(width: 16),
              _buildHousingTypeRadio('คอนโดมิเนี่ยม', 'คอนโดมิเนี่ยม'),
            ],
          ),
          Row(
            children: [
              _buildHousingTypeRadio('อาพาร์ทเม้น', 'อาพาร์ทเม้น'),
              SizedBox(width: 16),
              _buildHousingTypeRadio('บ้านเช่า', 'บ้านเช่า'),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildFreeTimeField() {
    return SizedBox(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'เวลาว่างต่อวัน*',
            style: TextStyle(fontSize: 14),
          ),
          Row(
            children: [
              _buildFreeTimeRadio('3-5 ชั่วโมง', '3-5 ชั่วโมง'),
              _buildFreeTimeRadio('6-8 ชั่วโมง', '6-8 ชั่วโมง'),
              _buildFreeTimeRadio('9-12 ชั่วโมง', '9-12 ชั่วโมง'),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildHousingTypeRadio(String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: _selectedHousingType,
            onChanged: (value) {
              setState(() {
                _selectedHousingType = value;
              });
            },
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }


  Widget _buildFreeTimeRadio(String label, String value) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: _selectedFreeTime,
            onChanged: (value) {
              setState(() {
                _selectedFreeTime = value;
              });
            },
          ),
          Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }}

Widget _buildAdsField(String label) {
  return Container(
    width: 300, // กำหนดความกว้างที่ต้องการ
    height: 60, // กำหนดความสูงที่ต้องการ
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
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
    ),
  );
}

Widget _buildFormmmRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: _buildNofField('จำนวนสมาชิกในครอบครัว*'),
      ),
    ],
  );
}

Widget _buildOccField(String label) {
  return Container(
    width: 300,
    height: 60,
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
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
    ),
  );
}

Widget _buildNofField(String label) {
  return Container(
    width: 300, // กำหนดความกว้างที่ต้องการ
    height: 60, // กำหนดความสูงที่ต้องการ
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
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
    ),
  );
}

Widget _buildFormRow() {
  return Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceBetween, // จัดฟิลด์ให้มีช่องว่างระหว่างกัน
    children: [
      Expanded(
        child: _buildNameField('ชื่อ-นามสกุล*'),
      ),
      SizedBox(width: 10),
      Expanded(
        child: _buildGenderField('เบอร์โทรติดต่อ*'),
      ),
    ],
  );
}

Widget _buildNameField(String label) {
  return Container(
    width: 300, // กำหนดความกว้างที่ต้องการ
    height: 60, // กำหนดความสูงที่ต้องการ
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
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
    ),
  );
}

Widget _buildGenderField(String label) {
  return Container(
    width: 300, // กำหนดความกว้างที่ต้องการ
    height: 60, // กำหนดความสูงที่ต้องการ
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
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
    ),
  );
}

Widget _buildAgeField(String label) {
  return Container(
    width: 300, // กำหนดความกว้างที่ต้องการ
    height: 60, // กำหนดความสูงที่ต้องการ
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
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
    ),
  );
}

Widget _buildFormmRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: _buildAgeField('อายุ*'),
      ),
      SizedBox(width: 10),
      Expanded(
        child: _buildPhoneField('เพศ*'),
      ),
      SizedBox(width: 10),
      Expanded(
        child: _buildPhoneField('อาชีพ*'),
      ),
    ],
  );
}

Widget _buildEmailField(String label) {
  return Container(
    width: 300,
    height: 60,
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      ),
    ),
  );
}

Widget _buildPhoneField(String label) {
  return Container(
    width: 300,
    height: 60,
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Color.fromARGB(255, 221, 221, 221),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      ),
    ),
  );
}