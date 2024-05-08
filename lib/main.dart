import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lesson_31/controllers/todos_controller.dart';
import 'package:lesson_31/models/todo.dart';
import 'package:lesson_31/widgets/todo_item.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

void calculate() {
  for (var i = 0; i < 10000000000; i++) {}
  print("Ish tugadi");
}

class _MyAppState extends State<MyApp> {
  TextEditingController titleController = TextEditingController();
  TodosController todosController = TodosController();
  int? selectedItem = null;

  void toggleTodo(int index) {
    setState(() {
      todosController.toggleTodo(index);
    });
  }

  void delete(int index) {
    setState(() {
      todosController.delete(index);
    });
  }

  void addTodo() {
    if (titleController.text.trim().isEmpty) {
      return;
    }
    setState(() {
      String title = titleController.text;
      todosController.addTodo(title);
      titleController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> todos = todosController.todos;

    return Scaffold(
      backgroundColor: Colors.grey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("My Todo App"),
        actions: [
          // OutlinedButton(
          //   onPressed: () async {
          //     print("Ish boshlandi");
          //     await Isolate.run(calculate);
          //     print("Bosh ishlar");
          //     // calculate();
          //   },
          //   child: const Text("Outlined Button"),
          // ),
          PopupMenuButton(itemBuilder: (ctx) {
            return [
              PopupMenuItem(
                onTap: () {
                  print("Profile");
                },
                child: Text("Profile"),
              ),
              PopupMenuItem(
                onTap: () {
                  print("Settings");
                },
                child: Text("Settings"),
              ),
              PopupMenuItem(
                onTap: () {
                  print("Logout");
                },
                child: Text("Logout"),
              ),
            ];
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              children: [
                DropdownButton(
                  dropdownColor: Colors.amber,
                  menuMaxHeight: 150,
                  isDense: true,
                  hint: const Text("Meva tanlang"),
                  value: selectedItem,
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text("Olma"),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text("Behi"),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text("Qulpnay"),
                    ),
                    DropdownMenuItem(
                      value: 3,
                      child: Text("Olma"),
                    ),
                    DropdownMenuItem(
                      value: 4,
                      child: Text("Behi"),
                    ),
                    DropdownMenuItem(
                      value: 5,
                      child: Text("Qulpnay"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedItem = value;
                    });
                  },
                ),
                GestureDetector(
                  onVerticalDragDown: (details) {
                    print(details);
                  },
                  onTap: () {
                    print("on Tap");
                  },
                  onDoubleTap: () {
                    print("Double tap");
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Text("Click"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: titleController,
                  onSubmitted: (value) {
                    addTodo();
                  },
                  decoration: const InputDecoration(
                    label: Text("Title"),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    addTodo();
                  },
                  // onLongPress: () {
                  //   print("Longpressed");
                  // },
                  // onHover: (value) {
                  //   print(value);
                  // },
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Colors.blue,
                    ),
                    fixedSize: const MaterialStatePropertyAll(
                      Size(300, 50),
                    ),
                    shape: const MaterialStatePropertyAll(
                      RoundedRectangleBorder(),
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.amber),
                    splashFactory: InkRipple.splashFactory,
                  ),
                  child: const Text(
                    "Add Todo",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                for (var i = 0; i < todos.length; i++)
                  TodoItem(
                    title: todos[i].title,
                    isDone: todos[i].isDone,
                    index: i,
                    toggleTodo: toggleTodo,
                    delete: delete,
                  ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      // Shadow for top-left corner
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(10, 10),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                      // Shadow for bottom-right corner
                      BoxShadow(
                        color: Colors.white12,
                        offset: Offset(-10, -10),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
