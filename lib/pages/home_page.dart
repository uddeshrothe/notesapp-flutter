import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/data/database.dart';
import 'package:notesapp/utilities/dialog_box.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Reference the hive box
  final _myBox = Hive.box('myBox');
  toDoDatabase db = toDoDatabase();

  late FToast fToast;
  @override
  void initState() {
    // For first time opening the app, then load default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    fToast = FToast();
    fToast.init(context);

    super.initState();
  }

  final _controller = TextEditingController();

  //task status
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.lime[100],
    ),
    child: Text("Task name is missing!"),
  );

  //Save task
  void saveNewTask() {
    setState(() {
      if (_controller.text.isNotEmpty) {
        db.toDoList.add([_controller.text, false]);
      } else {
        fToast.showToast(
          child: toast,
        );
        _controller.clear();
      }
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  //create new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  //delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[50],
      drawer: Drawer(
        backgroundColor: Colors.lime[50],
        child: ListView(
          children: [
            DrawerHeader(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    opacity: .8,
                    image: AssetImage('lib/icons/taskit2.png'),
                  ),
                ),
                child: const Text(
                  '',
                  style: TextStyle(color: Colors.lime),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              iconColor: Colors.black,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              iconColor: Colors.black,
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationName: 'Task it',
                    applicationIcon: Image.asset('lib/icons/taskit3.png'),
                    applicationVersion: '1.0',
                    applicationLegalese: 'Keep track of tasks');
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.lime,
        title: const Text(
          'TASK IT',
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontFamily: 'SourceCodePro',
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lime,
        foregroundColor: Colors.black,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: db.toDoList.isEmpty
          ? Scaffold(
              backgroundColor: Colors.lime[50],
              body: const Center(
                child: Text(
                  "Add tasks!!",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w100),
                ),
              ),
            )
          : ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: db.toDoList[index][0],
                  taskCompleted: db.toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
    );
  }
}
