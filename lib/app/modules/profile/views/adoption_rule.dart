import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdoptionRule extends StatefulWidget {
  @override
  _AdoptionRuleState createState() => _AdoptionRuleState();
}

class _AdoptionRuleState extends State<AdoptionRule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(
            margin: EdgeInsets.all(8),
            // decoration: BoxDecoration(
            //   color: Color(0xFFFFD54F),
            //   shape: BoxShape.circle,
            // ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () => Get.back(),
            ),
          ),
          title: Text('ขั้นตอนการอุปการะ',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
            child: Column(children: [
          Expanded(
            child: SingleChildScrollView(),
          ),
        ])));
  }
}
