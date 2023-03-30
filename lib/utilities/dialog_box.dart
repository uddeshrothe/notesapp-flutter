import 'package:flutter/material.dart';
import 'package:notesapp/utilities/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({super.key, required this.controller, required this.onSave, required this. onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Add new task')),
      shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 200,
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              maxLength: 60,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lime),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Colors.lime,
                  border: OutlineInputBorder(), hintText: 'Input your task'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(text: 'Save', onPressed: onSave,),
                const SizedBox(
                  width: 8,
                ),
                MyButton(text: 'Cancel', onPressed: onCancel)
              ],
            )
          ],
        ),
      ),
    );
  }
}
