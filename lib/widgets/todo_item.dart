import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final bool isDone;
  final int index;
  final Function(int) toggleTodo;
  final Function(int) delete;

  TodoItem({
    required this.title,
    required this.isDone,
    required this.index,
    required this.toggleTodo,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              tooltip: "IsDone",
              splashRadius: 100,
              splashColor: Colors.green,
              highlightColor: Colors.amber,
              hoverColor: Colors.blue,
              onPressed: () {
                toggleTodo(index);
              },
              icon: Icon(
                isDone ? Icons.check_circle : Icons.circle_outlined,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                decoration: isDone ? TextDecoration.lineThrough : null,
              ),
            ),
          ],
        ),
        PopupMenuButton(
          offset: Offset(100, 100),
          itemBuilder: (ctx) {
            return [
              PopupMenuItem(
                onTap: () {
                  delete(index);
                },
                child: PopupMenuButton(itemBuilder: (ctx) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        delete(index);
                      },
                      child: Text("Delete"),
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
          },
        ),
        // TextButton(
        //   onPressed: () {
        //     delete(index);
        //   },
        //   child: const Text(
        //     "delete",
        //     style: TextStyle(
        //       color: Colors.red,
        //       fontSize: 16,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
