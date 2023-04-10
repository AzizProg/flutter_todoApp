import 'package:flutter/material.dart';
import '../model/todoModel.dart';

class TodoItem extends StatelessWidget {
  TodoItem(
      {required this.todo,
      required this.onTodoChanged,
      required this.removeTodo})
      : super(key: ObjectKey(todo));

  //CallBack function
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) removeTodo;

  final Todo todo;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;
    return const TextStyle(
      color: Colors.black,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          onTodoChanged(todo);
        },
        leading: Checkbox(
          checkColor: Colors.greenAccent,
          activeColor: Colors.red,
          value: todo.completed,
          onChanged: (value) => onTodoChanged(todo),
        ),
        title: Row(
          children: <Widget>[
            Expanded(
                child: Text(todo.name, style: _getTextStyle(todo.completed))),
            IconButton(
                onPressed: () {
                  removeTodo(todo);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
                iconSize: 30,
                alignment: Alignment.centerRight)
          ],
        ));
  }
}
