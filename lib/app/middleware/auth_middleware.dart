import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newlife_app/app/routes/app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final storage = GetStorage();
    if (storage.hasData('token')) {
      return null;
    } else if (route != Routes.LOGIN) {
      return RouteSettings(name: Routes.LOGIN);
    }
    return null;
  }
}
