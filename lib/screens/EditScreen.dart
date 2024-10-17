import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/controllers/data_controller.dart';

class EditScreen extends StatelessWidget {
  final int noteIndex; 
  final DataController controller = Get.find(); 

  EditScreen({Key? key, required this.noteIndex}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var note = controller.data[noteIndex];

    titleController.text = note.title;
    textController.text = note.text;

    return Scaffold(
      backgroundColor: const Color.fromARGB(27, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Edit Note', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: () {

              String updatedTitle = titleController.text;
              String updatedText = textController.text;

              if (updatedTitle.isNotEmpty && updatedText.isNotEmpty) {
                controller.updateNote(
                  noteIndex,
                  updatedTitle,
                  updatedText,
                  note.color, 
                );
                Get.back(); 
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: textController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Text',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              maxLines: 18,
            ),
            SizedBox(height: 20),
            Text(
              'Note Color:',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: note.color,
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
