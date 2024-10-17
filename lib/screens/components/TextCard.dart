import 'package:flutter/material.dart';
import 'package:notepad/data/date.dart';

class TextCard extends StatelessWidget {
  const TextCard({
    super.key,
    required this.note,
    required this.onDelete,
  });

  final Data note;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5), 
      decoration: BoxDecoration(
        color: note.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  note.text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete, 
            icon: Icon(Icons.delete_outlined, color: Colors.black),
          ),
        ],
      ),
    );
  }
}