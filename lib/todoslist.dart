import 'package:flutter/material.dart';

import 'detailwidget.dart';
import 'models/todos.dart';

class TodosList extends StatelessWidget {
  final List<Todos> todos;
  TodosList({required Key key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: todos == null ? 0 : todos.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailWidget(todos[index])),
              );
            },
            child: ListTile(
              leading: const Icon(Icons.person),
              title: Text(todos[index].todo),
              subtitle: Text(todos[index].completed.toString()),
            ),
          ));
        });
  }
}
