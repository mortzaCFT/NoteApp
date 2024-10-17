import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:notepad/data/date.dart';

class DataController extends GetxController {
  var data = <Data>[].obs;
  var filteredNotes = <Data>[].obs;
  
  void add_Note(String title, String text, Color color) {
    data.add(Data(
      title: title,
      text: text,
      color: color,
    ));
  }

  void del_Note(int index) {
    data.removeAt(index);
  }

  void updateNote(int index, String title, String text, Color color) {
    data[index] = Data(title: title, text: text, color: color); 
  }

    void updateSearchResults(String query) {
    final lowerQuery = query.toLowerCase();
    filteredNotes.value = data.where((note) {
      return note.title.toLowerCase().contains(lowerQuery) ||
             note.text.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}