import 'package:flutter/material.dart';
import 'package:newlife_app/app/modules/home/views/custom_bottom_nav_bar.dart';

class DonateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 221, 107),
      appBar: AppBar(
        title: Text('Donate'),
        backgroundColor: Color.fromARGB(255, 236, 217, 79),
      ),
      body: ListView(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 500,
              child: Image(
                image: NetworkImage('images/H-1.jpg'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                print("Copy Success");
              },
              child: Text('Copy'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
