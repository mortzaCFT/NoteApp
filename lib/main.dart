import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notepad/controllers/theme_controller.dart';
import 'package:notepad/screens/HomeScreen.dart';
import 'package:notepad/untils/theme.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController()..loadTheme());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.isDarkMode.value ? ThemeData.dark() : AppTheme.theme,
        title: 'NotePad',
        home: HomeScreen(),
      );
    });
  }
}