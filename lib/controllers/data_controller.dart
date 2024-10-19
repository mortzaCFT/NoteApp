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
    clearOldNotes();
    _loadNotes();
  }

  DateTime _getCurrentDate() {
    return DateTime.now();
  }

  void add_Note(String title, String text, Color color, String? signature) {
    final newNote = noteData.Data(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      text: text,
      color: color,
      dateCreated: _getCurrentDate(),
      signaturePath: signature,
    );
    data.add(newNote);
    _saveNotes();
  }

  void del_Note(String id) {
    data.removeWhere((note) => note.id == id);
    _saveNotes();
  }

  void updateNote(String id, String title, String text, Color color) {
    var index = data.indexWhere((note) => note.id == id);
    if (index != -1) {
      var oldNote = data[index];
      data[index] = noteData.Data(
        id: oldNote.id, 
        title: title,
        text: text,
        color: color,
        dateCreated: oldNote.dateCreated,
      );
      _saveNotes();
    }
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
        
        if (noteParts.length != 5) {
          throw Exception('Invalid note format: $note');
        }

        return noteData.Data(
          id: noteParts[4], 
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
      return '${note.title}||${note.text}||${note.color.value}||${note.dateCreated.toIso8601String()}||${note.id}'; // Include ID
    }).toList();
    storage.write('notes', noteStrings);
  }

  void clearOldNotes() {
    storage.remove('notes');
    data.clear(); 
  }
}
