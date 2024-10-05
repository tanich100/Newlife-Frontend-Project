import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(controller),
      onTap: (index) {
        _onItemTapped(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: 'Donate',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      backgroundColor: Color(0xfffdcf09),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      type: BottomNavigationBarType.fixed,
    );
  }

  int _getCurrentIndex(HomeController controller) {
    final currentRoute = Get.currentRoute;
    switch (currentRoute) {
      case '/home':
        return 0;
      case '/donate':
        return 1;
      case '/notification':
        return 2;
      case '/profile':
        return 3;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Get.offNamed('/home');
        break;
      case 1:
        Get.offNamed('/donate');
        break;
      case 2:
        Get.offNamed('/notification');
        break;
      case 3:
        Get.offNamed('/profile');
        break;
    }
  }
}
