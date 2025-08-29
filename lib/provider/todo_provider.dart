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

  // Add the todo
  void addTodo(
    final int id,
    final String title,
    final String description,
    BuildContext context,
  ) {
    setLoading(true);
    final todo = TodoModel(id: id, title: title, description: description);
    _todos.add(todo);
    box.add(todo);
    setLoading(false);
    Navigator.pop(context);
  }

  // Update todo
void updateTodo({
  required int index,
  required int id,
  required String title,
  required String description,
  required BuildContext context,
}) async {
  setLoading(true);
  final updatedTodo = TodoModel(id: id, title: title, description: description);

  // Update in-memory list
  _todos[index] = updatedTodo;

  // Update Hive by key
  final key = box.keyAt(index);
  await box.put(key, updatedTodo);

  setLoading(false);
  Navigator.pop(context);
}

  // Delete todo
  void deleteTodo(int index) async {
    setLoading(true);
    final key = box.keyAt(index);

    await box.delete(key);
    _todos.removeAt(index);

    setLoading(false);
  }
}
