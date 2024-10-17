import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String name;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    Key? key,
    this.title = 'อนุมัติ ?',
    required this.name,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(title)),
      content: Text('ต้องการอนุมัติให้ $name รับเลี้ยงหรือไม่'),
      actions: <Widget>[
        TextButton(
          child: Text('ยกเลิก'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 250, 250, 250),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        ElevatedButton(
          child: Text('ยืนยัน'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 234, 212, 110),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            onConfirm(); // เรียกใช้ฟังก์ชันอนุมัติ
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
