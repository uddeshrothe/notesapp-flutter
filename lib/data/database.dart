import 'package:hive_flutter/hive_flutter.dart';

class toDoDatabase {
  List toDoList = [];

  //Reference the box
  final _myBox = Hive.box('myBox');

  //Runs only when user opens it for first time
  void createInitialData() {
    toDoList = [
      ['First task', false],
      ['Second task', true]
    ];
  }

  //Load data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  // Update the database
  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
