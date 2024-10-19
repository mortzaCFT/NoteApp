import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/controllers/data_controller.dart';
import 'package:notepad/controllers/theme_controller.dart';
import 'package:notepad/screens/EditScreen.dart';
import 'package:notepad/screens/SearchScreen.dart';
import 'package:notepad/screens/components/AddNew.dart';
import 'package:notepad/screens/components/TextCard.dart';

class HomeScreen extends StatelessWidget {
  final DataController controller = Get.put(DataController());
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Color scaffoldColor = themeController.isDarkMode.value
          ? Colors.white
          : Color.fromARGB(27, 255, 255, 255);
      Color textColor =
          themeController.isDarkMode.value ? Colors.black : Colors.white;

      return Scaffold(
        backgroundColor: scaffoldColor,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        themeController.toggleTheme();
                      },
                      icon: Icon(Icons.nightlight_round_sharp, color: textColor),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.to(SearchScreen());
                      },
                      icon: Icon(Icons.search, color: textColor),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Obx(() {
                 
                  var sortedNotes = controller.data.toList()
                    ..sort((a, b) => b.dateCreated.compareTo(a.dateCreated));

                  return ListView.builder(
                    itemCount: sortedNotes.length,
                    itemBuilder: (context, index) {
                      final note = sortedNotes[index];

                      return Dismissible(
                        key: Key(note.id), 
                        direction: DismissDirection.horizontal,
                        background: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        secondaryBackground: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        confirmDismiss: (direction) async {
                          bool shouldDelete = await _showDeleteDialog();
                          return shouldDelete;
                        },
                        onDismissed: (direction) {
                          controller.del_Note(note.id); 
                        },
                        child: GestureDetector(
                          onTap: () {
                           
                            Get.to(EditScreen(noteId: note.id));
                          },
                          child: TextCard(
                            note: note,
                            onDelete: () {
                              controller.del_Note(note.id); 
                            },
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple.shade900,
          onPressed: () {
            Get.bottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.black,
              AddNew(controller: controller),
            );
          },
          child: Icon(Icons.add_sharp, color: Colors.white),
        ),
      );
    });
  }

  Future<bool> _showDeleteDialog() async {
    bool? result = await Get.defaultDialog<bool>(
      backgroundColor: Colors.black26,
      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
      title: "Delete Note",
      titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      titleStyle: TextStyle(color: Colors.white),
      middleText: "Are you sure you want to delete this note?",
      middleTextStyle: TextStyle(color: Colors.white),
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      onCancel: () => Get.back(result: false),
      onConfirm: () => Get.back(result: true),
      barrierDismissible: false,
    );

    return result ?? false;
  }
}
