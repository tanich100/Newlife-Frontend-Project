import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String name;
  final String message;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    Key? key,
    required this.title,
    required this.name,
    required this.message,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: Text(message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text(
                'ยกเลิก',
                style: TextStyle(color: Colors.grey[800]),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[200],
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text(
                'ยืนยัน',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFD54F),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                onConfirm();
              },
            ),
          ],
        ),
      ],
    );
  }
}
