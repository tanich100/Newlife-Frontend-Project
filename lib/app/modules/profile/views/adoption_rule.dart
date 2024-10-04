import 'package:flutter/material.dart';

class AdoptionRule extends StatefulWidget {
  @override
  _AdoptionRuleState createState() => _AdoptionRuleState();
}

class _AdoptionRuleState extends State<AdoptionRule> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ขั้นตอนการรับอุปการะ'),
        ),
        body: Padding(padding: const EdgeInsets.all(16.0), child: Column()),
      ),
    );
  }
}
