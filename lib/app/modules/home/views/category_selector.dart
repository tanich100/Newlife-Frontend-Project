import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final Function(String) onTagSelected;

  CategorySelector({required this.onTagSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCategoryButton('All'),
        _buildCategoryButton('Dogs'),
        _buildCategoryButton('Cats'),
        _buildCategoryButton('Lost Animals'),
        _buildCategoryButton('Special Care'),
      ],
    );
  }

  Widget _buildCategoryButton(String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: () {
          onTagSelected(tag);
        },
        child: Text(tag),
      ),
    );
  }
}
