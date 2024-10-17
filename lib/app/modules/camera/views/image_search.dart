import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../postPet/controllers/image_search_controller.dart';

class ImageSearch extends StatefulWidget {
  final String imagePath; // Assuming you have this variable in your widget

  const ImageSearch({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<ImageSearch> createState() => _ImageSearchState();
}

class _ImageSearchState extends State<ImageSearch> {
  String? _petType; // To store dog/cat selection
  String? _announcementType; // To store announcement selection
  ImageSearchController imageSearchController =
      Get.put(ImageSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: const Text('ค้นหาด้วยภาพ')),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: _buildRadioListTile(
                      title: 'สุนัข',
                      value: 'dog',
                      icon: Icons.pets,
                      groupValue: _petType,
                      onChanged: (value) {
                        setState(() {
                          _petType = value;
                        });
                      })),
              Expanded(
                  child: _buildRadioListTile(
                      title: 'แมว',
                      value: 'cat',
                      icon: Icons.pets,
                      groupValue: _petType,
                      onChanged: (value) {
                        setState(() {
                          _petType = value;
                        });
                      })),
            ],
          ),
          _buildRadioListTile(
            title: 'ประกาศหาผู้รับเลี้ยง',
            value: 'adopt_request',
            icon: Icons.favorite_border,
            groupValue: _announcementType,
            onChanged: (value) {
              setState(() {
                _announcementType = value;
              });
            },
          ),
          _buildRadioListTile(
            title: 'ประกาศตามหาเจ้าของสัตว์เลี้ยง',
            value: 'find_owner',
            icon: Icons.person_outline,
            groupValue: _announcementType,
            onChanged: (value) {
              setState(() {
                _announcementType = value;
              });
            },
          ),
          _buildRadioListTile(
            title: 'ประกาศตามหาสัตว์หาย',
            value: 'lost_pet',
            icon: Icons.pets,
            groupValue: _announcementType,
            onChanged: (value) {
              setState(() {
                _announcementType = value;
              });
            },
          ),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text('ค้นหาด้วยภาพ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFD54F),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: (() {
                if (_petType != null) {
                  imageSearchController.getImageSearch(
                      _petType!, File(widget.imagePath));
                } else {
                  Get.snackbar('Error', 'Please select a pet type.');
                }
              }),
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget _buildRadioListTile({
    required String title,
    required String value,
    required IconData icon,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RadioListTile<String>(
        title: Row(
          children: [
            Icon(icon, size: 24, color: Colors.black54),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 16)),
          ],
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.trailing,
        activeColor: const Color(0xFFFFD54F),
      ),
    );
  }
}
