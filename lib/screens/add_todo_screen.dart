import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/todo_provider.dart';
import 'package:todo_application/widgets/my_app_button.dart';
import 'package:todo_application/widgets/my_app_text_field.dart';

class AddTodoScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final bool isEdit;
  const AddTodoScreen({
    super.key,
    this.title,
    this.description,
    this.isEdit = false,
  });

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController titleContoller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      if (widget.title!.isNotEmpty && widget.description!.isNotEmpty) {
        titleContoller.text = widget.title ?? '';
        descriptionController.text = widget.description ?? '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
          widget.isEdit ? 'Edit Todo' : 'Add Todo',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.navigate_before),
        ),
      ),
      body: Column(
        children: [
          MyAppTextField(
            label: 'Title',
            minLines: 1,
            maxLines: 1,
            controller: titleContoller,
          ),
          MyAppTextField(
            label: 'Description',
            minLines: 4,
            maxLines: 4,
            controller: descriptionController,
          ),
          Consumer<TodoProvider>(
            builder: (context, todoProvider, child) {
              return MyAppButton(
                label: widget.isEdit ? 'Edit Todo' : 'Add Todo',
                onPressed: () {
                  todoProvider.addTodo(
                  0,
                    titleContoller.text,
                    descriptionController.text,
                    context,
                  );
                  debugPrint(
                    'Title: ${titleContoller.text}, Description: ${descriptionController.text}',
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
