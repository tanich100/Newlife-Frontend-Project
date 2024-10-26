import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newlife_app/app/modules/home/controllers/home_controller.dart';
import 'package:newlife_app/app/modules/notification/controllers/notification_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    final NotificationController notificationController =
        Get.find<NotificationController>();

    return BottomNavigationBar(
      currentIndex: _getCurrentIndex(controller),
      onTap: _onItemTapped,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.money),
          label: 'Donate',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications),
              Obx(() {
                final unreadCount =
                    notificationController.unreadNotificationCount.value;
                if (unreadCount > 0) {
                  return Positioned(
                    right: -10,
                    top: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        unreadCount > 99 ? '99+' : unreadCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ],
          ),
          label: 'Notifications',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      backgroundColor: const Color(0xfffdcf09),
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
    // เพิ่มการรีเฟรชข้อมูลแจ้งเตือนเมื่อกดไปที่หน้าแจ้งเตือน
    if (index == 2) {
      final notificationController = Get.find<NotificationController>();
      notificationController.refreshAllNotifications();
    }

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
