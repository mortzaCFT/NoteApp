import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad/controllers/data_controller.dart';
import 'package:notepad/screens/SearchScreen.dart';
import 'package:notepad/screens/components/AddNew.dart';
import 'package:notepad/screens/components/TextCard.dart';

class HomeScreen extends StatelessWidget {
  final DataController controller = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(27, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 35, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notes",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(onPressed: (){
                      Get.to(SearchScreen());
                  },icon: Icon(Icons.search, color: Colors.white70)),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    final note = controller.data[index];
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
  }
}
