import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/routes/app_pages.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  HttpOverrides.global = MyHttpOverrides();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: determineInitialRoute(),
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.notoSansThaiTextTheme()),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white, // กำหนดสีพื้นหลังของ AppBar
            ),
            textTheme: GoogleFonts.notoSansThaiTextTheme(),
            scaffoldBackgroundColor: Colors.white,
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: Color.fromARGB(255, 239, 190, 31),
            ),
          ),
          child: child!,
        );
      },
    ),
  );
}

String determineInitialRoute() {
  final storage = GetStorage();
  return storage.hasData('token') ? Routes.HOME : Routes.LOGIN;
}
