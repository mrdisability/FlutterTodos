import 'dart:ffi';

class Todos {
  final String? id;
  final String todo;
  final bool completed;

  Todos({this.id, required this.todo, required this.completed});

  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
      id: json['id'] as String,
      todo: json['todo'] as String,
      completed: json['completed'] as bool,
    );
  }

  @override
  String toString() {
    return 'Todos{id: $id, todo: $todo, completed: $completed}';
  }
}
