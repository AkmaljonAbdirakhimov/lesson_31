import 'package:lesson_31/models/todo.dart';

class TodosController {
  final List<Todo> _todos = [
    Todo(title: "Go shopping", isDone: false),
    Todo(title: "Sleep", isDone: false),
  ];

  List<Todo> get todos {
    return List.unmodifiable(_todos);
  }

  void toggleTodo(int index) {
    _todos[index].isDone = !_todos[index].isDone;
  }

  void delete(int index) {
    _todos.removeAt(index);
  }

  void addTodo(String title) {
    Todo newTodo = Todo(title: title, isDone: false);
    _todos.add(newTodo);
  }
}
