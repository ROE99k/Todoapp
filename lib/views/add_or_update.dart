import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider/controllers/todoprovider.dart';
import 'package:todoprovider/models/todo.dart';

class AddUpdateTodoScreen extends StatelessWidget {
  final bool isUpdated;
  final int indexedNo;
  AddUpdateTodoScreen(this.isUpdated, {this.indexedNo = 0});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<ToDoProvider>(context);
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    ToDo todo = ToDo("", "");

    if (isUpdated) {
      todo = todoProvider.todos[indexedNo];
      titleController.text = todo.tittle; // Corrected typo
      descriptionController.text = todo.description;
    }

    return Scaffold(
      appBar: AppBar(
        title: isUpdated ? Text('Update Todo') : Text("Add To Do"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Enter task',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task title is required';
                }
                return null;
              },
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Enter description',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Task description is required';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (isUpdated) {
                      ToDo updatedTodo = ToDo(
                        titleController.text,
                        descriptionController.text,
                      );
                      todoProvider.updatetodo(indexedNo, updatedTodo);
                    } else {
                      ToDo newTodo = ToDo(
                        titleController.text,
                        descriptionController.text,
                      );
                      todoProvider.addtodo(newTodo);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
