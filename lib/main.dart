import 'package:flutter/material.dart';
import 'package:todo_application/core/theme.dart';
import 'package:todo_application/screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'Flutter Demo', home: TodoListScreen());
  }
}
