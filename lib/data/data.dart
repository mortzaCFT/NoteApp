import 'package:flutter/material.dart';

class Data {
  String id;  
  String title;
  String text;
  Color color;
  DateTime dateCreated; 
  String? signaturePath; 

  Data({
    required this.id,  
    required this.title,
    required this.text,
    required this.color,
    required this.dateCreated,
    this.signaturePath,
  });
}
