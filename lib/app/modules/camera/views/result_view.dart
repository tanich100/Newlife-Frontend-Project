import 'package:flutter/material.dart';
import 'package:newlife_app/app/modules/camera/views/result_widget.dart';

class ResultView extends StatefulWidget {
  ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ผลการค้นหาจากภาพ'),
        backgroundColor: Color.fromARGB(255, 239, 190, 31),
      ),
      body: Container(
        child: ResultWidget(),
      ),
    );
  }
}
