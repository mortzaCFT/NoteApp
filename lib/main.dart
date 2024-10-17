import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/screens/HomeScreen.dart';
import 'package:notepad/untils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
       theme: AppTheme.theme, 
      title: 'NotePad',
      home: HomeScreen(),
    );
  }
}
