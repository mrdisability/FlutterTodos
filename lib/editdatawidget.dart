import 'package:flutter/material.dart';
import 'package:flutter_todos/services/api_service.dart';

import 'models/todos.dart';

class EditDataWidget extends StatefulWidget {
  EditDataWidget(this.todos);

  final Todos todos;

  @override
  _EditDataWidgetState createState() => _EditDataWidgetState();
}

class _EditDataWidgetState extends State<EditDataWidget> {
  _EditDataWidgetState();

  final ApiService api = ApiService();
  final _addFormKey = GlobalKey<FormState>();
  String id = '';
  final _todoController = TextEditingController();

  var isChecked = false;

  @override
  void initState() {
    id = widget.todos.id!;
    _todoController.text = widget.todos.todo;
    isChecked = widget.todos.completed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit todos'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
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
                              const Text('Todo'),
                              TextFormField(
                                controller: _todoController,
                                decoration: const InputDecoration(
                                  hintText: 'Todo',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter todo';
                                  }
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Text("Completed"),
                            Checkbox(
                              checkColor: Colors.white,
                              value: isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  isChecked = value!;
                                });
                              },
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () {
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState!.save();
                                    api.updateTodos(
                                        id,
                                        Todos(
                                            todo: _todoController.text,
                                            completed: isChecked));

                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Save',
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
      ),
    );
  }
}
