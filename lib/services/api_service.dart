import 'dart:convert';

import 'package:flutter_todos/models/todos.dart';
import 'package:http/http.dart';

class ApiService {
  final String apiUrl = "https://61e281e83050a100176821ca.mockapi.io/todos";

  Future<List<Todos>> getTodos() async {
    Response res = await get(Uri.parse(apiUrl));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Todos> todos =
          body.map((dynamic item) => Todos.fromJson(item)).toList();
      return todos;
    } else {
      throw "Failed to load Todos list";
    }
  }

  Future<Todos> getTodoById(String id) async {
    final response = await get(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      return Todos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a todo');
    }
  }

  Future<Todos> createTodo(Todos todos) async {
    Map data = {'todo': todos.todo, 'completed': todos.completed};

    final Response response = await post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Todos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post Todos');
    }
  }

  Future<Todos> updateTodos(String id, Todos todos) async {
    Map data = {'todo': todos.todo, 'completed': todos.completed};

    final Response response = await put(
      Uri.parse('$apiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Todos.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a Todo');
    }
  }

  Future<void> deleteTodo(String? id) async {
    Response res = await delete(Uri.parse('$apiUrl/$id'));

    if (res.statusCode == 200) {
      print("Todo deleted");
    } else {
      throw "Failed to delete a Todo.";
    }
  }
}
