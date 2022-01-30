import 'package:flutter/material.dart';
import 'package:flutter_todos/services/api_service.dart';
import 'package:flutter_todos/todoslist.dart';

import 'adddatawidget.dart';
import 'models/todos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService api = ApiService();
  List<Todos> todosList = <Todos>[];

  @override
  Widget build(BuildContext context) {
    // if (todosList == null) {
    //   // return const Center(
    //   //   child: CircularProgressIndicator(),
    //   // );
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
        future: loadList(),
        builder: (context, snapshot) {
          if (todosList.isNotEmpty) {
            return TodosList(
              todos: todosList,
              key: const ValueKey(""),
            );
          } else {
            return Center(
                child: Text('No data found, tap plus button to add!',
                    style: Theme.of(context).textTheme.bodyText1));
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future loadList() {
    Future<List<Todos>> futureTodos = api.getTodos();
    futureTodos.then((todosList) {
      setState(() {
        this.todosList = todosList;
      });
    });
    return futureTodos;
  }

  _navigateToAddScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}
