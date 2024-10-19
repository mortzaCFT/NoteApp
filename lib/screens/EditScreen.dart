import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/controllers/data_controller.dart';
import 'package:notepad/controllers/theme_controller.dart';

class EditScreen extends StatelessWidget {
  final String noteId;
  final DataController controller = Get.find();

  EditScreen({Key? key, required this.noteId}) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Use noteId to find the note
    var note = controller.data.firstWhere((note) => note.id == noteId); 

    // Set the text controllers to the current note's values
    titleController.text = note.title;
    textController.text = note.text;

    return Obx(() {
      Color scaffoldColor = themeController.isDarkMode.value
          ? Colors.white
          : Color.fromARGB(27, 255, 255, 255);
      Color textColor =
          themeController.isDarkMode.value ? Colors.black : Colors.white;

      return Scaffold(
        backgroundColor: scaffoldColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Edit Note', style: TextStyle(color: textColor)),
          actions: [
            IconButton(
              icon: Icon(Icons.check, color: textColor),
              onPressed: () {
                String updatedTitle = titleController.text;
                String updatedText = textController.text;

                // Validate input before updating the note
                if (updatedTitle.isNotEmpty && updatedText.isNotEmpty) {
                  controller.updateNote(
                    note.id, // Use note's ID for updating
                    updatedTitle,
                    updatedText,
                    note.color, // Retain the original color
                  );
                  Get.back(); // Close the EditScreen
                } else {
                  // Show a snackbar if the input is invalid
                  Get.snackbar(
                    'Error',
                    'Please provide both title and text for the note.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.close, color: textColor),
              onPressed: () {
                Get.back(); // Close the EditScreen without saving
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
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(color: textColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: textController,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Text',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: textColor),
                  ),
                ),
                maxLines: 18,
              ),
              SizedBox(height: 20),
              Text(
                'Note Color:',
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
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
    });
  }
}
