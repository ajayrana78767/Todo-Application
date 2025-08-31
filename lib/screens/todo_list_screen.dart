import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/feature/core/network/dio_client.dart';
import 'package:todo_application/feature/data/repositories/history_repository.dart';
import 'package:todo_application/feature/presentation/screens/character_screen.dart';
import 'package:todo_application/feature/presentation/screens/history_screen.dart';
import 'package:todo_application/provider/todo_provider.dart';
import 'package:todo_application/screens/add_todo_screen.dart';
import 'package:todo_application/widgets/task_card.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
          'My Tasks',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (todoProvider.todos.isEmpty) {
            return Center(child: Text('No task found'));
          }
          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              final todo = todoProvider.todos[index];
              return TaskCard(
                index: index,
                title: todo.title,
                description: todo.description,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTodoScreen(
                        title: todo.title,
                        description: todo.description,
                        index: index,
                        id: todo.id,
                        isEdit: true,
                      ),
                    ),
                  );
                },
                onDelete: () {
                  todoProvider.deleteTodo(index);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'addTaskBtn',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTodoScreen()),
              );
            },
            child: Icon(Icons.add),
          ),
          SizedBox(height: 24),
          FloatingActionButton(
            heroTag: 'historyBtn',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(
                    historyRepository: HistoryRepository(DioClient()),
                  ),
                ),
              );
            },
            child: Icon(Icons.history),
          ),
          SizedBox(height: 24),
          FloatingActionButton(
            heroTag: 'charactersBtn',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CharacterScreen()),
              );
            },
            child: Icon(Icons.emoji_emotions_outlined),
          ),
        ],
      ),
    );
  }
}
