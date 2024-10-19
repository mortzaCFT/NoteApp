import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/controllers/data_controller.dart';
import 'package:notepad/controllers/theme_controller.dart';
import 'package:notepad/screens/components/TextCard.dart';

class SearchScreen extends StatelessWidget {
  final DataController controller = Get.find<DataController>();
  final TextEditingController searchController = TextEditingController();
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
            children: [
              Row(
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
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back, color: textColor),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: textColor),
                      decoration: InputDecoration(
                        hintText: "Search by title or text",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        controller.updateSearchResults(searchController.text);
                      },
                      icon: Icon(Icons.search, color: textColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  final filteredNotes = controller.filteredNotes;

                  return ListView.builder(
                    itemCount: filteredNotes.length,
                    itemBuilder: (context, index) {
                      final note = filteredNotes[index];
                      return Dismissible(
                        key: Key(note.id), // Use note.id for the key
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
                          controller.del_Note(note.id); // Pass id to delete
                        },
                        child: TextCard(
                          note: note,
                          onDelete: () {
                            controller.del_Note(note.id); // Pass id to delete
                          },
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
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
