import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/provider/todo_provider.dart';
import 'package:todo_application/widgets/my_app_button.dart';
import 'package:todo_application/widgets/my_app_snakbar.dart';
import 'package:todo_application/widgets/my_app_text_field.dart';

class AddTodoScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final int? index;
  final int? id;
  final bool isEdit;
  const AddTodoScreen({
    super.key,
    this.title,
    this.description,
    this.index,
    this.id,
    this.isEdit = false,
  });

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController titleContoller = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
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
          widget.isEdit ? 'Edit Task' : 'Add Task',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.navigate_before),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyAppTextField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                label: 'Title',
                minLines: 1,
                maxLines: 1,
                controller: titleContoller,
              ),
              MyAppTextField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                label: 'Description',
                minLines: 4,
                maxLines: 4,
                controller: descriptionController,
              ),
              Consumer<TodoProvider>(
                builder: (context, todoProvider, child) {
                  return MyAppButton(
                    label: widget.isEdit ? 'Update' : 'Add',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (widget.isEdit) {
                          todoProvider.updateTodo(
                            index: widget.index!,
                            id: widget.id!,
                            title: titleContoller.text,
                            description: descriptionController.text,
                            context: context,
                          );
                          MyAppSnakbar.show(
                            context,
                            'Task updated successfully!',
                          );
                        } else {
                          final newId = DateTime.now().millisecondsSinceEpoch;
                          todoProvider.addTodo(
                            newId,
                            titleContoller.text,
                            descriptionController.text,
                            context,
                          );
                          MyAppSnakbar.show(
                            context,
                            'Task added successfully!',
                          );
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
