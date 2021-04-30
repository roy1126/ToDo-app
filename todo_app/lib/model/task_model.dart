import 'package:flutter/material.dart';
import 'package:todo_app/model/checkbox_model.dart';

class Task {
  int id;
  String title;
  List<ToDoCheckbox> list;

  Task({@required this.id, @required this.title, this.list});
}
