import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:notepad/controllers/data_controller.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:io';

class AddNew extends StatelessWidget {
  AddNew({super.key, required this.controller});

  final Rx<Color> selectedColor = Rx<Color>(Colors.blue);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  final DataController controller;

  final RxBool isSignatureMode = false.obs;

  final GlobalKey<SfSignaturePadState> _signatureKey = GlobalKey();

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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  isSignatureMode.value = false;
                },
                child: Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSignatureMode.value
                            ? Colors.grey.shade400
                            : Colors.blueAccent,
                        border: Border.all(
                          color: !isSignatureMode.value
                              ? Colors.white
                              : Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.text_fields,
                        color: !isSignatureMode.value
                            ? Colors.white
                            : Colors.black54,
                      ),
                    )),
              ),
              SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  isSignatureMode.value = true;
                },
                child: Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSignatureMode.value
                            ? Colors.greenAccent
                            : Colors.grey.shade400,
                        border: Border.all(
                          color: isSignatureMode.value
                              ? Colors.white
                              : Colors.black54,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.brush,
                        color: isSignatureMode.value
                            ? Colors.white
                            : Colors.black54,
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(height: 20),
          Obx(() => !isSignatureMode.value
              ? Column(
                  children: [
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
                  ],
                )
              : SfSignaturePad(
                  key: _signatureKey,
                  backgroundColor: Colors.grey[200],
                  strokeColor: Colors.black,
                )),
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
            onPressed: () async {
              if (isSignatureMode.value) {
                final image =
                    await _signatureKey.currentState!.toImage(pixelRatio: 3.0);
                final ByteData? bytes =
                    await image.toByteData(format: ui.ImageByteFormat.png);
                if (bytes != null) {
                  final Uint8List signatureData = bytes.buffer.asUint8List();

                  final directory = await getTemporaryDirectory();
                  final String path =
                      '${directory.path}/signature_${DateTime.now().millisecondsSinceEpoch}.png';

                  final File file = File(path);
                  await file.writeAsBytes(signatureData);

                  controller.add_Note('', '', selectedColor.value, path);
                }
              } else {
                String title = titleController.text;
                String text = textController.text;
                controller.add_Note(title, text, selectedColor.value, null);
              }
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


/* Yeah ,...that was too long...*/
