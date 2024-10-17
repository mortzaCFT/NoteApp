import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:notepad/controllers/data_controller.dart';

class AddNew extends StatelessWidget {
  AddNew({super.key, required this.controller});

  final Rx<Color> selectedColor = Rx<Color>(Colors.blue);  
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  final DataController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(27, 255, 255, 255),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add New Note',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextField(
            cursorColor: Colors.grey,
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
            cursorColor: Colors.grey,
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
            maxLines: 3,
          ),
          SizedBox(height: 20),
          Text('Select Color :',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: [
              GestureDetector(
                onTap: () {
                  selectedColor.value = Colors.blue;
                },
                child: Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          color: selectedColor.value == Colors.blue
                              ? Colors.white
                              : Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  selectedColor.value = Colors.red;
                },
                child: Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        border: Border.all(
                          color: selectedColor.value == Colors.red
                              ? Colors.white
                              : Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  selectedColor.value = Colors.greenAccent;
                },
                child: Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        border: Border.all(
                          color: selectedColor.value == Colors.greenAccent
                              ? Colors.white
                              : Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  selectedColor.value = Colors.purple.shade500;
                },
                child: Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.purple.shade500,
                        border: Border.all(
                          color: selectedColor.value == Colors.purple.shade500
                              ? Colors.white
                              : Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  selectedColor.value = Colors.grey.shade500;
                },
                child: Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        border: Border.all(
                          color: selectedColor.value == Colors.grey.shade500
                              ? Colors.white
                              : Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  _showColorPicker(context);
                },
                child: Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: selectedColor.value, 
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(Icons.color_lens, color: Colors.black54),
                    )),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text;
              String text = textController.text;
              controller.add_Note(title, text, selectedColor.value);
              Get.back();
            },
            child: Text('Add Note'),
          ),
        ],
      ),
    );
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: HueRingPicker(
              pickerColor: selectedColor.value, 
              onColorChanged: (Color color) {
                selectedColor.value = color; 
              },
              enableAlpha: false,
              displayThumbColor: true,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Select'),
              onPressed: () {
                Get.back(); 
              },
            ),
          ],
        );
      },
    );
  }
}
