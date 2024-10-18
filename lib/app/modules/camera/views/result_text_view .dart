import 'package:flutter/material.dart';
import 'package:newlife_app/app/modules/camera/views/result_text_widget.dart';

class ResultTextView extends StatefulWidget {
  ResultTextView({super.key});

  @override
  State<ResultTextView> createState() => _ResultTextViewState();
}

class _ResultTextViewState extends State<ResultTextView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('ผลการค้นหาจากคำค้นหา'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(child: ResultTextWidget(),),);
  }
}