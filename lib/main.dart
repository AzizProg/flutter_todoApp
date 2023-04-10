import 'package:flutter/material.dart';
import './model/todoModel.dart';
import './views/viewTodo.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoList(title: 'Todo Manager'),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});
  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> _todos = <Todo>[];
  final TextEditingController _textFieldController = TextEditingController();

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, completed: false));
    });
    _textFieldController.clear();
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.completed = !todo.completed;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((element) => element.id == todo.id);
    });
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a todo'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Type de todo'),
              autofocus: true,
            ),
            actions: <Widget>[
              //Cancel Button
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              //Add button
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _addTodoItem(_textFieldController.text);
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _todos.isEmpty
          ? Center(
              child: Text(
                "Aucune tâche existante",
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: _todos.map((Todo todo) {
                return TodoItem(
                  todo: todo,
                  onTodoChanged: _handleTodoChange,
                  removeTodo: _deleteTodo,
                );
              }).toList(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'add task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
