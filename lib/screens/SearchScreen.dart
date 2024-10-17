import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/controllers/data_controller.dart';
import 'package:notepad/screens/components/TextCard.dart'; 

class SearchScreen extends StatelessWidget {
  final DataController controller = Get.find<DataController>();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(27, 255, 255, 255),
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
                    icon: Icon(Icons.arrow_back, color: Colors.white70),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(color: Colors.white),
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
                    icon: Icon(Icons.search, color: Colors.white70),
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
                    return TextCard(
                      note: note,
                      onDelete: () {
                        controller.del_Note(index);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}