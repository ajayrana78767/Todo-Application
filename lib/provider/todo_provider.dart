import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_application/models/todo_model.dart';

class TodoProvider with ChangeNotifier {
  late Box<TodoModel> box;

  TodoProvider() {
    box = Hive.box<TodoModel>('myTodos');
    _todos.addAll(box.values);
  }

  // Setters
  final List<TodoModel> _todos = [];
  bool _isLoading = false;

  // Getters
  List<TodoModel> get todos => _todos;
  bool get isLoading => _isLoading;

  // Set loading
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // // // Fetch the all todos
  // void fetchTodos() {
  //   setLoading(true);
  //   Future.delayed(Duration(seconds: 3));

  // }

  // Add the todos
  void addTodo(
    final String title,
    final String description,
    BuildContext context,
  ) {
    setLoading(true);
    final todo = TodoModel(title: title, description: description);
    _todos.add(todo);
    box.add(todo);
    setLoading(false);
    Navigator.pop(context);
  }
}
