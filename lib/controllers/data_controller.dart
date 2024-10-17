import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/data/data.dart' as noteData; 
import 'package:get_storage/get_storage.dart';

class DataController extends GetxController {
  var data = <noteData.Data>[].obs;  
  var filteredNotes = <noteData.Data>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadNotes(); 
  }

  DateTime _getCurrentDate() {
    return DateTime.now();
  }

  void add_Note(String title, String text, Color color) {
    data.add(noteData.Data( 
      title: title,
      text: text,
      color: color,
      dateCreated: _getCurrentDate(), 
    ));
    _saveNotes(); 
  }

  void del_Note(int index) {
    data.removeAt(index);
    _saveNotes(); 
  }

  void updateNote(int index, String title, String text, Color color) {
    var oldNote = data[index]; 
    data[index] = noteData.Data(
      title: title,
      text: text,
      color: color,
      dateCreated: oldNote.dateCreated, 
    );
    _saveNotes();
  }

  void updateSearchResults(String query) {
    final lowerQuery = query.toLowerCase();
    filteredNotes.value = data.where((note) {
      return note.title.toLowerCase().contains(lowerQuery) ||
             note.text.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  void _loadNotes() {
    List<dynamic>? storedData = storage.read<List<dynamic>>('notes');

    if (storedData != null) {
      data.value = storedData.map((note) {
        var noteParts = note.split('||'); 
        return noteData.Data( 
          title: noteParts[0],
          text: noteParts[1],
          color: Color(int.parse(noteParts[2])),
          dateCreated: DateTime.parse(noteParts[3]), 
        );
      }).toList();
    }
  }

  void _saveNotes() {
    List<String> noteStrings = data.map((note) {
      return '${note.title}||${note.text}||${note.color.value}||${note.dateCreated.toIso8601String()}';
    }).toList();
    storage.write('notes', noteStrings); 
  }
}
