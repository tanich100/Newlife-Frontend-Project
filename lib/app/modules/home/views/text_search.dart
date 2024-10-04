import 'package:flutter/material.dart';

class TextSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 260.0, height: 50.0),
      child: TextField(
        
        decoration: InputDecoration(
          // hintText: 'Search pets',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28.0),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          
        ),
      ),
    );
  }
}
