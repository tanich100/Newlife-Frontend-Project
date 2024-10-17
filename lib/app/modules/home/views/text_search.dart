import 'package:flutter/material.dart';

class TextSearch extends StatelessWidget {
  final Function(String) onTextChanged;

  TextSearch({required this.onTextChanged});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Container(
      constraints: BoxConstraints.tightFor(width: 260.0, height: 50.0),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          onTextChanged(value); // Call the callback function with the new value
        },
        decoration: InputDecoration(
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
