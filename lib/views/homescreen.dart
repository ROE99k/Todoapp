import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoprovider/controllers/todoprovider.dart';
import 'package:todoprovider/models/todo.dart';
import 'package:todoprovider/views/add_or_update.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoprovider = Provider.of<ToDoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: const Color.fromARGB(255, 182, 217, 245),
      ),
      // put FAB inside Scaffold.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddUpdateTodoScreen(false)),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoprovider.todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todoprovider.todos[index].tittle),
            subtitle: Text(todoprovider.todos[index].description),
            trailing: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        todoprovider.delete(index);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AddUpdateTodoScreen(
                                    true,
                                    indexedNo: index,
                                  )),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _addTask(BuildContext context) {
    // Prompt user to enter a task
    final todoprovider = Provider.of<ToDoProvider>(context);
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController descriptioncontroller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titlecontroller,
              decoration: InputDecoration(
                labelText: 'Enter task',
              ),
            ),
            TextFormField(
              controller: descriptioncontroller,
              decoration: InputDecoration(
                labelText: 'Enter description',
              ),
            ),
          ],
        ),
        actions: [
          MaterialButton(
            child: Text('Add'),
            onPressed: () {
              ToDo todo =
                  ToDo(titlecontroller.text, descriptioncontroller.text);
              todoprovider.addtodo(todo);
            },
          ),
        ],
      ),
    );
  }
}
