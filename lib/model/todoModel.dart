// ignore: file_names
import 'package:flutter/material.dart';

class Todo {
  Todo({required this.name, required this.completed})
      : id = UniqueKey().toString();
  String id;
  String name;
  bool completed;
}
