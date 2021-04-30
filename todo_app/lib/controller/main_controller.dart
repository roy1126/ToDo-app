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
          id: 1,
          label: 'Singing',
          value: true,
        ),
        ToDoCheckbox(
          id: 2,
          label: 'Dancing',
          value: false,
        ),
        ToDoCheckbox(
          id: 3,
          label: 'Meeting',
          value: false,
        ),
      ],
    ),
    Task(
      id: 2,
      title: 'Second',
      list: [
        ToDoCheckbox(id: 4, label: 'Read', value: true),
        ToDoCheckbox(id: 5, label: 'Jogging every morning', value: false)
      ],
    ),
    Task(
      id: 3,
      title: 'Third',
      list: [
        ToDoCheckbox(
          id: 6,
          label: 'Clean the room',
          value: true,
        ),
        ToDoCheckbox(
          id: 7,
          label: 'Walking',
          value: false,
        ),
        ToDoCheckbox(
          id: 8,
          label: 'Basketball',
          value: false,
        ),
        ToDoCheckbox(
          id: 9,
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

  void deleteTaskFromList(ToDoCheckbox todo) {
    currentTask.list.removeWhere((element) => element.id == todo.id);
  }

  void deleteWholeTask(Task task) {
    tasks.removeWhere((element) => element.id == task.id);
  }
}
