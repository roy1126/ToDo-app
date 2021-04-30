import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/model/checkbox_model.dart';
import 'package:todo_app/model/task_model.dart';

class MainController extends GetxController {
  Task currentTask;
  final List<Color> colors = [
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.indigo,
    Colors.yellow,
    Colors.grey,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.indigo,
    Colors.yellow,
    Colors.grey,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Colors.green,
    Colors.brown,
    Colors.orange,
    Colors.indigo,
    Colors.yellow,
    Colors.grey,
  ];
  List<Task> tasks = [
    Task(
      id: 1,
      title: 'First',
      list: [
        ToDoCheckbox(
          label: 'Singing',
          value: true,
        ),
        ToDoCheckbox(
          label: 'Dancing',
          value: false,
        ),
        ToDoCheckbox(
          label: 'Meeting',
          value: false,
        ),
      ],
    ),
    Task(
      id: 2,
      title: 'Second',
      list: [
        ToDoCheckbox(label: 'Read', value: true),
        ToDoCheckbox(label: 'Jogging every morning', value: false)
      ],
    ),
    Task(
      id: 1,
      title: 'First',
      list: [
        ToDoCheckbox(
          label: 'Clean the room',
          value: true,
        ),
        ToDoCheckbox(
          label: 'Walking',
          value: false,
        ),
        ToDoCheckbox(
          label: 'Basketball',
          value: false,
        ),
        ToDoCheckbox(
          label: 'Reviewing',
          value: false,
        ),
      ],
    ),
  ].obs;

  int getAllTrue(Task task) {
    return task.list.where((e) => e.value == true).length;
  }

  List<Task> finalTask() {
    return tasks.reversed.toList();
  }

  void replaceCurrentTask(Task task) {
    currentTask = task;
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  void editTitleTask(Task task, String value) {
    task.title = value;
  }

  void editToDoTask(ToDoCheckbox todo, String value) {
    todo.label = value;
  }

  void addToListOfTask(ToDoCheckbox todo) {
    currentTask.list.add(todo);
  }
}
