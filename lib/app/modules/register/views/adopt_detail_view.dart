import 'package:flutter/material.dart';
import 'package:newlife_app/app/modules/login/views/login_view.dart';
import 'package:newlife_app/app/modules/register/views/interest_view.dart';

class AdoptView extends StatefulWidget {
  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptView> {
  String? _selectedIncome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0), // ปรับความสูงตามต้องการ
        child: AppBar(
          title: Text(
            'บันทึกข้อมูลสำหรับการอุปการะ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ส่วนข้อมูลเบื้องต้น
            _buildFormRow(),
            SizedBox(height: 8),
            _buildFormmRow(),
            SizedBox(height: 8),
            _buildFormmmRow(),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('รายได้ต่อเดือน (บาท)*:'),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                SizedBox(
                  width: 150,
                  child: RadioListTile<String>(
                    title: Text(
                      'น้อยกว่า 10,000',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: 'น้อยกว่า 10,000',
                    groupValue: _selectedIncome,
                    onChanged: (value) {
                      setState(() {
                        _selectedIncome = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: RadioListTile<String>(
                    title: Text(
                      '10,000 - 19,000',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: '10,000 - 19,000',
                    groupValue: _selectedIncome,
                    onChanged: (value) {
                      setState(() {
                        _selectedIncome = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: RadioListTile<String>(
                    title: Text(
                      '20,000 - 29,000',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: '20,000 - 29,000',
                    groupValue: _selectedIncome,
                    onChanged: (value) {
                      setState(() {
                        _selectedIncome = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: RadioListTile<String>(
                    title: Text(
                      '30,000 - 39,000',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: '30,000 - 39,000',
                    groupValue: _selectedIncome,
                    onChanged: (value) {
                      setState(() {
                        _selectedIncome = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: RadioListTile<String>(
                    title: Text(
                      'มากกว่า 39,000',
                      style: TextStyle(fontSize: 12),
                    ),
                    value: 'มากกว่า 39,000',
                    groupValue: _selectedIncome,
                    onChanged: (value) {
                      setState(() {
                        _selectedIncome = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildAdsField('ขนาดของที่อยู่อาศัย(ตารางเมตร)*'),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ประสบการณ์ในการดูแลสัตว์เลี้ยง*', // Label text ที่คุณต้องการแสดง
                    style: TextStyle(fontSize: 14), // กำหนดขนาดของ label text
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'มี',
                            groupValue: _selectedIncome,
                            onChanged: (value) {
                              setState(() {
                                _selectedIncome = value;
                              });
                            },
                          ),
                          Text(
                            'มี',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(width: 16), // เพิ่มช่องว่างระหว่างตัวเลือก
                      Row(
                        children: [
                          Radio<String>(
                            value: 'ไม่มี',
                            groupValue: _selectedIncome,
                            onChanged: (value) {
                              setState(() {
                                _selectedIncome = value;
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
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ข้อมูลที่อยู่อาศัย ประเภทของที่อยู่*', // Label text ที่คุณต้องการแสดง
                    style: TextStyle(fontSize: 14), // กำหนดขนาดของ label text
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio<String>(
                            value: 'บ้านเดี่ยว',
                            groupValue: _selectedIncome,
                            onChanged: (value) {
                              setState(() {
                                _selectedIncome = value;
                              });
                            },
                          ),
                          Text(
                            'บ้านเดี่ยว',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(width: 16), // เพิ่มช่องว่างระหว่างตัวเลือก
                      Row(
                        children: [
                          Radio<String>(
                            value: 'คอนโดมิเนี่ยม',
                            groupValue: _selectedIncome,
                            onChanged: (value) {
                              setState(() {
                                _selectedIncome = value;
                              });
                            },
                          ),
                          Text(
                            'คอนโดมีเนี่ยม',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(width: 16), // เพิ่มช่องว่างระหว่างตัวเลือก
                      Row(
                        children: [
                          Radio<String>(
                            value: 'อาพาร์ทเม้น',
                            groupValue: _selectedIncome,
                            onChanged: (value) {
                              setState(() {
                                _selectedIncome = value;
                              });
                            },
                          ),
                          Text(
                            'อาพาร์ทเม้น',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(width: 16), // เพิ่มช่องว่างระหว่างตัวเลือก
                      Row(
                        children: [
                          Radio<String>(
                            value: 'บ้านเช่า',
                            groupValue: _selectedIncome,
                            onChanged: (value) {
                              setState(() {
                                _selectedIncome = value;
                              });
                            },
                          ),
                          Text(
                            'บ้านเช่า',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 500,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'เวลาว่างต่อวัน*', // Label text ที่คุณต้องการแสดง
                      style: TextStyle(fontSize: 14), // กำหนดขนาดของ label text
                    ),
                    SizedBox(width: 16), // เพิ่มช่องว่างระหว่างตัวเลือก
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: '3-5 ชั่วโมง',
                                groupValue: _selectedIncome,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedIncome = value;
                                  });
                                },
                              ),
                              Text(
                                '3-5 ชั่วโมง',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: '6-8 ชั่วโมง',
                                groupValue: _selectedIncome,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedIncome = value;
                                  });
                                },
                              ),
                              Text(
                                '6-8 ชั่วโมง',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: '9-12 ชั่วโมง',
                                groupValue: _selectedIncome,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedIncome = value;
                                  });
                                },
                              ),
                              Text(
                                '9-12 ชั่วโมง',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(
              height: 16,
            ),
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
        child: _buildGenderField('เพศ*'),
      ),
      SizedBox(width: 10),
      Expanded(
        child: _buildAgeField('อายุ*'),
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
        child: _buildEmailField('อีเมล*'),
      ),
      SizedBox(width: 10),
      Expanded(
        child: _buildPhoneField('เบอร์โทรติดต่อ*'),
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

Widget _buildFormmmRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: _buildOccField('อาชีพ*'),
      ),
      SizedBox(width: 10),
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
