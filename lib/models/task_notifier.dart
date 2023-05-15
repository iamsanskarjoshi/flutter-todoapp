import 'package:flutter/material.dart';
import 'package:todowithprovider/db/db_provider.dart';
import '../models/task.dart';
import 'dart:collection';

class TaskNotifier extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCounter {
    return _tasks.length;
  }

  Future<void> addTask(String newTaskTitle) async {
    Task newTask = Task(task: newTaskTitle, id: null);
    try {
      int id = await DatabaseProvider.instance.insertTask(newTask.toMap());
      newTask.id = id;
      readTask();
    } catch (e) {
      print(e);
    }
  }

  void updateCheckBox(Task task) {
    task.isToggleDone();
    notifyListeners();
  }

  Future<void> deleteTask(Task task) async {
    await DatabaseProvider.instance.deleteTask(task.id!);
    readTask();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseProvider.instance.updateTask(task.toMap());
    readTask();
  }

  Future<void> readTask() async {
    List<Map<String, dynamic>> readTask =
        await DatabaseProvider.instance.queryTask();

    _tasks = readTask.map((e) => Task.fromMap(e)).toList();
    notifyListeners();
  }
}
