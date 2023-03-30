import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notesapp/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  //Initialize hive
  await Hive.initFlutter();

  //Open a box
  var box = await Hive.openBox('mybox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final ThemeMode _themeMode = ThemeMode.system;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(),
      // darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
    );
  }
}
