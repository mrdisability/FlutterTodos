import 'package:flutter/material.dart';
import 'package:flutter_todos/models/todos.dart';
import 'package:flutter_todos/services/api_service.dart';

import 'editdatawidget.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget(this.todos);

  final Todos todos;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  _DetailWidgetState();

  final ApiService api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Card(
              child: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 440,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Todo:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.todos.todo,
                                style: Theme.of(context).textTheme.subtitle1)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Completed:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(widget.todos.completed.toString(),
                                style: Theme.of(context).textTheme.subtitle1)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            RaisedButton(
                              splashColor: Colors.red,
                              onPressed: () {
                                _navigateToEditScreen(context, widget.todos);
                              },
                              child: const Text('Edit',
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.blue,
                            ),
                            RaisedButton(
                              splashColor: Colors.red,
                              onPressed: () {
                                _confirmDialog();
                              },
                              child: const Text('Delete',
                                  style: TextStyle(color: Colors.white)),
                              color: Colors.blue,
                            )
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }

  _navigateToEditScreen(BuildContext context, Todos todos) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataWidget(todos)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                api.deleteTodo(widget.todos.id);
                Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName));
              },
            ),
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
